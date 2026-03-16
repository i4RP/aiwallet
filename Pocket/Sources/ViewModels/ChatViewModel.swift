import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var messages: [ChatMessage] = []
    @Published var inputText: String = ""
    @Published var selectedAgent: Agent = Agent.samples[0]
    @Published var isSending: Bool = false

    init() {
        loadSampleMessages()
    }

    // MARK: - Actions
    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let userMessage = ChatMessage(
            sender: .user,
            text: inputText,
            time: currentTimeString()
        )
        messages.append(userMessage)
        let sentText = inputText
        inputText = ""
        isSending = true

        // TODO: Integrate with AI agent backend
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            let agentResponse = ChatMessage(
                sender: .agent(self.selectedAgent.name),
                text: "I'm analyzing your request: \"\(sentText)\". Let me check the markets.",
                time: self.currentTimeString()
            )
            self.messages.append(agentResponse)
            self.isSending = false
        }
    }

    func selectAgent(_ agent: Agent) {
        selectedAgent = agent
        messages.removeAll()
        loadSampleMessages()
    }

    // MARK: - Private
    private func loadSampleMessages() {
        messages = [
            ChatMessage(
                sender: .agent(selectedAgent.name),
                text: "Hello! I'm your \(selectedAgent.name) agent. How can I help you today?",
                time: "9:00 am"
            )
        ]
    }

    private func currentTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: Date())
    }
}
