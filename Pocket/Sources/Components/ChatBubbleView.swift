import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage
    
    var body: some View {
        switch message.sender {
        case .agent(let name):
            agentMessage(name: name)
        case .user:
            userMessage()
        }
    }
    
    // MARK: - Agent Message
    @ViewBuilder
    private func agentMessage(name: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                // Agent Avatar
                Circle()
                    .fill(Color.agentStocks)
                    .frame(width: 32, height: 32)
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 6) {
                        Text(name)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(message.time)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.pocketSecondaryText)
                    }
                    
                    Text(message.text)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.pocketSecondaryText)
                }
            }
            
            // Trade Badge
            if let badge = message.tradeBadge {
                TradeBadgeView(badge: badge)
                    .padding(.leading, 42)
            }
        }
    }
    
    // MARK: - User Message
    @ViewBuilder
    private func userMessage() -> some View {
        HStack {
            Spacer()
            Text(message.text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color(red: 0.25, green: 0.25, blue: 0.28))
                )
        }
    }
}

// MARK: - Trade Badge View
struct TradeBadgeView: View {
    let badge: TradeBadge
    
    var body: some View {
        HStack(spacing: 8) {
            // Ticker Icon
            Circle()
                .fill(Color.pocketRed)
                .frame(width: 24, height: 24)
                .overlay(
                    Text("T")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                )
            
            Text(badge.displayText)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(Color(red: 0.18, green: 0.18, blue: 0.20))
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        ChatBubbleView(message: ChatMessage(
            sender: .agent("Stocks Trader"),
            text: "TSLA hit my entry range."
        ))
        
        ChatBubbleView(message: ChatMessage(
            sender: .user,
            text: "Nice. What did you do?"
        ))
        
        ChatBubbleView(message: ChatMessage(
            sender: .agent("Stocks Trader"),
            text: "Executed a buy",
            tradeBadge: TradeBadge(action: .bought, amount: 24.3, ticker: "TSLA")
        ))
    }
    .padding()
    .background(Color.black)
}
