import SwiftUI

struct WalletSelectionContent: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var searchText: String = ""

    private var filteredWallets: [WalletOption] {
        if searchText.isEmpty {
            return authViewModel.walletOptions
        }
        return authViewModel.walletOptions.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            // Navigation bar
            HStack {
                Button(action: { authViewModel.navigateBack() }, label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.pocketSecondaryText)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(Color.loginButtonBackground))
                })

                Spacer()

                Button(action: { authViewModel.dismissLogin() }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.pocketSecondaryText)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(Color.loginButtonBackground))
                })
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            // Wallet icon
            Image(systemName: "wallet.pass")
                .font(.system(size: 28))
                .foregroundColor(.pocketSecondaryText)
                .frame(width: 56, height: 56)
                .background(Circle().fill(Color.loginButtonBackground))

            // Title
            Text("Select your wallet")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 4)

            // Search field
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundColor(.pocketSecondaryText)
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(Color.loginIconBackground))

                TextField(
                    "Search through \(authViewModel.walletOptions.count) wallets",
                    text: $searchText
                )
                .font(.system(size: 15))
                .foregroundColor(.white)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.loginButtonHighlight)
            )
            .padding(.horizontal, 20)

            // Wallet list
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(filteredWallets) { wallet in
                        WalletRowButton(wallet: wallet) {
                            authViewModel.connectWallet(wallet)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .frame(maxHeight: 320)
            .padding(.bottom, 16)
        }
    }
}

// MARK: - Wallet Row Button
struct WalletRowButton: View {
    let wallet: WalletOption
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                walletIcon

                Text(wallet.name)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Spacer()

                chainIcons
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.loginButtonBorder, lineWidth: 1)
            )
        }
    }

    @ViewBuilder
    private var walletIcon: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(walletIconColor)
                .frame(width: 36, height: 36)

            Text(String(wallet.name.prefix(1)))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
        }
    }

    private var walletIconColor: Color {
        switch wallet.name {
        case "MetaMask":
            return Color(red: 0.88, green: 0.56, blue: 0.20)
        case "Coinbase Wallet":
            return Color(red: 0.20, green: 0.40, blue: 0.95)
        case "Rainbow":
            return Color(red: 0.95, green: 0.50, blue: 0.20)
        case "Base":
            return Color(red: 0.20, green: 0.33, blue: 1.0)
        default:
            return Color.loginIconBackground
        }
    }

    @ViewBuilder
    private var chainIcons: some View {
        HStack(spacing: 4) {
            ForEach(wallet.chains.indices, id: \.self) { index in
                switch wallet.chains[index] {
                case .ethereum:
                    Image(systemName: "diamond.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.blue)
                case .solana:
                    Image(systemName: "circle.hexagongrid.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.purple)
                case .multichain:
                    Image(systemName: "circle.grid.2x2.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            Spacer()
            WalletSelectionContent(authViewModel: AuthViewModel())
                .background(Color.loginSheetBackground)
        }
    }
}
