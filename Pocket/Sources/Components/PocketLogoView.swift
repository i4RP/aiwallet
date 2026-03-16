import SwiftUI

struct PocketLogoView: View {
    var body: some View {
        VStack(spacing: 8) {
            // POCKET Logo Text
            Text("POCKET")
                .font(.system(size: 42, weight: .black, design: .rounded))
                .foregroundColor(.white)
                .tracking(2)
            
            // Subtitle
            Text("Your Crypto AI assistant")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.pocketSecondaryText)
        }
    }
}

#Preview {
    PocketLogoView()
        .background(Color.black)
}
