import SwiftUI

struct HomeView: View {
    @ObservedObject var portfolioViewModel: PortfolioViewModel
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                HomeHeaderView()

                // Balance Card
                BalanceCardView(portfolio: portfolioViewModel.portfolio)

                // Quick Actions
                QuickActionsView()

                // Agents Section
                AgentsSectionView(agentDetails: portfolioViewModel.agentDetails) { agent in
                    portfolioViewModel.toggleAgent(agent)
                }

                // Assets Section
                AssetsSectionView(assets: portfolioViewModel.assets)

                // Spacer for tab bar
                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.pocketBackground.ignoresSafeArea())
        .refreshable {
            portfolioViewModel.refreshPortfolio()
        }
    }
}

// MARK: - Home Header
struct HomeHeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("POCKET")
                    .font(.system(size: 24, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(1)

                Text("Your Crypto AI Assistant")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.pocketSecondaryText)
            }

            Spacer()

            // Notification Bell
            Button(action: {
                // TODO: Show notifications
            }, label: {
                Image(systemName: "bell.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.pocketSecondaryText)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color.pocketCardBackground))
            })
        }
        .padding(.top, 16)
    }
}

// MARK: - Balance Card
struct BalanceCardView: View {
    let portfolio: PortfolioData

    var body: some View {
        VStack(spacing: 12) {
            Text("Total Balance")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.pocketSecondaryText)

            Text("$\(String(format: "%.2f", portfolio.balance))")
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            HStack(spacing: 6) {
                Image(systemName: portfolio.isDown ? "arrow.down.right" : "arrow.up.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(portfolio.isDown ? .pocketRed : .pocketGreen)

                Text("\(String(format: "%.1f", portfolio.changePercent))%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(portfolio.isDown ? .pocketRed : .pocketGreen)

                Text("today")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.pocketSecondaryText)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.pocketCardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(Color.pocketCardBorder, lineWidth: 1)
                )
        )
    }
}

// MARK: - Quick Actions
struct QuickActionsView: View {
    var body: some View {
        HStack(spacing: 12) {
            QuickActionButton(icon: "arrow.down", title: "Receive")
            QuickActionButton(icon: "arrow.up", title: "Send")
            QuickActionButton(icon: "arrow.left.arrow.right", title: "Swap")
            QuickActionButton(icon: "plus", title: "Buy")
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String

    var body: some View {
        Button(action: {
            // TODO: Implement action
        }, label: {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.pocketCyan)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(Color.pocketCyan.opacity(0.12))
                    )

                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.pocketSecondaryText)
            }
            .frame(maxWidth: .infinity)
        })
    }
}

// MARK: - Agents Section
struct AgentsSectionView: View {
    let agentDetails: [AgentDetail]
    let onToggle: (AgentDetail) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("AI Agents")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()

                Text("See all")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.pocketCyan)
            }

            ForEach(agentDetails) { detail in
                AgentRowView(agentDetail: detail, onToggle: { onToggle(detail) })
            }
        }
    }
}

struct AgentRowView: View {
    let agentDetail: AgentDetail
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            // Agent Color Circle
            Circle()
                .fill(agentDetail.agent.color)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: agentDetail.agent.icon)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                )

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(agentDetail.agent.name)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)

                    HStack(spacing: 4) {
                        Circle()
                            .fill(agentDetail.status.color)
                            .frame(width: 6, height: 6)

                        Text(agentDetail.status.rawValue)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(agentDetail.status.color)
                    }
                }

                Text(agentDetail.description)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.pocketSecondaryText)
                    .lineLimit(1)
            }

            Spacer()

            // P/L
            VStack(alignment: .trailing, spacing: 2) {
                Text(agentDetail.profitLoss >= 0 ? "+\(String(format: "%.1f", agentDetail.profitLoss))%" : "\(String(format: "%.1f", agentDetail.profitLoss))%")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(agentDetail.profitLoss >= 0 ? .pocketGreen : .pocketRed)

                Button(action: onToggle, label: {
                    Text(agentDetail.status == .running ? "Pause" : "Start")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.pocketCyan)
                })
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.pocketCardBackground)
        )
    }
}

// MARK: - Assets Section
struct AssetsSectionView: View {
    let assets: [Asset]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Assets")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Spacer()

                Text("See all")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.pocketCyan)
            }

            if assets.isEmpty {
                EmptyAssetsView()
            } else {
                ForEach(assets) { asset in
                    AssetRowView(asset: asset)
                }
            }
        }
    }
}

struct AssetRowView: View {
    let asset: Asset

    var body: some View {
        HStack(spacing: 12) {
            // Token Icon
            Circle()
                .fill(asset.chainType == .ethereum ? Color.agentPredictions : Color.agentDefi)
                .frame(width: 40, height: 40)
                .overlay(
                    Text(String(asset.symbol.prefix(1)))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(asset.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)

                Text("\(String(format: "%.4f", asset.balance)) \(asset.symbol)")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.pocketSecondaryText)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(String(format: "%.2f", asset.value))")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)

                HStack(spacing: 3) {
                    Image(systemName: asset.isUp ? "arrow.up.right" : "arrow.down.right")
                        .font(.system(size: 10, weight: .semibold))

                    Text("\(String(format: "%.1f", asset.changePercent))%")
                        .font(.system(size: 12, weight: .medium))
                }
                .foregroundColor(asset.isUp ? .pocketGreen : .pocketRed)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.pocketCardBackground)
        )
    }
}

struct EmptyAssetsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "wallet.pass")
                .font(.system(size: 32))
                .foregroundColor(.pocketSecondaryText)

            Text("No assets yet")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.pocketSecondaryText)

            Text("Your crypto assets will appear here\nonce you receive or buy tokens.")
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.pocketTertiaryText)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.pocketCardBackground)
        )
    }
}

#Preview {
    HomeView(
        portfolioViewModel: PortfolioViewModel(),
        authViewModel: AuthViewModel()
    )
    .preferredColorScheme(.dark)
}
