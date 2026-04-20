import React from "react";

export default function DashboardHome() {
  return (
    <main className="min-h-screen bg-background p-6 lg:p-12">
      {/* Header Section */}
      <header className="mb-10">
        <h1 className="text-4xl font-extrabold text-vapor text-glow tracking-tight">
          CafeOS Dashboard
        </h1>
        <p className="text-vapor-muted mt-2 text-lg">
          Welcome back. Here is your real-time pulse.
        </p>
      </header>

      {/* Top Level Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-10">
        {/* Revenue Card */}
        <div className="glass-panel p-6 rounded-[var(--radius)] relative overflow-hidden group transition-all duration-300 hover:-translate-y-1">
          <div className="absolute inset-0 bg-amethyst/10 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
          <h3 className="text-vapor-muted text-sm font-medium uppercase tracking-wider">
            Today's Revenue
          </h3>
          <p className="text-4xl font-bold text-vapor mt-2">₹14,250</p>
          <div className="mt-4 inline-flex items-center text-success text-sm font-semibold bg-success/10 px-2 py-1 rounded-md">
            <span>↑ 12% from yesterday</span>
          </div>
        </div>

        {/* Live Orders Card */}
        <div className="glass-panel p-6 rounded-[var(--radius)] relative overflow-hidden group transition-all duration-300 hover:-translate-y-1">
          <div className="absolute inset-0 bg-warning/10 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
          <h3 className="text-vapor-muted text-sm font-medium uppercase tracking-wider">
            Active Orders
          </h3>
          <p className="text-4xl font-bold text-vapor mt-2">7</p>
          <div className="mt-4 inline-flex items-center text-warning text-sm font-semibold bg-warning/10 px-2 py-1 rounded-md">
            <span className="animate-pulse">3 orders preparing</span>
          </div>
        </div>

        {/* Top Item Card */}
        <div className="glass-panel p-6 rounded-[var(--radius)] relative overflow-hidden group transition-all duration-300 hover:-translate-y-1">
          <div className="absolute inset-0 bg-amethyst/10 opacity-0 group-hover:opacity-100 transition-opacity duration-500" />
          <h3 className="text-vapor-muted text-sm font-medium uppercase tracking-wider">
            Top Item Today
          </h3>
          <p className="text-4xl font-bold text-amethyst-400 mt-2">Iced Latte</p>
          <div className="mt-4 inline-flex items-center text-vapor-muted text-sm font-semibold bg-white/5 px-2 py-1 rounded-md">
            <span>Ordered 24 times</span>
          </div>
        </div>
      </div>

      {/* Recent Orders Feed Placeholder */}
      <section className="glass-panel p-6 rounded-[var(--radius)]">
        <div className="flex justify-between items-center mb-6">
          <h2 className="text-2xl font-bold text-vapor">Live Order Feed</h2>
          <button className="bg-amethyst text-white px-4 py-2 rounded-md font-medium hover:bg-amethyst-600 transition-colors shadow-glow-amethyst">
            View All Orders
          </button>
        </div>
        
        <div className="space-y-4">
          <div className="border border-white/10 rounded-lg p-4 flex justify-between items-center bg-white/5 hover:bg-white/10 transition-colors">
            <div>
              <p className="text-vapor font-bold text-lg">Table 4 <span className="text-vapor-muted text-sm font-normal ml-2">2 mins ago</span></p>
              <p className="text-vapor-muted mt-1">2x Cappuccino, 1x Veg Sandwich</p>
            </div>
            <div className="text-right">
              <p className="text-vapor font-bold">₹340</p>
              <span className="text-warning text-sm font-semibold uppercase tracking-wider">Preparing</span>
            </div>
          </div>
        </div>
      </section>
    </main>
  );
}