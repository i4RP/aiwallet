import SwiftUI
import Combine

class PortfolioViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var portfolio: PortfolioData = .sample
    @Published var assets: [Asset] = Asset.samples
    @Published var wallets: [WalletInfo] = WalletInfo.samples
    @Published var agentDetails: [AgentDetail] = AgentDetail.samples
    @Published var isRefreshing: Bool = false

    // MARK: - Computed Properties
    var totalBalance: Double {
        assets.reduce(0) { $0 + $1.value }
    }

    var activeAgentsCount: Int {
        agentDetails.filter { $0.status == .running }.count
    }

    // MARK: - Actions
    func refreshPortfolio() {
        isRefreshing = true
        // TODO: Integrate with Privy SDK to fetch real wallet balances
        // privy.embeddedWallet.getBalance()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.isRefreshing = false
        }
    }

    func toggleAgent(_ agentDetail: AgentDetail) {
        guard let index = agentDetails.firstIndex(where: { $0.id == agentDetail.id }) else { return }
        let current = agentDetails[index]
        let newStatus: AgentStatus = current.status == .running ? .paused : .running
        agentDetails[index] = AgentDetail(
            agent: current.agent,
            status: newStatus,
            description: current.description,
            profitLoss: current.profitLoss
        )
    }
}
