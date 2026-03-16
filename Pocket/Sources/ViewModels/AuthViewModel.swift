import SwiftUI
import Combine

// MARK: - Login Sheet Page
enum LoginSheetPage {
    case main
    case otherSocials
    case walletSelection
}

// MARK: - Auth State
enum AuthState {
    case unauthenticated
    case authenticating
    case authenticated
}

// MARK: - Wallet Option
struct WalletOption: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let chains: [ChainType]

    enum ChainType {
        case ethereum
        case solana
        case multichain
    }
}

class AuthViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var showLoginSheet = false
    @Published var currentPage: LoginSheetPage = .main
    @Published var authState: AuthState = .unauthenticated
    @Published var emailInput: String = ""
    @Published var isEmailValid: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Wallet Options
    let walletOptions: [WalletOption] = [
        WalletOption(name: "MetaMask", iconName: "metamask", chains: [.ethereum]),
        WalletOption(name: "Coinbase Wallet", iconName: "coinbase", chains: [.ethereum]),
        WalletOption(name: "Rainbow", iconName: "rainbow", chains: [.ethereum]),
        WalletOption(name: "Base", iconName: "base", chains: [.ethereum]),
        WalletOption(name: "1inch Wallet", iconName: "1inch", chains: [.ethereum, .solana])
    ]

    // MARK: - Privy Configuration
    // Configure via environment or Secrets.xcconfig
    private let privyAppId: String = {
        // Load from Info.plist or environment
        Bundle.main.object(forInfoDictionaryKey: "PRIVY_APP_ID") as? String ?? ""
    }()

    // MARK: - Actions
    func showLogin() {
        currentPage = .main
        showLoginSheet = true
    }

    func dismissLogin() {
        showLoginSheet = false
        currentPage = .main
        emailInput = ""
        errorMessage = nil
    }

    func navigateToOtherSocials() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentPage = .otherSocials
        }
    }

    func navigateToWalletSelection() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentPage = .walletSelection
        }
    }

    func navigateBack() {
        withAnimation(.easeInOut(duration: 0.3)) {
            currentPage = .main
        }
    }

    func validateEmail() {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        isEmailValid = predicate.evaluate(with: emailInput)
    }

    // MARK: - Auth Methods (Privy SDK integration points)

    func loginWithMetaMask() {
        isLoading = true
        // TODO: Integrate with Privy SDK
        // privy.externalWallet.connect(provider: .metamask)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }

    func loginWithEmail() {
        guard isEmailValid else { return }
        isLoading = true
        // TODO: Integrate with Privy SDK
        // try await privy.email.sendCode(to: emailInput)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }

    func loginWithGoogle() {
        isLoading = true
        // TODO: Integrate with Privy SDK
        // try await privy.google.login()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }

    func loginWithTwitter() {
        isLoading = true
        // TODO: Integrate with Privy SDK
        // try await privy.twitter.login()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }

    func loginWithDiscord() {
        isLoading = true
        // TODO: Integrate with Privy SDK
        // try await privy.discord.login()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }

    func loginWithTelegram() {
        isLoading = true
        // TODO: Integrate with Privy SDK
        // try await privy.telegram.login()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }

    func connectWallet(_ wallet: WalletOption) {
        isLoading = true
        // TODO: Integrate with Privy SDK
        // privy.externalWallet.connect(provider: wallet)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.isLoading = false
        }
    }
}
