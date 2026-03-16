import { useState } from 'react';
import { Home, MessageSquare, TrendingUp, Settings, type LucideIcon } from 'lucide-react';
import type { AppTab } from '../../types';
import { HomeView } from './HomeView';
import { ChatView } from './ChatView';
import { MarketView } from './MarketView';
import { SettingsView } from './SettingsView';

interface MainTabViewProps {
  onLogout: () => void;
}

const TABS: { key: AppTab; title: string; icon: LucideIcon }[] = [
  { key: 'home', title: 'Home', icon: Home },
  { key: 'chat', title: 'Chat', icon: MessageSquare },
  { key: 'market', title: 'Market', icon: TrendingUp },
  { key: 'settings', title: 'Settings', icon: Settings },
];

export function MainTabView({ onLogout }: MainTabViewProps) {
  const [selectedTab, setSelectedTab] = useState<AppTab>('home');

  return (
    <div className="fixed inset-0 bg-black flex flex-col">
      {/* Tab Content */}
      <div className="flex-1 overflow-hidden">
        {selectedTab === 'home' && <HomeView />}
        {selectedTab === 'chat' && <ChatView />}
        {selectedTab === 'market' && <MarketView />}
        {selectedTab === 'settings' && <SettingsView onLogout={onLogout} />}
      </div>

      {/* Custom Tab Bar */}
      <div className="flex items-center" style={{ backgroundColor: '#1F1F24', boxShadow: '0 -4px 8px rgba(0,0,0,0.3)' }}>
        {TABS.map(tab => (
          <button key={tab.key} onClick={() => setSelectedTab(tab.key)}
            className="flex-1 flex flex-col items-center gap-1 pt-2.5 pb-1.5">
            <tab.icon size={20} style={{ color: selectedTab === tab.key ? '#00D9F2' : '#8C8C99' }} />
            <span className="text-xs font-medium" style={{ color: selectedTab === tab.key ? '#00D9F2' : '#8C8C99' }}>
              {tab.title}
            </span>
          </button>
        ))}
        {/* Safe area padding for mobile */}
        <div className="absolute bottom-0 left-0 right-0 h-safe-area" />
      </div>
    </div>
  );
}
