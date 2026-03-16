import { ChevronRight, User, Wallet, Link, Key, Bell, Globe, DollarSign, FileText, Info, LogOut, type LucideIcon } from 'lucide-react';

interface SettingsViewProps {
  onLogout: () => void;
}

export function SettingsView({ onLogout }: SettingsViewProps) {
  return (
    <div className="flex-1 overflow-y-auto no-scrollbar pb-24">
      <div className="px-5 flex flex-col gap-6">
        {/* Header */}
        <div className="pt-4">
          <h1 className="text-2xl font-bold text-white">Settings</h1>
        </div>

        {/* Profile */}
        <SettingsSection title="PROFILE">
          <div className="flex items-center gap-3.5 p-4 rounded-xl" style={{ backgroundColor: '#1F1F24' }}>
            <div className="w-12 h-12 rounded-full flex items-center justify-center" style={{ backgroundColor: 'rgba(0,217,242,0.2)' }}>
              <User size={20} style={{ color: '#00D9F2' }} />
            </div>
            <div className="flex-1">
              <p className="text-base font-semibold text-white">Pocket User</p>
              <p className="text-sm font-medium" style={{ color: '#8C8C99' }}>Connected via Privy</p>
            </div>
            <ChevronRight size={14} style={{ color: '#8C8C99' }} />
          </div>
        </SettingsSection>

        {/* Wallets */}
        <SettingsSection title="WALLETS">
          <div className="rounded-xl overflow-hidden" style={{ backgroundColor: '#1F1F24' }}>
            <SettingsRow icon={Wallet} iconColor="#00D9F2" title="Embedded Wallets" subtitle="EVM + Solana" />
            <SettingsRow icon={Link} iconColor="#C7A64D" title="Connected Wallets" subtitle="None" />
            <SettingsRow icon={Key} iconColor="#9973CC" title="Export Private Key" />
          </div>
        </SettingsSection>

        {/* Preferences */}
        <SettingsSection title="PREFERENCES">
          <div className="rounded-xl overflow-hidden" style={{ backgroundColor: '#1F1F24' }}>
            <SettingsRow icon={Bell} iconColor="#4073E6" title="Notifications" subtitle="Enabled" />
            <SettingsRow icon={Globe} iconColor="#00D9F2" title="Network" subtitle="Mainnet" />
            <SettingsRow icon={DollarSign} iconColor="#33CC66" title="Currency" subtitle="USD" />
          </div>
        </SettingsSection>

        {/* About */}
        <SettingsSection title="ABOUT">
          <div className="rounded-xl overflow-hidden" style={{ backgroundColor: '#1F1F24' }}>
            <SettingsRow icon={FileText} iconColor="#8C8C99" title="Privacy Policy" />
            <SettingsRow icon={FileText} iconColor="#8C8C99" title="Terms of Service" />
            <SettingsRow icon={Info} iconColor="#8C8C99" title="Version" subtitle="1.0.0" />
          </div>
        </SettingsSection>

        {/* Logout */}
        <button onClick={onLogout}
          className="flex items-center justify-center gap-2 w-full h-12 rounded-xl"
          style={{ backgroundColor: 'rgba(230,51,51,0.1)', border: '1px solid rgba(230,51,51,0.3)' }}>
          <LogOut size={16} style={{ color: '#E63333' }} />
          <span className="text-base font-semibold" style={{ color: '#E63333' }}>Log Out</span>
        </button>
      </div>
    </div>
  );
}

function SettingsSection({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div>
      <p className="text-xs font-semibold uppercase mb-2" style={{ color: '#8C8C99' }}>{title}</p>
      {children}
    </div>
  );
}

function SettingsRow({ icon: Icon, iconColor, title, subtitle }: {
  icon: LucideIcon;
  iconColor: string; title: string; subtitle?: string;
}) {
  return (
    <div className="flex items-center gap-3 px-4 py-3">
      <div className="w-8 h-8 rounded-lg flex items-center justify-center" style={{ backgroundColor: `${iconColor}1F` }}>
        <Icon size={16} style={{ color: iconColor }} />
      </div>
      <span className="text-sm font-medium text-white flex-1">{title}</span>
      {subtitle && <span className="text-sm" style={{ color: '#8C8C99' }}>{subtitle}</span>}
      <ChevronRight size={13} style={{ color: '#66666B' }} />
    </div>
  );
}
