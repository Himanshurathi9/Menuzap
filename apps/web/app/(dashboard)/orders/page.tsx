import React from "react";

// Mock data for the Kanban board
const mockOrders = {
  received: [
    { id: "#1042", table: "Table 7", time: "Just now", items: ["2x Iced Latte", "1x Truffle Fries"], total: "₹620" },
    { id: "#1043", table: "Table 12", time: "2 mins ago", items: ["1x Matcha Frappe"], total: "₹240" },
  ],
  preparing: [
    { id: "#1039", table: "Table 4", time: "8 mins ago", items: ["2x Cappuccino", "1x Veg Sandwich"], total: "₹340" },
  ],
  ready: [
    { id: "#1035", table: "Table 2", time: "15 mins ago", items: ["1x Grilled Chicken Panini", "1x Coke"], total: "₹360" },
  ]
};

export default function LiveOrdersPage() {
  return (
    <main className="h-screen flex flex-col p-6 lg:p-12 overflow-hidden">
      {/* Header */}
      <header className="flex justify-between items-center mb-8 flex-shrink-0">
        <div>
          <h1 className="text-3xl font-extrabold text-vapor tracking-tight flex items-center gap-3">
            Live Orders
            <span className="relative flex h-3 w-3">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-success opacity-75"></span>
              <span className="relative inline-flex rounded-full h-3 w-3 bg-success"></span>
            </span>
          </h1>
          <p className="text-vapor-muted mt-1">Manage kitchen flow in real-time.</p>
        </div>
        <div className="flex gap-3">
          <button className="bg-white/5 border border-white/10 text-vapor px-4 py-2 rounded-md hover:bg-white/10 transition">
            History
          </button>
          <button className="bg-danger/10 text-danger border border-danger/20 px-4 py-2 rounded-md hover:bg-danger/20 transition">
            Pause Orders
          </button>
        </div>
      </header>

      {/* Kanban Board */}
      <div className="flex gap-6 flex-1 overflow-x-auto pb-4 scrollbar-hide">
        
        {/* Column 1: New (Received) */}
        <div className="flex flex-col flex-1 min-w-[320px] max-w-[400px] bg-white/[0.02] border border-white/5 rounded-2xl p-4">
          <div className="flex justify-between items-center mb-4 px-2">
            <h2 className="font-bold text-vapor text-lg">New Orders</h2>
            <span className="bg-amethyst/20 text-amethyst-400 text-xs font-bold px-2 py-1 rounded-full">
              {mockOrders.received.length}
            </span>
          </div>
          <div className="flex-1 overflow-y-auto space-y-4 pr-2 custom-scrollbar">
            {mockOrders.received.map(order => (
              <OrderCard key={order.id} order={order} status="received" />
            ))}
          </div>
        </div>

        {/* Column 2: Preparing (Kitchen) */}
        <div className="flex flex-col flex-1 min-w-[320px] max-w-[400px] bg-white/[0.02] border border-white/5 rounded-2xl p-4">
          <div className="flex justify-between items-center mb-4 px-2">
            <h2 className="font-bold text-warning text-lg flex items-center gap-2">
              <span className="animate-pulse">🍳</span> Preparing
            </h2>
            <span className="bg-warning/20 text-warning text-xs font-bold px-2 py-1 rounded-full">
              {mockOrders.preparing.length}
            </span>
          </div>
          <div className="flex-1 overflow-y-auto space-y-4 pr-2 custom-scrollbar">
            {mockOrders.preparing.map(order => (
              <OrderCard key={order.id} order={order} status="preparing" />
            ))}
          </div>
        </div>

        {/* Column 3: Ready to Serve */}
        <div className="flex flex-col flex-1 min-w-[320px] max-w-[400px] bg-white/[0.02] border border-white/5 rounded-2xl p-4">
          <div className="flex justify-between items-center mb-4 px-2">
            <h2 className="font-bold text-success text-lg flex items-center gap-2">
              🚀 Ready to Serve
            </h2>
            <span className="bg-success/20 text-success text-xs font-bold px-2 py-1 rounded-full">
              {mockOrders.ready.length}
            </span>
          </div>
          <div className="flex-1 overflow-y-auto space-y-4 pr-2 custom-scrollbar">
            {mockOrders.ready.map(order => (
              <OrderCard key={order.id} order={order} status="ready" />
            ))}
          </div>
        </div>

      </div>
    </main>
  );
}

// Reusable Order Card Component
function OrderCard({ order, status }: { order: any, status: 'received' | 'preparing' | 'ready' }) {
  return (
    <div className="glass-panel p-4 rounded-xl border border-white/5 shadow-lg group cursor-pointer hover:border-amethyst/30 transition-all">
      <div className="flex justify-between items-start mb-3">
        <div>
          <span className="text-xl font-black text-vapor">{order.table}</span>
          <span className="text-vapor-muted text-sm ml-2">{order.id}</span>
        </div>
        <span className="text-xs font-medium text-vapor-muted bg-white/5 px-2 py-1 rounded">
          {order.time}
        </span>
      </div>
      
      <ul className="space-y-1 mb-4">
        {order.items.map((item: string, idx: number) => (
          <li key={idx} className="text-vapor-muted text-sm flex items-start gap-2">
            <span className="text-amethyst-400 mt-0.5">•</span> {item}
          </li>
        ))}
      </ul>

      <div className="flex justify-between items-center border-t border-white/5 pt-3 mt-2">
        <span className="font-bold text-vapor">{order.total}</span>
        
        {status === 'received' && (
          <button className="bg-warning text-warning-foreground font-bold px-3 py-1.5 rounded text-sm hover:bg-yellow-500 transition text-black">
            Start Cooking
          </button>
        )}
        {status === 'preparing' && (
          <button className="bg-success text-white font-bold px-3 py-1.5 rounded text-sm hover:bg-green-500 transition shadow-[0_0_10px_rgba(16,185,129,0.3)]">
            Mark Ready
          </button>
        )}
        {status === 'ready' && (
          <button className="bg-amethyst text-white font-bold px-3 py-1.5 rounded text-sm hover:bg-amethyst-600 transition shadow-glow-amethyst">
            Served
          </button>
        )}
      </div>
    </div>
  );
}