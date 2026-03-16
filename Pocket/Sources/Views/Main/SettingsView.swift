import SwiftUI

struct SettingsView: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                HStack {
                    Text("Settings")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(.top, 16)

                // Profile Section
                ProfileSectionView()

                // Wallets Section
                WalletsSectionView()

                // Preferences Section
                PreferencesSectionView()

                // About Section
                AboutSectionView()

                // Logout Button
                Button(action: {
                    authViewModel.logout()
                }, label: {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 16))
                        Text("Log Out")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(.pocketRed)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color.pocketRed.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(Color.pocketRed.opacity(0.3), lineWidth: 1)
                            )
                    )
                })

                Spacer().frame(height: 80)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.pocketBackground.ignoresSafeArea())
    }
}

// MARK: - Profile Section
struct ProfileSectionView: View {
    var body: some View {
        VStack(spacing: 0) {
            SettingsGroupHeader(title: "Profile")

            HStack(spacing: 14) {
                Circle()
                    .fill(Color.pocketCyan.opacity(0.2))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.pocketCyan)
                    )

                VStack(alignment: .leading, spacing: 4) {
                    Text("Pocket User")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)

                    Text("Connected via Privy")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.pocketSecondaryText)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.pocketSecondaryText)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.pocketCardBackground)
            )
        }
    }
}

// MARK: - Wallets Section
struct WalletsSectionView: View {
    var body: some View {
        VStack(spacing: 0) {
            SettingsGroupHeader(title: "Wallets")

            VStack(spacing: 1) {
                SettingsRowView(
                    icon: "wallet.pass.fill",
                    iconColor: .pocketCyan,
                    title: "Embedded Wallets",
                    subtitle: "EVM + Solana"
                )
                SettingsRowView(
                    icon: "link",
                    iconColor: .agentStocks,
                    title: "Connected Wallets",
                    subtitle: "None"
                )
                SettingsRowView(
                    icon: "key.fill",
                    iconColor: .agentDefi,
                    title: "Export Private Key",
                    subtitle: nil
                )
            }
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.pocketCardBackground)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

// MARK: - Preferences Section
struct PreferencesSectionView: View {
    var body: some View {
        VStack(spacing: 0) {
            SettingsGroupHeader(title: "Preferences")

            VStack(spacing: 1) {
                SettingsRowView(
                    icon: "bell.fill",
                    iconColor: .agentPredictions,
                    title: "Notifications",
                    subtitle: "Enabled"
                )
                SettingsRowView(
                    icon: "globe",
                    iconColor: .pocketCyan,
                    title: "Network",
                    subtitle: "Mainnet"
                )
                SettingsRowView(
                    icon: "dollarsign.circle.fill",
                    iconColor: .pocketGreen,
                    title: "Currency",
                    subtitle: "USD"
                )
            }
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.pocketCardBackground)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

// MARK: - About Section
struct AboutSectionView: View {
    var body: some View {
        VStack(spacing: 0) {
            SettingsGroupHeader(title: "About")

            VStack(spacing: 1) {
                SettingsRowView(
                    icon: "doc.text.fill",
                    iconColor: .pocketSecondaryText,
                    title: "Privacy Policy",
                    subtitle: nil
                )
                SettingsRowView(
                    icon: "doc.plaintext.fill",
                    iconColor: .pocketSecondaryText,
                    title: "Terms of Service",
                    subtitle: nil
                )
                SettingsRowView(
                    icon: "info.circle.fill",
                    iconColor: .pocketSecondaryText,
                    title: "Version",
                    subtitle: "1.0.0"
                )
            }
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color.pocketCardBackground)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
    }
}

// MARK: - Reusable Components
struct SettingsGroupHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.pocketSecondaryText)
                .textCase(.uppercase)
            Spacer()
        }
        .padding(.bottom, 8)
    }
}

struct SettingsRowView: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String?

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(iconColor)
                .frame(width: 32, height: 32)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(iconColor.opacity(0.12))
                )

            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)

            Spacer()

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.pocketSecondaryText)
            }

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.pocketTertiaryText)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    SettingsView(authViewModel: AuthViewModel())
        .preferredColorScheme(.dark)
}
