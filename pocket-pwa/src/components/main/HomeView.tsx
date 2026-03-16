import { ArrowDownRight, ArrowUpRight, ArrowDown, ArrowUp, ArrowLeftRight, Plus, Bell } from 'lucide-react';
import type { AgentDetail, Asset } from '../../types';
import { AGENT_STATUS_COLORS } from '../../data/sampleData';
import { usePortfolio } from '../../hooks/usePortfolio';

export function HomeView() {
  const { portfolio, assets, agentDetails, toggleAgent } = usePortfolio();

  return (
    <div className="flex-1 overflow-y-auto no-scrollbar pb-24">
      <div className="px-5 flex flex-col gap-6">
        {/* Header */}
        <div className="flex items-center justify-between pt-4">
          <div>
            <h1 className="text-2xl font-black text-white tracking-wider" style={{ fontFamily: 'system-ui' }}>POCKET</h1>
            <p className="text-sm font-medium" style={{ color: '#8C8C99' }}>Your Crypto AI Assistant</p>
          </div>
          <button className="w-10 h-10 rounded-full flex items-center justify-center" style={{ backgroundColor: '#1F1F24' }}>
            <Bell size={18} style={{ color: '#8C8C99' }} />
          </button>
        </div>

        {/* Balance Card */}
        <div className="flex flex-col items-center py-7 rounded-2xl" style={{ backgroundColor: '#1F1F24', border: '1px solid #333338' }}>
          <p className="text-sm font-medium" style={{ color: '#8C8C99' }}>Total Balance</p>
          <p className="text-5xl font-bold text-white mt-1" style={{ fontFamily: 'system-ui' }}>${portfolio.balance.toFixed(2)}</p>
          <div className="flex items-center gap-1.5 mt-3">
            {portfolio.isDown
              ? <ArrowDownRight size={12} className="font-semibold" style={{ color: '#E63333' }} />
              : <ArrowUpRight size={12} className="font-semibold" style={{ color: '#33CC66' }} />}
            <span className="text-sm font-bold" style={{ color: portfolio.isDown ? '#E63333' : '#33CC66' }}>
              {portfolio.changePercent.toFixed(1)}%
            </span>
            <span className="text-sm font-medium" style={{ color: '#8C8C99' }}>today</span>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="flex gap-3">
          {[
            { icon: ArrowDown, title: 'Receive' },
            { icon: ArrowUp, title: 'Send' },
            { icon: ArrowLeftRight, title: 'Swap' },
            { icon: Plus, title: 'Buy' },
          ].map(action => (
            <button key={action.title} className="flex-1 flex flex-col items-center gap-2">
              <div className="w-11 h-11 rounded-full flex items-center justify-center" style={{ backgroundColor: 'rgba(0,217,242,0.12)' }}>
                <action.icon size={16} style={{ color: '#00D9F2' }} />
              </div>
              <span className="text-xs font-medium" style={{ color: '#8C8C99' }}>{action.title}</span>
            </button>
          ))}
        </div>

        {/* AI Agents */}
        <div>
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-lg font-semibold text-white">AI Agents</h2>
            <button className="text-sm font-medium" style={{ color: '#00D9F2' }}>See all</button>
          </div>
          <div className="flex flex-col gap-3">
            {agentDetails.map(detail => (
              <AgentRow key={detail.id} detail={detail} onToggle={() => toggleAgent(detail.id)} />
            ))}
          </div>
        </div>

        {/* Assets */}
        <div>
          <div className="flex justify-between items-center mb-4">
            <h2 className="text-lg font-semibold text-white">Assets</h2>
            <button className="text-sm font-medium" style={{ color: '#00D9F2' }}>See all</button>
          </div>
          {assets.length === 0 ? (
            <EmptyAssets />
          ) : (
            <div className="flex flex-col gap-3">
              {assets.map(asset => (<AssetRow key={asset.id} asset={asset} />))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

function AgentRow({ detail, onToggle }: { detail: AgentDetail; onToggle: () => void }) {
  const statusColor = AGENT_STATUS_COLORS[detail.status] || '#8C8C99';
  return (
    <div className="flex items-center gap-3 p-3.5 rounded-xl" style={{ backgroundColor: '#1F1F24' }}>
      <div className="w-10 h-10 rounded-full flex items-center justify-center" style={{ backgroundColor: detail.agent.color }}>
        <span className="text-white text-sm font-bold">{detail.agent.name[0]}</span>
      </div>
      <div className="flex-1 min-w-0">
        <div className="flex items-center gap-2">
          <span className="text-sm font-semibold text-white">{detail.agent.name}</span>
          <div className="flex items-center gap-1">
            <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: statusColor }} />
            <span className="text-xs font-medium" style={{ color: statusColor }}>{detail.status}</span>
          </div>
        </div>
        <p className="text-sm truncate" style={{ color: '#8C8C99' }}>{detail.description}</p>
      </div>
      <div className="flex flex-col items-end gap-0.5">
        <span className="text-sm font-bold" style={{ color: detail.profitLoss >= 0 ? '#33CC66' : '#E63333' }}>
          {detail.profitLoss >= 0 ? '+' : ''}{detail.profitLoss.toFixed(1)}%
        </span>
        <button onClick={onToggle} className="text-xs font-semibold" style={{ color: '#00D9F2' }}>
          {detail.status === 'Running' ? 'Pause' : 'Start'}
        </button>
      </div>
    </div>
  );
}

function AssetRow({ asset }: { asset: Asset }) {
  const iconColor = asset.chainType === 'ethereum' ? '#4073E6' : '#9973CC';
  return (
    <div className="flex items-center gap-3 p-3.5 rounded-xl" style={{ backgroundColor: '#1F1F24' }}>
      <div className="w-10 h-10 rounded-full flex items-center justify-center" style={{ backgroundColor: iconColor }}>
        <span className="text-white text-base font-bold">{asset.symbol[0]}</span>
      </div>
      <div className="flex-1">
        <p className="text-sm font-semibold text-white">{asset.name}</p>
        <p className="text-sm" style={{ color: '#8C8C99' }}>{asset.balance.toFixed(4)} {asset.symbol}</p>
      </div>
      <div className="flex flex-col items-end gap-1">
        <span className="text-sm font-semibold text-white">${asset.value.toFixed(2)}</span>
        <div className="flex items-center gap-0.5" style={{ color: asset.isUp ? '#33CC66' : '#E63333' }}>
          {asset.isUp ? <ArrowUpRight size={10} /> : <ArrowDownRight size={10} />}
          <span className="text-xs font-medium">{asset.changePercent.toFixed(1)}%</span>
        </div>
      </div>
    </div>
  );
}

function EmptyAssets() {
  return (
    <div className="flex flex-col items-center py-8 rounded-xl" style={{ backgroundColor: '#1F1F24' }}>
      <Wallet size={32} style={{ color: '#8C8C99' }} />
      <p className="text-sm font-medium mt-3" style={{ color: '#8C8C99' }}>No assets yet</p>
      <p className="text-sm text-center mt-1" style={{ color: '#66666B' }}>
        Your crypto assets will appear here<br />once you receive or buy tokens.
      </p>
    </div>
  );
}

function Wallet({ size, style }: { size: number; style: React.CSSProperties }) {
  return (
    <svg width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={style}>
      <path d="M21 12V7H5a2 2 0 0 1 0-4h14v4" /><path d="M3 5v14a2 2 0 0 0 2 2h16v-5" /><path d="M18 12a2 2 0 0 0 0 4h4v-4Z" />
    </svg>
  );
}
