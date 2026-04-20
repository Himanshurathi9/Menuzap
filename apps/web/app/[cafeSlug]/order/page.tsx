import React from "react";
import Link from "next/link";

// Mock Cart Data
const mockCart = [
  { id: 1, name: "Iced Amethyst Latte", price: 220, quantity: 1, type: "veg" },
  { id: 2, name: "Truffle Parmesan Fries", price: 180, quantity: 1, type: "veg" },
];

export default function CheckoutPage({ params }: { params: { cafeSlug: string } }) {
  const subtotal = mockCart.reduce((sum, item) => sum + item.price * item.quantity, 0);
  const taxes = Math.round(subtotal * 0.05); // 5% GST mock
  const total = subtotal + taxes;

  return (
    <main className="min-h-screen bg-background pb-32 relative selection:bg-amethyst selection:text-white">
      {/* Background Ambience */}
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full h-[200px] bg-gradient-to-b from-amethyst/10 to-transparent pointer-events-none z-0"></div>

      {/* Header with Back Button */}
      <header className="relative z-10 px-6 py-6 border-b border-white/5 flex items-center justify-between bg-background/80 backdrop-blur-md sticky top-0">
        <Link href={`/${params.cafeSlug}`} className="text-vapor-muted hover:text-vapor transition-colors p-2 -ml-2 rounded-full hover:bg-white/5">
          <svg width="24" height="24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
            <line x1="19" y1="12" x2="5" y2="12"></line>
            <polyline points="12 19 5 12 12 5"></polyline>
          </svg>
        </Link>
        <h1 className="text-xl font-bold text-vapor">Checkout</h1>
        <div className="w-10"></div> {/* Spacer for centering */}
      </header>

      <div className="relative z-10 px-6 py-8 max-w-2xl mx-auto space-y-8">
        
        {/* Order Items Summary */}
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
                    <p className="font-semibold text-vapor text-base">{item.name}</p>
                    <div className="flex items-center gap-1 mt-0.5">
                      <div className={`w-2 h-2 rounded-full ${item.type === 'veg' ? 'bg-success' : 'bg-danger'}`}></div>
                      <span className="text-xs text-vapor-muted uppercase tracking-wider">{item.type}</span>
                    </div>
                  </div>
                </div>
                <p className="font-bold text-vapor">₹{item.price * item.quantity}</p>
              </div>
            ))}
          </div>
        </section>

        {/* Table & Notes Form */}
        <section className="space-y-4">
          <div className="glass-panel p-1 rounded-xl">
            <div className="bg-background/50 p-5 rounded-lg border border-white/5">
              <label className="block text-sm font-bold text-vapor-muted uppercase tracking-wider mb-2">
                Table Number
              </label>
              <select className="w-full bg-card border border-white/10 text-vapor text-lg rounded-lg p-3 focus:outline-none focus:border-amethyst transition-colors appearance-none">
                <option value="">Select your table...</option>
                <option value="1">Table 1</option>
                <option value="2">Table 2</option>
                <option value="3">Table 3</option>
                <option value="4">Table 4</option>
              </select>
            </div>
          </div>

          <div className="glass-panel p-1 rounded-xl">
            <div className="bg-background/50 p-5 rounded-lg border border-white/5">
              <label className="block text-sm font-bold text-vapor-muted uppercase tracking-wider mb-2">
                Cooking Instructions (Optional)
              </label>
              <textarea 
                rows={2} 
                placeholder="e.g., Make it extra spicy, less ice..."
                className="w-full bg-card border border-white/10 text-vapor rounded-lg p-3 focus:outline-none focus:border-amethyst transition-colors placeholder:text-white/20 resize-none"
              ></textarea>
            </div>
          </div>
        </section>

        {/* Bill Details */}
        <section className="glass-panel p-6 rounded-[var(--radius)]">
          <h2 className="text-lg font-bold text-vapor mb-4 border-b border-white/5 pb-2">Bill Details</h2>
          <div className="space-y-2 text-sm">
            <div className="flex justify-between text-vapor-muted">
              <span>Item Total</span>
              <span>₹{subtotal}</span>
            </div>
            <div className="flex justify-between text-vapor-muted">
              <span>Taxes (5%)</span>
              <span>₹{taxes}</span>
            </div>
            <div className="flex justify-between items-center pt-4 mt-2 border-t border-white/5">
              <span className="text-lg font-bold text-vapor">Grand Total</span>
              <span className="text-2xl font-black text-amethyst-400">₹{total}</span>
            </div>
          </div>
        </section>
      </div>

      {/* Sticky Action Bar */}
      <div className="fixed bottom-0 left-0 w-full bg-background/80 backdrop-blur-xl border-t border-white/10 p-4 z-50">
        <div className="max-w-2xl mx-auto">
          <button className="w-full bg-amethyst hover:bg-amethyst-600 text-white font-bold text-lg py-4 rounded-xl shadow-glow-amethyst transition-all transform active:scale-[0.98] flex items-center justify-center gap-2">
            <span>Place Order</span>
            <svg width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              <line x1="22" y1="2" x2="11" y2="13"></line>
              <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
            </svg>
          </button>
        </div>
      </div>
    </main>
  );
}