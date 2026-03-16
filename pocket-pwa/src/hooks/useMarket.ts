import { useState, useCallback, useMemo } from 'react';
import type { MarketItem, MarketTimeframe } from '../types';
import { SAMPLE_MARKET_ITEMS } from '../data/sampleData';

export function useMarket() {
  const [marketItems] = useState<MarketItem[]>(SAMPLE_MARKET_ITEMS);
  const [searchText, setSearchText] = useState('');
  const [selectedTimeframe, setSelectedTimeframe] = useState<MarketTimeframe>('1D');
  const [isLoading, setIsLoading] = useState(false);

  const filteredItems = useMemo(() => {
    if (!searchText.trim()) return marketItems;
    const lower = searchText.toLowerCase();
    return marketItems.filter(i => i.name.toLowerCase().includes(lower) || i.symbol.toLowerCase().includes(lower));
  }, [marketItems, searchText]);

  const refreshMarket = useCallback(() => {
    setIsLoading(true);
    setTimeout(() => setIsLoading(false), 1500);
  }, []);

  const selectTimeframe = useCallback((tf: MarketTimeframe) => setSelectedTimeframe(tf), []);

  return { marketItems, filteredItems, searchText, setSearchText, selectedTimeframe, isLoading, refreshMarket, selectTimeframe };
}
