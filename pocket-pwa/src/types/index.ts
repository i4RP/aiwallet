// Agent Model
export interface Agent {
  id: string;
  name: string;
  color: string;
  icon: string;
}

// Chat Message
export interface ChatMessage {
  id: string;
  sender: MessageSender;
  text: string;
  time: string;
  tradeBadge?: TradeBadge;
}

export type MessageSender = { type: 'agent'; name: string } | { type: 'user' };

// Trade Badge
export interface TradeBadge {
  id: string;
  action: 'Bought' | 'Sold';
  amount: number;
  ticker: string;
}

// Stock Data
export interface StockData {
  id: string;
  ticker: string;
  price: number;
  chartPoints: number[];
  color: string;
}

// Portfolio Data
export interface PortfolioData {
  balance: number;
  changePercent: number;
  isDown: boolean;
}

// Tab Definition
export type AppTab = 'home' | 'chat' | 'market' | 'settings';

export const APP_TABS: { key: AppTab; title: string; icon: string }[] = [
  { key: 'home', title: 'Home', icon: 'Home' },
  { key: 'chat', title: 'Chat', icon: 'MessageSquare' },
  { key: 'market', title: 'Market', icon: 'TrendingUp' },
  { key: 'settings', title: 'Settings', icon: 'Settings' },
];

// Asset Model
export interface Asset {
  id: string;
  name: string;
  symbol: string;
  balance: number;
  value: number;
  changePercent: number;
  isUp: boolean;
  chainType: 'ethereum' | 'solana';
}

// Wallet Info
export interface WalletInfo {
  id: string;
  address: string;
  chainType: 'Ethereum' | 'Solana';
  isEmbedded: boolean;
}

// Agent Status
export type AgentStatus = 'Running' | 'Paused' | 'Stopped';

export interface AgentDetail {
  id: string;
  agent: Agent;
  status: AgentStatus;
  description: string;
  profitLoss: number;
}

// Market Item
export interface MarketItem {
  id: string;
  name: string;
  symbol: string;
  price: number;
  changePercent: number;
  isUp: boolean;
  chartPoints: number[];
}

// Wallet Option
export interface WalletOption {
  id: string;
  name: string;
  chains: ('ethereum' | 'solana' | 'multichain')[];
}

// Login Page
export type LoginPage = 'main' | 'otherSocials' | 'walletSelection';

// Auth State
export type AuthState = 'unauthenticated' | 'authenticating' | 'authenticated';

// Market Timeframe
export type MarketTimeframe = '1H' | '1D' | '1W' | '1M' | '1Y';

// Carousel Card Type
export type CarouselCardType = 'portfolio' | 'chat' | 'stockChart';
