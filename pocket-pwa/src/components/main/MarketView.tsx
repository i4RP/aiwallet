import { Search, X, ArrowUpRight, ArrowDownRight } from 'lucide-react';
import type { MarketItem, MarketTimeframe } from '../../types';
import { MiniChart } from '../common/MiniChart';
import { TOKEN_COLORS } from '../../data/sampleData';
import { useMarket } from '../../hooks/useMarket';

const TIMEFRAMES: MarketTimeframe[] = ['1H', '1D', '1W', '1M', '1Y'];

export function MarketView() {
  const { filteredItems, searchText, setSearchText, selectedTimeframe, selectTimeframe } = useMarket();

  return (
    <div className="flex-1 flex flex-col overflow-hidden">
      {/* Header */}
      <div className="px-5 pt-4">
        <h1 className="text-2xl font-bold text-white mb-3">Market</h1>
        {/* Search */}
        <div className="flex items-center gap-2.5 rounded-xl px-3.5 py-2.5" style={{ backgroundColor: '#1F1F24', border: '1px solid #333338' }}>
          <Search size={15} style={{ color: '#8C8C99' }} />
          <input type="text" placeholder="Search tokens..." value={searchText}
            onChange={e => setSearchText(e.target.value)}
            className="flex-1 bg-transparent text-white text-sm outline-none placeholder-gray-500" />
          {searchText && (
            <button onClick={() => setSearchText('')}>
              <X size={15} style={{ color: '#8C8C99' }} />
            </button>
          )}
        </div>
      </div>

      {/* Timeframe Selector */}
      <div className="flex gap-1.5 px-5 py-2">
        {TIMEFRAMES.map(tf => (
          <button key={tf} onClick={() => selectTimeframe(tf)}
            className="px-3.5 py-1.5 rounded-full text-sm font-semibold"
            style={{
              backgroundColor: selectedTimeframe === tf ? 'rgba(0,217,242,0.2)' : 'transparent',
              color: selectedTimeframe === tf ? '#FFFFFF' : '#8C8C99',
            }}>
            {tf}
          </button>
        ))}
      </div>

      {/* Market List */}
      <div className="flex-1 overflow-y-auto px-5 pb-24 no-scrollbar">
        <div className="flex flex-col gap-3 pt-3">
          {filteredItems.map(item => (<MarketRow key={item.id} item={item} />))}
        </div>
      </div>
    </div>
  );
}

function MarketRow({ item }: { item: MarketItem }) {
  const tokenColor = TOKEN_COLORS[item.symbol] || '#8C8C99';

  const formatPrice = (price: number) => {
    if (price >= 1000) return `$${price.toFixed(0)}`;
    if (price >= 1) return `$${price.toFixed(2)}`;
    return `$${price.toFixed(4)}`;
  };

  return (
    <div className="flex items-center gap-3 p-3.5 rounded-xl" style={{ backgroundColor: '#1F1F24' }}>
      <div className="w-10 h-10 rounded-full flex items-center justify-center" style={{ backgroundColor: tokenColor }}>
        <span className="text-white text-base font-bold">{item.symbol[0]}</span>
      </div>
      <div className="flex-1 min-w-0">
        <p className="text-sm font-semibold text-white">{item.name}</p>
        <p className="text-sm font-medium" style={{ color: '#8C8C99' }}>{item.symbol}</p>
      </div>
      <div className="mx-2">
        <MiniChart dataPoints={item.chartPoints} lineColor={item.isUp ? '#33CC66' : '#E63333'} width={60} height={30} />
      </div>
      <div className="flex flex-col items-end gap-1">
        <span className="text-sm font-semibold text-white">{formatPrice(item.price)}</span>
        <div className="flex items-center gap-0.5" style={{ color: item.isUp ? '#33CC66' : '#E63333' }}>
          {item.isUp ? <ArrowUpRight size={10} /> : <ArrowDownRight size={10} />}
          <span className="text-xs font-medium">{item.changePercent.toFixed(1)}%</span>
        </div>
      </div>
    </div>
  );
}
