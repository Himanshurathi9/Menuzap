import React from "react";

// Mock data for tables
const mockTables = [
  { id: 1, name: "Table 1", status: "Occupied", activeOrders: 1 },
  { id: 2, name: "Table 2", status: "Empty", activeOrders: 0 },
  { id: 3, name: "Table 3", status: "Occupied", activeOrders: 2 },
  { id: 4, name: "Rooftop A", status: "Empty", activeOrders: 0 },
  { id: 5, name: "Rooftop B", status: "Empty", activeOrders: 0 },
  { id: 6, name: "Window 1", status: "Empty", activeOrders: 0 },
];

export default function TablesManagerPage() {
  return (
    <main className="min-h-screen p-6 lg:p-12">
      {/* Header Section */}
      <header className="flex flex-col md:flex-row md:items-center justify-between mb-10 gap-4">
        <div>
          <h1 className="text-3xl font-extrabold text-vapor tracking-tight">
            Table & QR Manager
          </h1>
          <p className="text-vapor-muted mt-1">
            Manage your floor plan and print smart QR codes.
          </p>
        </div>
        <div className="flex gap-3">
          <button className="bg-white/5 text-vapor border border-white/10 px-5 py-2.5 rounded-lg font-semibold hover:bg-white/10 transition-all flex items-center gap-2">
            <DownloadIcon />
            <span>Download All QRs (PDF)</span>
          </button>
          <button className="bg-amethyst text-white px-5 py-2.5 rounded-lg font-bold hover:bg-amethyst-600 transition-all shadow-glow-amethyst flex items-center">
            <span>+ Add Table</span>
          </button>
        </div>
      </header>

      {/* Stats Summary */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
        <div className="glass-panel p-4 rounded-xl border border-white/5">
          <p className="text-vapor-muted text-sm uppercase tracking-wider mb-1">Total Tables</p>
          <p className="text-2xl font-bold text-vapor">14</p>
        </div>
        <div className="glass-panel p-4 rounded-xl border border-white/5">
          <p className="text-vapor-muted text-sm uppercase tracking-wider mb-1">Occupied</p>
          <p className="text-2xl font-bold text-warning">2</p>
        </div>
      </div>

      {/* Tables Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        {mockTables.map((table) => (
          <div
            key={table.id}
            className="glass-panel p-5 rounded-[var(--radius)] relative group hover:border-amethyst/30 transition-all border border-white/5 flex flex-col"
          >
            <div className="flex justify-between items-start mb-4">
              <div>
                <h3 className="text-xl font-bold text-vapor">{table.name}</h3>
                {table.status === "Occupied" ? (
                  <span className="inline-flex items-center gap-1.5 mt-1 text-xs font-medium text-warning bg-warning/10 px-2 py-0.5 rounded">
                    <span className="w-1.5 h-1.5 rounded-full bg-warning animate-pulse"></span>
                    {table.activeOrders} Active Order(s)
                  </span>
                ) : (
                  <span className="inline-flex items-center gap-1.5 mt-1 text-xs font-medium text-vapor-muted bg-white/5 px-2 py-0.5 rounded">
                    Empty
                  </span>
                )}
              </div>
              
              {/* Mock QR Code Graphic */}
              <div className="w-12 h-12 bg-white rounded flex items-center justify-center p-1 border-2 border-white/10 opacity-80 group-hover:opacity-100 transition-opacity">
                <QrGraphic />
              </div>
            </div>

            <div className="mt-auto pt-4 border-t border-white/5 flex gap-2">
              <button className="flex-1 bg-white/5 hover:bg-white/10 text-vapor text-sm py-2 rounded transition-colors font-medium">
                Edit
              </button>
              <button className="flex-1 bg-amethyst/10 hover:bg-amethyst text-amethyst-400 hover:text-white text-sm py-2 rounded transition-colors font-medium">
                Print QR
              </button>
            </div>
          </div>
        ))}
      </div>
    </main>
  );
}

// Simple SVG for the Download Icon
function DownloadIcon() {
  return (
    <svg width="18" height="18" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
      <polyline points="7 10 12 15 17 10"></polyline>
      <line x1="12" y1="15" x2="12" y2="3"></line>
    </svg>
  );
}

// Abstract SVG representing a QR Code
function QrGraphic() {
  return (
    <svg width="100%" height="100%" viewBox="0 0 24 24" fill="currentColor" className="text-black">
      <path d="M3 3h6v6H3V3zm2 2v2h2V5H5zm8-2h6v6h-6V3zm2 2v2h2V5h-2zM3 15h6v6H3v-6zm2 2v2h2v-2H5zm14-2h2v2h-2v-2zm-2 2h2v2h-2v-2zm2 2h2v2h-2v-2zm-2-6h2v2h-2v-2zm-2 4h2v2h-2v-2zm-4-6h6v2h-6v-2zm0 4h2v2h-2v-2zm0 4h2v2h-2v-2z" />
    </svg>
  );
}