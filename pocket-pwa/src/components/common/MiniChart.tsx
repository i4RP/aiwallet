import { useRef, useEffect } from 'react';

interface MiniChartProps {
  dataPoints: number[];
  lineColor: string;
  width?: number;
  height?: number;
}

export function MiniChart({ dataPoints, lineColor, width = 60, height = 30 }: MiniChartProps) {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas || dataPoints.length < 2) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const dpr = window.devicePixelRatio || 1;
    canvas.width = width * dpr;
    canvas.height = height * dpr;
    ctx.scale(dpr, dpr);
    ctx.clearRect(0, 0, width, height);

    const min = Math.min(...dataPoints);
    const max = Math.max(...dataPoints);
    const range = max - min || 1;

    ctx.beginPath();
    ctx.strokeStyle = lineColor;
    ctx.lineWidth = 2;
    ctx.lineJoin = 'round';
    ctx.lineCap = 'round';

    dataPoints.forEach((point, i) => {
      const x = (width / (dataPoints.length - 1)) * i;
      const y = height * (1 - (point - min) / range);
      if (i === 0) ctx.moveTo(x, y);
      else ctx.lineTo(x, y);
    });
    ctx.stroke();

    // End dot
    const lastX = width;
    const lastY = height * (1 - (dataPoints[dataPoints.length - 1] - min) / range);
    ctx.beginPath();
    ctx.fillStyle = lineColor;
    ctx.arc(lastX - 1, lastY, 3, 0, Math.PI * 2);
    ctx.fill();
  }, [dataPoints, lineColor, width, height]);

  return <canvas ref={canvasRef} style={{ width, height }} />;
}
