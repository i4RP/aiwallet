import { useState, useCallback } from 'react';
import type { Asset, AgentDetail } from '../types';
import { SAMPLE_PORTFOLIO, SAMPLE_ASSETS, SAMPLE_AGENT_DETAILS } from '../data/sampleData';

export function usePortfolio() {
  const [portfolio] = useState(SAMPLE_PORTFOLIO);
  const [assets] = useState<Asset[]>(SAMPLE_ASSETS);
  const [agentDetails, setAgentDetails] = useState<AgentDetail[]>(SAMPLE_AGENT_DETAILS);
  const [isRefreshing, setIsRefreshing] = useState(false);

  const totalBalance = assets.reduce((sum, a) => sum + a.value, 0);
  const activeAgentsCount = agentDetails.filter(d => d.status === 'Running').length;

  const refreshPortfolio = useCallback(() => {
    setIsRefreshing(true);
    setTimeout(() => setIsRefreshing(false), 1500);
  }, []);

  const toggleAgent = useCallback((id: string) => {
    setAgentDetails(prev => prev.map(d =>
      d.id === id ? { ...d, status: d.status === 'Running' ? 'Paused' as const : 'Running' as const } : d
    ));
  }, []);

  return { portfolio, assets, agentDetails, isRefreshing, totalBalance, activeAgentsCount, refreshPortfolio, toggleAgent };
}
