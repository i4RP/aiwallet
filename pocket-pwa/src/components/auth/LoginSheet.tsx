import { useState } from 'react';
import { X, ArrowLeft, Search, Mail, Globe, MessageSquare, Send, Wallet, Diamond, Hexagon, LayoutGrid } from 'lucide-react';
import type { LoginPage, WalletOption } from '../../types';
import { WALLET_OPTIONS, WALLET_ICON_COLORS } from '../../data/sampleData';

interface LoginSheetProps {
  currentPage: LoginPage;
  emailInput: string;
  isEmailValid: boolean;
  onEmailChange: (email: string) => void;
  onDismiss: () => void;
  onMockLogin: () => void;
  onNavigateToOtherSocials: () => void;
  onNavigateToWalletSelection: () => void;
  onNavigateBack: () => void;
}

export function LoginSheet({
  currentPage, emailInput, isEmailValid,
  onEmailChange, onDismiss, onMockLogin,
  onNavigateToOtherSocials, onNavigateToWalletSelection, onNavigateBack,
}: LoginSheetProps) {
  return (
    <div className="fixed inset-0 z-50 flex flex-col justify-end">
      <div className="absolute inset-0" onClick={onDismiss} />
      <div className="relative animate-slide-up" style={{ backgroundColor: '#1A1A1E' }}>
        <div className="rounded-t-2xl overflow-hidden" style={{ backgroundColor: '#1A1A1E' }}>
          {currentPage === 'main' && (
            <MainLoginContent
              emailInput={emailInput}
              isEmailValid={isEmailValid}
              onEmailChange={onEmailChange}
              onDismiss={onDismiss}
              onMockLogin={onMockLogin}
              onNavigateToOtherSocials={onNavigateToOtherSocials}
              onNavigateToWalletSelection={onNavigateToWalletSelection}
            />
          )}
          {currentPage === 'otherSocials' && (
            <OtherSocialsContent onDismiss={onDismiss} onBack={onNavigateBack} onLogin={onMockLogin} />
          )}
          {currentPage === 'walletSelection' && (
            <WalletSelectionContent onDismiss={onDismiss} onBack={onNavigateBack} onSelectWallet={onMockLogin} />
          )}
          <LoginFooter />
        </div>
      </div>
    </div>
  );
}

interface MainLoginContentProps {
  emailInput: string;
  isEmailValid: boolean;
  onEmailChange: (email: string) => void;
  onDismiss: () => void;
  onMockLogin: () => void;
  onNavigateToOtherSocials: () => void;
  onNavigateToWalletSelection: () => void;
}

function MainLoginContent({
  emailInput, isEmailValid, onEmailChange,
  onDismiss, onMockLogin, onNavigateToOtherSocials, onNavigateToWalletSelection,
}: MainLoginContentProps) {
  return (
    <div className="flex flex-col gap-4">
      <div className="flex justify-end px-5 pt-4">
        <button onClick={onDismiss} className="w-8 h-8 rounded-full flex items-center justify-center"
                style={{ backgroundColor: '#2E2E32' }}>
          <X size={16} style={{ color: '#8C8C99' }} />
        </button>
      </div>
      <div className="text-center">
        <h2 className="text-3xl font-bold text-white tracking-wider" style={{ fontFamily: 'system-ui' }}>POCKET</h2>
        <p className="text-lg font-medium text-white mt-2">Log in or sign up</p>
      </div>
      <div className="flex flex-col gap-3 px-5 pb-4">
        <LoginOptionButton icon={<Globe size={18} className="text-white" />} iconBg="#E08F33" title="MetaMask" showLastUsed showChainIcon onClick={onMockLogin} />
        <div className="flex items-center gap-3 rounded-xl px-4 py-3" style={{ border: '1px solid #404045' }}>
          <div className="w-9 h-9 rounded-full flex items-center justify-center" style={{ backgroundColor: '#383A3F' }}>
            <Mail size={16} className="text-white" />
          </div>
          <input type="email" placeholder="Enter your email" value={emailInput}
            onChange={e => onEmailChange(e.target.value)}
            className="flex-1 bg-transparent text-white text-base outline-none placeholder-gray-500" />
          {isEmailValid && (
            <button onClick={onMockLogin} className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#00D9F2' }}>
              <ArrowLeft size={14} className="text-black rotate-180" />
            </button>
          )}
        </div>
        <LoginOptionButton icon={<span className="text-white font-bold text-base">G</span>} iconBg="#383A3F" title="Google" isHighlighted onClick={onMockLogin} />
        <LoginOptionButton icon={<Globe size={18} className="text-white" />} iconBg="#383A3F" title="Other socials" onClick={onNavigateToOtherSocials} />
        <LoginOptionButton icon={<Wallet size={18} className="text-white" />} iconBg="#383A3F" title="Continue with a wallet" onClick={onNavigateToWalletSelection} />
      </div>
    </div>
  );
}

function OtherSocialsContent({ onDismiss, onBack, onLogin }: { onDismiss: () => void; onBack: () => void; onLogin: () => void }) {
  return (
    <div className="flex flex-col gap-4">
      <div className="flex justify-between px-5 pt-4">
        <button onClick={onBack} className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#2E2E32' }}>
          <ArrowLeft size={16} style={{ color: '#8C8C99' }} />
        </button>
        <button onClick={onDismiss} className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#2E2E32' }}>
          <X size={16} style={{ color: '#8C8C99' }} />
        </button>
      </div>
      <p className="text-lg font-medium text-white text-center pt-2 pb-2">Log in or sign up</p>
      <div className="flex flex-col gap-3 px-5 pb-4">
        <SocialButton icon={<X size={16} className="text-black" />} iconBg="#FFFFFF" title="Twitter" onClick={onLogin} />
        <SocialButton icon={<MessageSquare size={16} className="text-white" />} iconBg="#5766F2" title="Discord" onClick={onLogin} />
        <SocialButton icon={<Send size={16} className="text-white" />} iconBg="#66ABE0" title="Telegram" onClick={onLogin} />
      </div>
    </div>
  );
}

function WalletSelectionContent({ onDismiss, onBack, onSelectWallet }: { onDismiss: () => void; onBack: () => void; onSelectWallet: () => void }) {
  const [searchText, setSearchText] = useState('');
  const filtered = searchText ? WALLET_OPTIONS.filter(w => w.name.toLowerCase().includes(searchText.toLowerCase())) : WALLET_OPTIONS;

  return (
    <div className="flex flex-col gap-4">
      <div className="flex justify-between px-5 pt-4">
        <button onClick={onBack} className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#2E2E32' }}>
          <ArrowLeft size={16} style={{ color: '#8C8C99' }} />
        </button>
        <button onClick={onDismiss} className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#2E2E32' }}>
          <X size={16} style={{ color: '#8C8C99' }} />
        </button>
      </div>
      <div className="flex justify-center">
        <div className="w-14 h-14 rounded-full flex items-center justify-center" style={{ backgroundColor: '#2E2E32' }}>
          <Wallet size={28} style={{ color: '#8C8C99' }} />
        </div>
      </div>
      <p className="text-lg font-medium text-white text-center pb-1">Select your wallet</p>
      <div className="flex items-center gap-2.5 mx-5 rounded-xl px-4 py-2.5" style={{ backgroundColor: '#333338' }}>
        <div className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#383A3F' }}>
          <Search size={16} style={{ color: '#8C8C99' }} />
        </div>
        <input type="text" placeholder={`Search through ${WALLET_OPTIONS.length} wallets`} value={searchText}
          onChange={e => setSearchText(e.target.value)}
          className="flex-1 bg-transparent text-white text-sm outline-none placeholder-gray-500" />
      </div>
      <div className="max-h-80 overflow-y-auto px-5 pb-4 no-scrollbar">
        <div className="flex flex-col gap-2.5">
          {filtered.map(wallet => (<WalletRow key={wallet.id} wallet={wallet} onClick={onSelectWallet} />))}
        </div>
      </div>
    </div>
  );
}

function LoginOptionButton({ icon, iconBg, title, showLastUsed, showChainIcon, isHighlighted, onClick }: {
  icon: React.ReactNode; iconBg: string; title: string; showLastUsed?: boolean; showChainIcon?: boolean; isHighlighted?: boolean; onClick: () => void;
}) {
  return (
    <button onClick={onClick} className="flex items-center gap-3 rounded-xl px-4 py-3 w-full text-left"
      style={{ backgroundColor: isHighlighted ? '#333338' : 'transparent', border: isHighlighted ? 'none' : '1px solid #404045' }}>
      <div className="w-9 h-9 rounded-full flex items-center justify-center" style={{ backgroundColor: iconBg }}>{icon}</div>
      <span className="text-base font-medium text-white flex-1">{title}</span>
      {showLastUsed && <span className="text-xs px-2 py-0.5 rounded-full" style={{ backgroundColor: '#2E2E32', color: '#8C8C99' }}>Last used</span>}
      {showChainIcon && <Diamond size={12} className="text-blue-400" />}
    </button>
  );
}

function SocialButton({ icon, iconBg, title, onClick }: { icon: React.ReactNode; iconBg: string; title: string; onClick: () => void }) {
  return (
    <button onClick={onClick} className="flex items-center gap-3 rounded-xl px-4 py-3 w-full text-left" style={{ border: '1px solid #404045' }}>
      <div className="w-9 h-9 rounded-full flex items-center justify-center" style={{ backgroundColor: iconBg }}>{icon}</div>
      <span className="text-base font-medium text-white">{title}</span>
    </button>
  );
}

function WalletRow({ wallet, onClick }: { wallet: WalletOption; onClick: () => void }) {
  const color = WALLET_ICON_COLORS[wallet.name] || '#383A3F';
  return (
    <button onClick={onClick} className="flex items-center gap-3 rounded-xl px-4 py-3 w-full text-left" style={{ border: '1px solid #404045' }}>
      <div className="w-9 h-9 rounded-lg flex items-center justify-center" style={{ backgroundColor: color }}>
        <span className="text-white font-bold">{wallet.name[0]}</span>
      </div>
      <span className="text-base font-medium text-white flex-1">{wallet.name}</span>
      <div className="flex gap-1">
        {wallet.chains.map((chain, i) => (
          <span key={i}>
            {chain === 'ethereum' && <Diamond size={12} className="text-blue-400" />}
            {chain === 'solana' && <Hexagon size={12} className="text-purple-400" />}
            {chain === 'multichain' && <LayoutGrid size={12} className="text-green-400" />}
          </span>
        ))}
      </div>
    </button>
  );
}

function LoginFooter() {
  return (
    <div className="text-center py-4 px-5" style={{ borderTop: '1px solid #2E2E32' }}>
      <p className="text-xs" style={{ color: '#8C8C99' }}>
        By continuing, you agree to Pocket&apos;s{' '}
        <span style={{ color: '#00D9F2' }} className="underline cursor-pointer">Terms of Service</span>
        {' '}and{' '}
        <span style={{ color: '#00D9F2' }} className="underline cursor-pointer">Privacy Policy</span>
      </p>
    </div>
  );
}
