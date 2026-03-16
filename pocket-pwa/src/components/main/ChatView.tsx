import { useRef, useEffect } from 'react';
import { ArrowUpCircle } from 'lucide-react';
import type { ChatMessage, Agent } from '../../types';
import { AGENTS } from '../../data/sampleData';
import { useChat } from '../../hooks/useChat';

export function ChatView() {
  const { messages, inputText, setInputText, selectedAgent, isSending, sendMessage, selectAgent } = useChat();
  const messagesEndRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages.length]);

  return (
    <div className="flex-1 flex flex-col overflow-hidden">
      {/* Header */}
      <div className="px-5 pt-4 pb-2" style={{ backgroundColor: '#000000' }}>
        <h1 className="text-2xl font-bold text-white mb-3">Chat</h1>
        <div className="flex gap-3 overflow-x-auto no-scrollbar pb-2">
          {AGENTS.map(agent => (
            <AgentChip key={agent.id} agent={agent} isSelected={agent.name === selectedAgent.name} onTap={() => selectAgent(agent)} />
          ))}
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-5 py-4 no-scrollbar">
        <div className="flex flex-col gap-4">
          {messages.map(msg => (<ChatBubble key={msg.id} message={msg} />))}
          {isSending && <TypingIndicator agentName={selectedAgent.name} />}
          <div ref={messagesEndRef} />
        </div>
      </div>

      {/* Input */}
      <div className="px-5 py-2.5 flex items-center gap-3 pb-20" style={{ backgroundColor: '#000000' }}>
        <div className="flex-1 flex items-center rounded-3xl px-4 py-3" style={{ backgroundColor: '#1F1F24', border: '1px solid #333338' }}>
          <input type="text" placeholder="Message your agent..." value={inputText}
            onChange={e => setInputText(e.target.value)}
            onKeyDown={e => { if (e.key === 'Enter') sendMessage(); }}
            className="flex-1 bg-transparent text-white text-sm outline-none placeholder-gray-500" />
        </div>
        <button onClick={sendMessage} disabled={!inputText.trim() || isSending}>
          <ArrowUpCircle size={32} style={{ color: inputText.trim() && !isSending ? '#00D9F2' : '#8C8C99' }} />
        </button>
      </div>
    </div>
  );
}

function AgentChip({ agent, isSelected, onTap }: { agent: Agent; isSelected: boolean; onTap: () => void }) {
  return (
    <button onClick={onTap} className="flex items-center gap-2 px-3.5 py-2 rounded-full whitespace-nowrap"
      style={{
        backgroundColor: isSelected ? `${agent.color}40` : '#1F1F24',
        border: `1px solid ${isSelected ? agent.color : '#333338'}`,
      }}>
      <div className="w-6 h-6 rounded-full flex items-center justify-center" style={{ backgroundColor: agent.color }}>
        <span className="text-white text-xs font-bold">{agent.name[0]}</span>
      </div>
      <span className="text-sm font-semibold" style={{ color: isSelected ? '#FFFFFF' : '#8C8C99' }}>{agent.name}</span>
    </button>
  );
}

function ChatBubble({ message }: { message: ChatMessage }) {
  if (message.sender.type === 'user') {
    return (
      <div className="flex justify-end">
        <div className="rounded-full px-4 py-2.5" style={{ backgroundColor: '#3F3F47' }}>
          <p className="text-sm font-medium text-white">{message.text}</p>
        </div>
      </div>
    );
  }

  const agentName = message.sender.name;
  return (
    <div className="flex flex-col gap-2">
      <div className="flex items-start gap-2.5">
        <div className="w-8 h-8 rounded-full flex-shrink-0" style={{ backgroundColor: '#C7A64D' }} />
        <div>
          <div className="flex items-center gap-1.5">
            <span className="text-sm font-semibold text-white">{agentName}</span>
            <span className="text-xs" style={{ color: '#8C8C99' }}>{message.time}</span>
          </div>
          <p className="text-sm mt-1" style={{ color: '#8C8C99' }}>{message.text}</p>
        </div>
      </div>
      {message.tradeBadge && (
        <div className="ml-10 flex items-center gap-2 rounded-full px-3 py-2 self-start" style={{ backgroundColor: '#2E2E32' }}>
          <div className="w-6 h-6 rounded-full flex items-center justify-center" style={{ backgroundColor: '#E63333' }}>
            <span className="text-xs font-bold text-white">T</span>
          </div>
          <span className="text-sm font-semibold text-white">
            {message.tradeBadge.action} {message.tradeBadge.amount} {message.tradeBadge.ticker}
          </span>
        </div>
      )}
    </div>
  );
}

function TypingIndicator({ agentName }: { agentName: string }) {
  return (
    <div className="flex items-start gap-2.5">
      <div className="w-8 h-8 rounded-full flex-shrink-0" style={{ backgroundColor: '#C7A64D' }} />
      <div>
        <span className="text-sm font-semibold text-white">{agentName}</span>
        <div className="flex gap-1 mt-1">
          <div className="w-1.5 h-1.5 rounded-full dot-pulse-1" style={{ backgroundColor: '#8C8C99' }} />
          <div className="w-1.5 h-1.5 rounded-full dot-pulse-2" style={{ backgroundColor: '#8C8C99' }} />
          <div className="w-1.5 h-1.5 rounded-full dot-pulse-3" style={{ backgroundColor: '#8C8C99' }} />
        </div>
      </div>
    </div>
  );
}
