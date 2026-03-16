import SwiftUI

struct AgentCircleView: View {
    let agent: Agent
    let size: CGFloat
    
    init(agent: Agent, size: CGFloat = 56) {
        self.agent = agent
        self.size = size
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Colored Circle
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            agent.color.opacity(0.9),
                            agent.color.opacity(0.6)
                        ]),
                        center: .topLeading,
                        startRadius: 0,
                        endRadius: size
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: agent.color.opacity(0.3), radius: 8, x: 0, y: 4)
            
            // Agent Name
            Text(agent.name)
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
            
            // Message Label
            Text("Message")
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.pocketCyan)
        }
    }
}

#Preview {
    HStack(spacing: 30) {
        ForEach(Agent.samples) { agent in
            AgentCircleView(agent: agent)
        }
    }
    .padding()
    .background(Color.black)
}
