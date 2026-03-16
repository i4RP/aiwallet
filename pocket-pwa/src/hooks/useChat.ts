import { useState, useCallback } from 'react';
import type { ChatMessage, Agent } from '../types';
import { AGENTS, SAMPLE_MESSAGES } from '../data/sampleData';

export function useChat() {
  const [messages, setMessages] = useState<ChatMessage[]>(SAMPLE_MESSAGES);
  const [inputText, setInputText] = useState('');
  const [selectedAgent, setSelectedAgent] = useState<Agent>(AGENTS[0]);
  const [isSending, setIsSending] = useState(false);

  const sendMessage = useCallback(() => {
    const trimmed = inputText.trim();
    if (!trimmed || isSending) return;

    const userMsg: ChatMessage = {
      id: Date.now().toString(),
      sender: { type: 'user' },
      text: trimmed,
      time: new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: true }),
    };
    setMessages(prev => [...prev, userMsg]);
    setInputText('');
    setIsSending(true);

    setTimeout(() => {
      const agentMsg: ChatMessage = {
        id: (Date.now() + 1).toString(),
        sender: { type: 'agent', name: selectedAgent.name },
        text: `I'm analyzing your request about "${trimmed}". Let me check the latest data...`,
        time: new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: true }),
      };
      setMessages(prev => [...prev, agentMsg]);
      setIsSending(false);
    }, 1500);
  }, [inputText, isSending, selectedAgent]);

  const selectAgent = useCallback((agent: Agent) => setSelectedAgent(agent), []);

  return { messages, inputText, setInputText, selectedAgent, isSending, sendMessage, selectAgent };
}
