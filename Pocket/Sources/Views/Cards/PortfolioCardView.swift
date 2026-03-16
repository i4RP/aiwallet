import SwiftUI

struct PortfolioCardView: View {
    let portfolio: PortfolioData
    let agents: [Agent]
    let isVisible: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            // Balance
            Text("$\(String(format: "%.2f", portfolio.balance))")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(isVisible ? 1 : 0)
                .animation(.easeIn(duration: 0.4).delay(0.1), value: isVisible)
            
            // Change Indicator
            HStack(spacing: 6) {
                Text("down")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.pocketRed)
                
                Text("\(String(format: "%.1f", portfolio.changePercent))%")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.pocketRed.opacity(0.3))
                    )
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.4).delay(0.2), value: isVisible)
            
            // Pill Buttons
            HStack(spacing: 10) {
                ForEach(0..<3) { _ in
                    Capsule()
                        .fill(Color(red: 0.22, green: 0.22, blue: 0.25))
                        .frame(width: 60, height: 28)
                }
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.4).delay(0.3), value: isVisible)
            
            // Agents Section
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Agents")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.pocketSecondaryText)
                    
                    Spacer()
                }
                .padding(.leading, 4)
                
                // Agent Icons
                HStack(spacing: 24) {
                    Spacer()
                    ForEach(agents) { agent in
                        AgentCircleView(agent: agent)
                    }
                    Spacer()
                }
            }
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.4).delay(0.4), value: isVisible)
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 20)
    }
}

#Preview {
    PortfolioCardView(
        portfolio: .sample,
        agents: Agent.samples,
        isVisible: true
    )
    .background(Color.pocketCardBackground)
    .cornerRadius(20)
    .padding()
    .background(Color.black)
}
