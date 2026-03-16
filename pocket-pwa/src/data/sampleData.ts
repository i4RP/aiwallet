import type { Agent, Asset, AgentDetail, MarketItem, WalletOption, ChatMessage, PortfolioData, StockData } from '../types';

export const AGENTS: Agent[] = [
  { id: '1', name: 'Stocks', color: '#C7A64D', icon: 'TrendingUp' },
  { id: '2', name: 'Predictions', color: '#4073E6', icon: 'Brain' },
  { id: '3', name: 'Defi', color: '#9973CC', icon: 'Coins' },
];

export const SAMPLE_PORTFOLIO: PortfolioData = {
  balance: 62.18,
  changePercent: 6.1,
  isDown: true,
};

export const SAMPLE_ASSETS: Asset[] = [
  { id: '1', name: 'Ethereum', symbol: 'ETH', balance: 0.0185, value: 48.62, changePercent: 2.3, isUp: true, chainType: 'ethereum' },
  { id: '2', name: 'Solana', symbol: 'SOL', balance: 0.082, value: 13.56, changePercent: 5.7, isUp: false, chainType: 'solana' },
];

export const SAMPLE_AGENT_DETAILS: AgentDetail[] = [
  { id: '1', agent: AGENTS[0], status: 'Running', description: 'Analyzing stock markets and executing trades', profitLoss: 12.5 },
  { id: '2', agent: AGENTS[1], status: 'Running', description: 'Predicting market trends with AI models', profitLoss: -3.2 },
  { id: '3', agent: AGENTS[2], status: 'Paused', description: 'Managing DeFi positions and yield farming', profitLoss: 8.7 },
];

export const SAMPLE_MARKET_ITEMS: MarketItem[] = [
  { id: '1', name: 'Bitcoin', symbol: 'BTC', price: 67432.50, changePercent: 1.8, isUp: true, chartPoints: [0.4, 0.42, 0.45, 0.43, 0.48, 0.50, 0.52, 0.55, 0.53, 0.58] },
  { id: '2', name: 'Ethereum', symbol: 'ETH', price: 2628.30, changePercent: 2.3, isUp: true, chartPoints: [0.5, 0.48, 0.52, 0.55, 0.53, 0.58, 0.60, 0.57, 0.62, 0.65] },
  { id: '3', name: 'Solana', symbol: 'SOL', price: 165.42, changePercent: 5.7, isUp: false, chartPoints: [0.7, 0.68, 0.65, 0.63, 0.60, 0.58, 0.55, 0.52, 0.50, 0.48] },
  { id: '4', name: 'Chainlink', symbol: 'LINK', price: 14.85, changePercent: 3.1, isUp: true, chartPoints: [0.3, 0.35, 0.38, 0.40, 0.42, 0.45, 0.48, 0.50, 0.52, 0.55] },
  { id: '5', name: 'Uniswap', symbol: 'UNI', price: 7.23, changePercent: 1.2, isUp: false, chartPoints: [0.6, 0.58, 0.55, 0.57, 0.54, 0.52, 0.50, 0.48, 0.50, 0.47] },
];

export const WALLET_OPTIONS: WalletOption[] = [
  { id: '1', name: 'MetaMask', chains: ['ethereum', 'multichain'] },
  { id: '2', name: 'Coinbase Wallet', chains: ['ethereum', 'solana'] },
  { id: '3', name: 'Rainbow', chains: ['ethereum'] },
  { id: '4', name: 'Base', chains: ['ethereum'] },
  { id: '5', name: '1inch', chains: ['ethereum', 'multichain'] },
];

export const SAMPLE_MESSAGES: ChatMessage[] = [
  { id: '1', sender: { type: 'agent', name: 'Stocks Trader' }, text: 'TSLA hit my entry range. Looking at a good setup here.', time: '3:42 pm' },
  { id: '2', sender: { type: 'user' }, text: 'Nice. What did you do?', time: '3:43 pm' },
  { id: '3', sender: { type: 'agent', name: 'Stocks Trader' }, text: 'Executed a buy at the support level.', time: '3:45 pm', tradeBadge: { id: '1', action: 'Bought', amount: 24.3, ticker: 'TSLA' } },
];

export const SAMPLE_STOCK: StockData = {
  id: '1',
  ticker: 'TSLA',
  price: 569.8,
  chartPoints: [0.5, 0.45, 0.55, 0.40, 0.48, 0.42, 0.50, 0.45, 0.52, 0.48, 0.55, 0.50, 0.58, 0.62, 0.65, 0.70],
  color: '#E63333',
};

export const AGENT_STATUS_COLORS: Record<string, string> = {
  Running: '#33CC66',
  Paused: '#C7A64D',
  Stopped: '#E63333',
};

export const TOKEN_COLORS: Record<string, string> = {
  BTC: '#F59E0B',
  ETH: '#4073E6',
  SOL: '#9973CC',
  LINK: '#375DEB',
};

export const WALLET_ICON_COLORS: Record<string, string> = {
  MetaMask: '#E08F33',
  'Coinbase Wallet': '#3366F2',
  Rainbow: '#F28033',
  Base: '#3355FF',
};
