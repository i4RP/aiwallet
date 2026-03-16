import SwiftUI

struct LoginSheetView: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            Color.black.opacity(0.001)
                .ignoresSafeArea()
                .onTapGesture {
                    authViewModel.dismissLogin()
                }

            VStack(spacing: 0) {
                Spacer()

                VStack(spacing: 0) {
                    switch authViewModel.currentPage {
                    case .main:
                        MainLoginContent(authViewModel: authViewModel)
                            .transition(.asymmetric(
                                insertion: .move(edge: .leading).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    case .otherSocials:
                        OtherSocialsContent(authViewModel: authViewModel)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .trailing).combined(with: .opacity)
                            ))
                    case .walletSelection:
                        WalletSelectionContent(authViewModel: authViewModel)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .trailing).combined(with: .opacity)
                            ))
                    }

                    // Footer
                    LoginFooterView()
                }
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.loginSheetBackground)
                )
                .padding(.horizontal, 0)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

// MARK: - Main Login Content
struct MainLoginContent: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 16) {
            // Close button
            HStack {
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

            // Logo
            Text("POCKET")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .tracking(2)

            // Title
            Text("Log in or sign up")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 8)

            // Login Options
            VStack(spacing: 12) {
                // MetaMask
                LoginOptionButton(
                    iconName: "metamask_icon",
                    systemIcon: "globe",
                    title: "MetaMask",
                    showLastUsed: true,
                    showChainIcon: true,
                    action: { authViewModel.loginWithMetaMask() }
                )

                // Email Input
                EmailInputRow(authViewModel: authViewModel)

                // Google
                LoginOptionButton(
                    iconName: "google_icon",
                    systemIcon: "g.circle.fill",
                    title: "Google",
                    isHighlighted: true,
                    action: { authViewModel.loginWithGoogle() }
                )

                // Other socials
                LoginOptionButton(
                    iconName: "socials_icon",
                    systemIcon: "person.circle",
                    title: "Other socials",
                    action: { authViewModel.navigateToOtherSocials() }
                )

                // Continue with a wallet
                LoginOptionButton(
                    iconName: "wallet_icon",
                    systemIcon: "wallet.pass",
                    title: "Continue with a wallet",
                    action: { authViewModel.navigateToWalletSelection() }
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
}

// MARK: - Email Input Row
struct EmailInputRow: View {
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "envelope")
                .font(.system(size: 18))
                .foregroundColor(.pocketSecondaryText)
                .frame(width: 36, height: 36)
                .background(Circle().fill(Color.loginIconBackground))

            TextField("your@email.com", text: $authViewModel.emailInput)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: authViewModel.emailInput) { _ in
                    authViewModel.validateEmail()
                }

            Button(action: { authViewModel.loginWithEmail() }, label: {
                Text("Submit")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(
                        authViewModel.isEmailValid
                            ? .white
                            : .pocketTertiaryText
                    )
            })
            .disabled(!authViewModel.isEmailValid)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.loginButtonBorder, lineWidth: 1)
        )
    }
}

// MARK: - Login Option Button
struct LoginOptionButton: View {
    let iconName: String
    var systemIcon: String = "circle"
    let title: String
    var showLastUsed: Bool = false
    var showChainIcon: Bool = false
    var isHighlighted: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: systemIcon)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.loginIconBackground))

                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Spacer()

                if showLastUsed {
                    Text("Last used")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.pocketSecondaryText)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.loginButtonBackground)
                        )
                }

                if showChainIcon {
                    Image(systemName: "diamond.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(isHighlighted ? Color.loginButtonHighlight : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.loginButtonBorder, lineWidth: 1)
            )
        }
    }
}

// MARK: - Footer
struct LoginFooterView: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 4) {
                Text("By logging in I agree to the")
                    .font(.system(size: 12))
                    .foregroundColor(.pocketSecondaryText)

                Button(action: {
                    // Open Privacy Policy
                }, label: {
                    Text("Privacy Policy")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                })
            }

            HStack(spacing: 6) {
                Text("Protected by")
                    .font(.system(size: 12))
                    .foregroundColor(.pocketTertiaryText)

                Circle()
                    .fill(Color.green)
                    .frame(width: 6, height: 6)

                Text("privy")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.pocketSecondaryText)
            }
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        LoginSheetView(authViewModel: AuthViewModel())
    }
}
