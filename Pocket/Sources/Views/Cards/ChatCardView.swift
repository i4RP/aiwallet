import SwiftUI

struct ChatCardView: View {
    let messages: [ChatMessage]
    let isVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Yellow Header Bar
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.90, green: 0.78, blue: 0.20))
                .frame(height: 36)
                .padding(.horizontal, -20)
                .padding(.top, -24)
                .clipShape(
                    RoundedCorner(radius: 20, corners: [.topLeft, .topRight])
                )
            
            // Chat Messages
            ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                ChatBubbleView(message: message)
                    .opacity(isVisible ? 1 : 0)
                    .animation(
                        .easeIn(duration: 0.4).delay(Double(index) * 0.3 + 0.2),
                        value: isVisible
                    )
                    .offset(y: isVisible ? 0 : 10)
                    .animation(
                        .easeOut(duration: 0.4).delay(Double(index) * 0.3 + 0.2),
                        value: isVisible
                    )
            }
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
    }
}

// MARK: - Rounded Corner Helper
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ChatCardView(
        messages: [
            ChatMessage(sender: .agent("Stocks Trader"), text: "TSLA hit my entry range."),
            ChatMessage(sender: .user, text: "Nice. What did you do?"),
            ChatMessage(
                sender: .agent("Stocks Trader"),
                text: "Executed a buy",
                tradeBadge: TradeBadge(action: .bought, amount: 24.3, ticker: "TSLA")
            )
        ],
        isVisible: true
    )
    .background(Color.pocketCardBackground)
    .cornerRadius(20)
    .padding()
    .background(Color.black)
}
