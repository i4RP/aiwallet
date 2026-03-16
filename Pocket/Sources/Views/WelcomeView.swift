import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    @State private var showContent = false
    
    var body: some View {
        ZStack {
            // Background
            Color.pocketBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 20)
                
                // Logo Section
                PocketLogoView()
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : -20)
                    .animation(.easeOut(duration: 0.6).delay(0.2), value: showContent)
                
                Spacer()
                    .frame(height: 24)
                
                // Carousel Cards
                CarouselCardContainer(viewModel: viewModel)
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1 : 0.95)
                    .animation(.easeOut(duration: 0.6).delay(0.4), value: showContent)
                
                Spacer()
                
                // Bottom Section
                VStack(spacing: 16) {
                    // Get Started Button
                    Button(action: {
                        authViewModel.showLogin()
                    }, label: {
                        Text("Get started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                Capsule()
                                    .fill(Color.pocketCyan)
                            )
                    })
                    .padding(.horizontal, 40)
                    .opacity(showContent ? 1 : 0)
                    .offset(y: showContent ? 0 : 20)
                    .animation(.easeOut(duration: 0.6).delay(0.6), value: showContent)
                    
                    // Terms & Conditions
                    VStack(spacing: 4) {
                        Text("By continuing you agree to our")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.pocketSecondaryText)
                        
                        Button(action: {
                            // Handle terms action
                        }, label: {
                            Text("Terms & Conditions")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.pocketCyan)
                                .underline()
                        })
                    }
                    .opacity(showContent ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.8), value: showContent)
                }
                .padding(.bottom, 24)
            }
        }
        .onAppear {
            showContent = true
        }
        .overlay {
            if authViewModel.showLoginSheet {
                LoginSheetView(authViewModel: authViewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(response: 0.4, dampingFraction: 0.85), value: authViewModel.showLoginSheet)
            }
        }
    }
}

#Preview {
    WelcomeView(authViewModel: AuthViewModel())
}
