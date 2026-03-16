import SwiftUI

struct ChatView: View {
    @ObservedObject var chatViewModel: ChatViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Header
            ChatHeaderView(
                selectedAgent: chatViewModel.selectedAgent,
                onSelectAgent: { agent in chatViewModel.selectAgent(agent) }
            )

            // Messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(chatViewModel.messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }

                        if chatViewModel.isSending {
                            TypingIndicatorView(agentName: chatViewModel.selectedAgent.name)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
                .onChange(of: chatViewModel.messages.count) {
                    if let lastMessage = chatViewModel.messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }

            // Input Bar
            ChatInputBar(
                inputText: $chatViewModel.inputText,
                isSending: chatViewModel.isSending,
                onSend: { chatViewModel.sendMessage() }
            )

            // Spacer for tab bar
            Spacer().frame(height: 60)
        }
        .background(Color.pocketBackground.ignoresSafeArea())
    }
}

// MARK: - Chat Header
struct ChatHeaderView: View {
    let selectedAgent: Agent
    let onSelectAgent: (Agent) -> Void

    var body: some View {
        VStack(spacing: 12) {
            // Title
            HStack {
                Text("Chat")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            // Agent Selector
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(Agent.samples) { agent in
                        AgentChipView(
                            agent: agent,
                            isSelected: agent.name == selectedAgent.name,
                            onTap: { onSelectAgent(agent) }
                        )
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.bottom, 8)
        .background(Color.pocketBackground)
    }
}

struct AgentChipView: View {
    let agent: Agent
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap, label: {
            HStack(spacing: 8) {
                Circle()
                    .fill(agent.color)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Image(systemName: agent.icon)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    )

                Text(agent.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isSelected ? .white : .pocketSecondaryText)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(isSelected ? agent.color.opacity(0.25) : Color.pocketCardBackground)
                    .overlay(
                        Capsule()
                            .stroke(isSelected ? agent.color : Color.pocketCardBorder, lineWidth: 1)
                    )
            )
        })
    }
}

// MARK: - Typing Indicator
struct TypingIndicatorView: View {
    let agentName: String
    @State private var dotCount = 0

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(Color.agentStocks)
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(agentName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)

                HStack(spacing: 4) {
                    ForEach(0..<3, id: \.self) { index in
                        Circle()
                            .fill(Color.pocketSecondaryText)
                            .frame(width: 6, height: 6)
                            .opacity(dotCount > index ? 1 : 0.3)
                    }
                }
            }

            Spacer()
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                withAnimation {
                    dotCount = (dotCount + 1) % 4
                }
            }
        }
    }
}

// MARK: - Chat Input Bar
struct ChatInputBar: View {
    @Binding var inputText: String
    let isSending: Bool
    let onSend: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            TextField("Message your agent...", text: $inputText)
                .font(.system(size: 15))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.pocketCardBackground)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .stroke(Color.pocketCardBorder, lineWidth: 1)
                        )
                )
                .onSubmit {
                    onSend()
                }

            Button(action: onSend, label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(
                        inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending
                            ? .pocketSecondaryText
                            : .pocketCyan
                    )
            })
            .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isSending)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.pocketBackground)
    }
}

#Preview {
    ChatView(chatViewModel: ChatViewModel())
        .preferredColorScheme(.dark)
}
