import { useState, useEffect, useCallback } from 'react';
import { PocketLogo } from './common/PocketLogo';
import { MiniChart } from './common/MiniChart';
import { SAMPLE_STOCK, AGENTS } from '../data/sampleData';
import type { CarouselCardType } from '../types';

const CARD_TYPES: CarouselCardType[] = ['portfolio', 'chat', 'stockChart'];

interface WelcomeViewProps {
  onGetStarted: () => void;
}

export function WelcomeView({ onGetStarted }: WelcomeViewProps) {
  const [currentCard, setCurrentCard] = useState(0);
  const [showContent, setShowContent] = useState(false);

  useEffect(() => { setShowContent(true); }, []);

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentCard(prev => (prev + 1) % CARD_TYPES.length);
    }, 4000);
    return () => clearInterval(timer);
  }, []);

  return (
    <div className="fixed inset-0 bg-black flex flex-col">
      <div className="flex-1 flex flex-col items-center pt-5">
        {/* Logo */}
        <div className={`transition-all duration-600 ${showContent ? 'opacity-100 translate-y-0' : 'opacity-0 -translate-y-5'}`}
             style={{ transitionDelay: '200ms' }}>
          <PocketLogo />
        </div>

        <div className="h-6" />

        {/* Carousel */}
        <div className={`w-full px-6 transition-all duration-600 ${showContent ? 'opacity-100 scale-100' : 'opacity-0 scale-95'}`}
             style={{ transitionDelay: '400ms' }}>
          <CarouselCards currentCard={currentCard} />
          {/* Page Dots */}
          <div className="flex justify-center gap-2 mt-4">
            {CARD_TYPES.map((_, i) => (
              <button key={i} onClick={() => setCurrentCard(i)}
                className={`rounded-full transition-all duration-300 ${i === currentCard ? 'w-6 h-2' : 'w-2 h-2'}`}
                style={{ backgroundColor: i === currentCard ? '#00D9F2' : '#8C8C99' }} />
            ))}
          </div>
        </div>

        <div className="flex-1" />

        {/* Get Started Button */}
        <div className={`w-full px-10 transition-all duration-600 ${showContent ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-5'}`}
             style={{ transitionDelay: '600ms' }}>
          <button onClick={onGetStarted}
            className="w-full h-14 rounded-full text-lg font-semibold text-black"
            style={{ backgroundColor: '#00D9F2' }}>
            Get started
          </button>
        </div>

        {/* Terms */}
        <div className={`mt-4 mb-6 text-center transition-all duration-600 ${showContent ? 'opacity-100' : 'opacity-0'}`}
             style={{ transitionDelay: '800ms' }}>
          <p className="text-xs" style={{ color: '#8C8C99' }}>By continuing you agree to our</p>
          <button className="text-xs font-medium underline" style={{ color: '#00D9F2' }}>
            Terms & Conditions
          </button>
        </div>
      </div>
    </div>
  );
}

function CarouselCards({ currentCard }: { currentCard: number }) {
  const renderCard = useCallback((type: CarouselCardType) => {
    switch (type) {
      case 'portfolio': return <PortfolioCard />;
      case 'chat': return <ChatCard />;
      case 'stockChart': return <StockChartCard />;
    }
  }, []);

  return (
    <div className="relative overflow-hidden rounded-2xl" style={{ backgroundColor: '#1F1F24', height: '320px' }}>
      {CARD_TYPES.map((type, i) => (
        <div key={type}
          className="absolute inset-0 transition-all duration-500 ease-in-out"
          style={{
            transform: `translateX(${(i - currentCard) * 100}%)`,
            opacity: i === currentCard ? 1 : 0,
          }}>
          {renderCard(type)}
        </div>
      ))}
    </div>
  );
}

function PortfolioCard() {
  return (
    <div className="h-full flex flex-col items-center justify-center p-6">
      <p className="text-sm font-medium mb-2" style={{ color: '#8C8C99' }}>Total Balance</p>
      <p className="text-4xl font-bold text-white mb-3" style={{ fontFamily: 'system-ui' }}>$62.18</p>
      <div className="flex items-center gap-1.5 mb-6">
        <span className="text-sm font-bold" style={{ color: '#E63333' }}>
          <span className="mr-1">&#8600;</span>6.1%
        </span>
        <span className="text-sm" style={{ color: '#8C8C99' }}>today</span>
      </div>
      <div className="flex gap-3 w-full">
        {AGENTS.map(agent => (
          <div key={agent.id} className="flex-1 rounded-xl p-3 flex flex-col items-center gap-2"
               style={{ backgroundColor: '#2A2A2F' }}>
            <div className="w-8 h-8 rounded-full flex items-center justify-center"
                 style={{ backgroundColor: agent.color }}>
              <span className="text-white text-xs font-bold">{agent.name[0]}</span>
            </div>
            <span className="text-xs font-medium text-white">{agent.name}</span>
            <div className="flex items-center gap-1">
              <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: '#33CC66' }} />
              <span className="text-xs" style={{ color: '#33CC66' }}>Running</span>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

function ChatCard() {
  return (
    <div className="h-full flex flex-col p-5">
      <div className="flex items-center gap-2 mb-4">
        <div className="w-8 h-8 rounded-full" style={{ backgroundColor: '#C7A64D' }} />
        <div>
          <p className="text-sm font-semibold text-white">Stocks Trader</p>
          <p className="text-xs" style={{ color: '#8C8C99' }}>3:42 pm</p>
        </div>
      </div>
      <p className="text-sm mb-3" style={{ color: '#8C8C99' }}>
        TSLA hit my entry range. Looking at a good setup here.
      </p>
      <div className="self-end rounded-full px-4 py-2 mb-3" style={{ backgroundColor: '#3F3F47' }}>
        <p className="text-sm font-medium text-white">Nice. What did you do?</p>
      </div>
      <div className="flex items-center gap-2 mb-2">
        <div className="w-8 h-8 rounded-full" style={{ backgroundColor: '#C7A64D' }} />
        <div>
          <p className="text-sm font-semibold text-white">Stocks Trader</p>
          <p className="text-xs" style={{ color: '#8C8C99' }}>3:45 pm</p>
        </div>
      </div>
      <p className="text-sm mb-3" style={{ color: '#8C8C99' }}>Executed a buy at the support level.</p>
      <div className="flex items-center gap-2 rounded-full px-3 py-2 self-start" style={{ backgroundColor: '#2E2E32' }}>
        <div className="w-6 h-6 rounded-full flex items-center justify-center" style={{ backgroundColor: '#E63333' }}>
          <span className="text-xs font-bold text-white">T</span>
        </div>
        <span className="text-sm font-semibold text-white">Bought 24.3 TSLA</span>
      </div>
    </div>
  );
}

function StockChartCard() {
  return (
    <div className="h-full flex flex-col items-center justify-center p-6">
      <div className="flex items-center gap-2 mb-2">
        <div className="w-8 h-8 rounded-full flex items-center justify-center" style={{ backgroundColor: '#E63333' }}>
          <span className="text-white text-xs font-bold">T</span>
        </div>
        <span className="text-lg font-bold text-white">{SAMPLE_STOCK.ticker}</span>
      </div>
      <p className="text-3xl font-bold text-white mb-2">${SAMPLE_STOCK.price}</p>
      <div className="w-full my-4">
        <MiniChart dataPoints={SAMPLE_STOCK.chartPoints} lineColor={SAMPLE_STOCK.color} width={280} height={80} />
      </div>
      <div className="flex items-center gap-2 mt-2 rounded-full px-3 py-1.5" style={{ backgroundColor: '#2A2A2F' }}>
        <div className="w-1.5 h-1.5 rounded-full" style={{ backgroundColor: '#33CC66' }} />
        <span className="text-xs font-medium" style={{ color: '#33CC66' }}>Stocks Agent Running</span>
      </div>
    </div>
  );
}
