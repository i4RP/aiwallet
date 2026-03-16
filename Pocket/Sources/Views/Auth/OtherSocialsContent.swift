import SwiftUI

struct OtherSocialsContent: View {
    @ObservedObject var authViewModel: AuthViewModel

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

            // Title
            Text("Log in or sign up")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .padding(.top, 8)
                .padding(.bottom, 8)

            // Social Options
            VStack(spacing: 12) {
                // Twitter / X
                SocialLoginButton(
                    systemIcon: "xmark",
                    title: "Twitter",
                    iconBackground: Color.white,
                    iconForeground: Color.black,
                    action: { authViewModel.loginWithTwitter() }
                )

                // Discord
                SocialLoginButton(
                    systemIcon: "message.fill",
                    title: "Discord",
                    iconBackground: Color(red: 0.34, green: 0.40, blue: 0.95),
                    iconForeground: .white,
                    action: { authViewModel.loginWithDiscord() }
                )

                // Telegram
                SocialLoginButton(
                    systemIcon: "paperplane.fill",
                    title: "Telegram",
                    iconBackground: Color(red: 0.40, green: 0.67, blue: 0.88),
                    iconForeground: .white,
                    action: { authViewModel.loginWithTelegram() }
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
    }
}

// MARK: - Social Login Button
struct SocialLoginButton: View {
    let systemIcon: String
    let title: String
    var iconBackground: Color = .loginIconBackground
    var iconForeground: Color = .white
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: systemIcon)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(iconForeground)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(iconBackground))

                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.loginButtonBorder, lineWidth: 1)
            )
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            Spacer()
            OtherSocialsContent(authViewModel: AuthViewModel())
                .background(Color.loginSheetBackground)
        }
    }
}
