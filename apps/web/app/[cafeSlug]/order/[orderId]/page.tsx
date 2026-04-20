"use client";

import React, { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";

const mockCart = [
  { id: 1, name: "Iced Amethyst Latte", price: 220, quantity: 1, type: "veg" },
  { id: 2, name: "Truffle Parmesan Fries", price: 180, quantity: 1, type: "veg" },
];

const TABLES = ["Table 1", "Table 2", "Table 3", "Table 4", "Table 5", "Table 6", "Rooftop A", "Rooftop B", "Window 1"];

export default function CheckoutPage({ params }: { params: { cafeSlug: string } }) {
  const router = useRouter();
  const [selectedTable, setSelectedTable] = useState("");
  const [notes, setNotes] = useState("");
  const [isPlacing, setIsPlacing] = useState(false);
  const [placed, setPlaced] = useState(false);

  const subtotal = mockCart.reduce((sum, item) => sum + item.price * item.quantity, 0);
  const taxes = Math.round(subtotal * 0.05);
  const total = subtotal + taxes;

  async function placeOrder() {
    if (!selectedTable) return;
    setIsPlacing(true);
    // TODO: POST to /api/orders with cart, tableId, notes, cafeSlug
    await new Promise((r) => setTimeout(r, 1200));
    setIsPlacing(false);
    setPlaced(true);
    // Redirect to order tracking after 2s
    setTimeout(() => router.push(`/${params.cafeSlug}/order/ord_mock123`), 2000);
  }

  if (placed) {
    return (
      <div className="min-h-screen bg-background flex flex-col items-center justify-center text-center px-6">
        <div className="text-7xl mb-6 animate-bounce">🎉</div>
        <h1 className="text-3xl font-extrabold text-vapor mb-3">Order Placed!</h1>
        <p className="text-vapor-muted mb-2">Your order is on its way to the kitchen.</p>
        <p className="text-amethyst-400 font-semibold">{selectedTable}</p>
        <p className="text-vapor-muted text-sm mt-6">Redirecting to order status...</p>
      </div>
    );
  }

  return (
    <main className="min-h-screen bg-background pb-32 relative selection:bg-amethyst selection:text-white">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full h-[200px] bg-gradient-to-b from-amethyst/10 to-transparent pointer-events-none z-0" />

      <header className="relative z-10 px-6 py-6 border-b border-white/5 flex items-center justify-between bg-background/80 backdrop-blur-md sticky top-0">
        <Link href={`/${params.cafeSlug}`} className="text-vapor-muted hover:text-vapor transition-colors p-2 -ml-2 rounded-full hover:bg-white/5">
          <svg width="24" height="24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <line x1="19" y1="12" x2="5" y2="12" />
            <polyline points="12 19 5 12 12 5" />
          </svg>
        </Link>
        <h1 className="text-xl font-bold text-vapor">Checkout</h1>
        <div className="w-10" />
      </header>

      <div className="relative z-10 px-6 py-8 max-w-2xl mx-auto space-y-6">
        {/* Order Items */}
        <section className="glass-panel p-6 rounded-[var(--radius)]">
          <h2 className="text-lg font-bold text-vapor mb-4 border-b border-white/5 pb-2">Your Items</h2>
          <div className="space-y-4">
            {mockCart.map((item) => (
              <div key={item.id} className="flex justify-between items-center">
                <div className="flex items-center gap-3">
                  <div className="bg-white/5 border border-white/10 text-vapor w-8 h-8 rounded flex items-center justify-center font-bold text-sm">
                    {item.quantity}x
                  </div>
                  <div>
                    <p className="font-semibold text-vapor">{item.name}</p>
                    <div className="flex items-center gap-1 mt-0.5">
                      <div className={`w-2 h-2 rounded-full ${item.type === "veg" ? "bg-success" : "bg-danger"}`} />
                      <span className="text-xs text-vapor-muted uppercase tracking-wider">{item.type}</span>
                    </div>
                  </div>
                </div>
                <p className="font-bold text-vapor">₹{item.price * item.quantity}</p>
              </div>
            ))}
          </div>
        </section>

        {/* Table Selection */}
        <section className="glass-panel p-5 rounded-[var(--radius)]">
          <label className="block text-sm font-bold text-vapor-muted uppercase tracking-wider mb-2">
            Table Number <span className="text-danger">*</span>
          </label>
          <select
            value={selectedTable}
            onChange={(e) => setSelectedTable(e.target.value)}
            className="w-full bg-card border border-white/10 text-vapor text-base rounded-lg p-3 focus:outline-none focus:border-amethyst transition-colors appearance-none"
          >
            <option value="">Select your table...</option>
            {TABLES.map((t) => <option key={t} value={t}>{t}</option>)}
          </select>
        </section>

        {/* Notes */}
        <section className="glass-panel p-5 rounded-[var(--radius)]">
          <label className="block text-sm font-bold text-vapor-muted uppercase tracking-wider mb-2">
            Cooking Instructions (Optional)
          </label>
          <textarea
            rows={2}
            value={notes}
            onChange={(e) => setNotes(e.target.value)}
            placeholder="e.g., Make it extra spicy, less ice..."
            className="w-full bg-card border border-white/10 text-vapor rounded-lg p-3 focus:outline-none focus:border-amethyst transition-colors placeholder:text-white/20 resize-none"
          />
        </section>

        {/* Bill Summary */}
        <section className="glass-panel p-6 rounded-[var(--radius)]">
          <h2 className="text-lg font-bold text-vapor mb-4 border-b border-white/5 pb-2">Bill Details</h2>
          <div className="space-y-2 text-sm">
            <div className="flex justify-between text-vapor-muted">
              <span>Item Total</span><span>₹{subtotal}</span>
            </div>
            <div className="flex justify-between text-vapor-muted">
              <span>GST (5%)</span><span>₹{taxes}</span>
            </div>
            <div className="flex justify-between items-center pt-4 mt-2 border-t border-white/5">
              <span className="text-lg font-bold text-vapor">Grand Total</span>
              <span className="text-2xl font-black text-amethyst-400">₹{total}</span>
            </div>
          </div>
        </section>
      </div>

      <div className="fixed bottom-0 left-0 w-full bg-background/80 backdrop-blur-xl border-t border-white/10 p-4 z-50">
        <div className="max-w-2xl mx-auto">
          <button
            onClick={placeOrder}
            disabled={!selectedTable || isPlacing}
            className="w-full bg-amethyst hover:bg-amethyst-600 disabled:opacity-50 disabled:cursor-not-allowed text-white font-bold text-lg py-4 rounded-xl shadow-glow-amethyst transition-all flex items-center justify-center gap-2"
          >
            {isPlacing ? (
              <span className="flex items-center gap-2">
                <svg className="animate-spin w-5 h-5" fill="none" viewBox="0 0 24 24">
                  <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                  <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z" />
                </svg>
                Placing Order...
              </span>
            ) : (
              <>
                <span>Place Order</span>
                <svg width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                  <line x1="22" y1="2" x2="11" y2="13" />
                  <polygon points="22 2 15 22 11 13 2 9 22 2" />
                </svg>
              </>
            )}
          </button>
          {!selectedTable && (
            <p className="text-center text-vapor-muted text-xs mt-2">Please select a table to continue</p>
          )}
        </div>
      </div>
    </main>
  );
}