"use client";

import React, { useState } from "react";

const cafeData = {
  name: "Sun Cafe & Roasters",
  slug: "suncafe",
  rating: "4.8",
  reviewCount: 412,
  address: "123 Amethyst Avenue, Tech District",
  bannerOffer: "Buy 1 Get 1 on All Coffees till 4 PM!",
};

const mockMenu = [
  { id: 1, name: "Iced Amethyst Latte", price: 220, description: "Our signature espresso pulled over iced lavender milk.", category: "Beverages", isVeg: true, image: "☕" },
  { id: 2, name: "Truffle Parmesan Fries", price: 180, description: "Crispy cut fries tossed in white truffle oil.", category: "Snacks", isVeg: true, image: "🍟" },
  { id: 3, name: "Smoked Chicken Panini", price: 280, description: "Sourdough filled with smoked chicken and pesto.", category: "Mains", isVeg: false, image: "🥪" },
  { id: 4, name: "Dark Velvet Brownie", price: 150, description: "Rich 70% dark chocolate brownie, served warm.", category: "Desserts", isVeg: true, image: "🍫" },
  { id: 5, name: "Ceremonial Matcha", price: 240, description: "Premium grade matcha whisked with oat milk.", category: "Beverages", isVeg: true, image: "🍵" },
];

const categories = ["All", "Beverages", "Snacks", "Mains", "Desserts"];

type CartItem = { id: number; name: string; price: number; quantity: number };

export default function PublicMenuPage({ params }: { params: { cafeSlug: string } }) {
  const [activeCategory, setActiveCategory] = useState("All");
  const [cart, setCart] = useState<CartItem[]>([]);

  const filteredMenu =
    activeCategory === "All"
      ? mockMenu
      : mockMenu.filter((item) => item.category === activeCategory);

  const cartTotal = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);
  const cartCount = cart.reduce((sum, item) => sum + item.quantity, 0);

  function addToCart(item: (typeof mockMenu)[0]) {
    setCart((prev) => {
      const existing = prev.find((c) => c.id === item.id);
      if (existing) {
        return prev.map((c) =>
          c.id === item.id ? { ...c, quantity: c.quantity + 1 } : c
        );
      }
      return [...prev, { id: item.id, name: item.name, price: item.price, quantity: 1 }];
    });
  }

  return (
    <main className="min-h-screen bg-background pb-28 relative selection:bg-amethyst selection:text-white">
      {/* Background Glow */}
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[80%] h-[300px] bg-amethyst/10 blur-[120px] rounded-full pointer-events-none z-0" />

      {/* Hero Header */}
      <header className="relative z-10 pt-10 pb-6 px-6 text-center border-b border-white/5">
        <h1 className="text-4xl font-extrabold text-vapor text-glow tracking-tight mb-2">
          {cafeData.name}
        </h1>
        <div className="flex items-center justify-center gap-2 text-sm text-vapor-muted mb-4">
          <span className="flex items-center text-warning font-bold">
            <svg className="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z" />
            </svg>
            {cafeData.rating}
          </span>
          <span>•</span>
          <span>{cafeData.reviewCount} Reviews</span>
        </div>
        <div className="inline-block bg-gradient-to-r from-amethyst-600 to-amethyst px-6 py-2 rounded-full shadow-glow-amethyst animate-pulse-slow">
          <p className="text-white font-bold text-sm tracking-wide">✨ {cafeData.bannerOffer}</p>
        </div>
      </header>

      {/* Sticky Category Bar */}
      <div className="sticky top-0 z-30 bg-background/80 backdrop-blur-xl border-b border-white/5 py-4 px-6 overflow-x-auto scrollbar-hide flex gap-3">
        {categories.map((cat) => (
          <button
            key={cat}
            onClick={() => setActiveCategory(cat)}
            className={`whitespace-nowrap px-5 py-2 rounded-full font-semibold transition-all ${
              activeCategory === cat
                ? "bg-vapor text-background"
                : "bg-white/5 text-vapor hover:bg-white/10 border border-white/5"
            }`}
          >
            {cat}
          </button>
        ))}
      </div>

      {/* Menu Grid */}
      <div className="relative z-10 px-6 py-8 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 max-w-7xl mx-auto">
        {filteredMenu.map((item) => (
          <div key={item.id} className="glass-panel rounded-[var(--radius)] overflow-hidden flex flex-col group">
            <div className="h-48 w-full bg-card/50 flex items-center justify-center text-7xl relative overflow-hidden">
              <span className="group-hover:scale-110 transition-transform duration-500">{item.image}</span>
              <div className="absolute top-4 right-4 bg-background/80 backdrop-blur-sm p-1.5 rounded border border-white/10">
                <div className={`w-3 h-3 rounded-sm border-2 flex items-center justify-center ${item.isVeg ? "border-success" : "border-danger"}`}>
                  <div className={`w-1 h-1 rounded-full ${item.isVeg ? "bg-success" : "bg-danger"}`} />
                </div>
              </div>
            </div>
            <div className="p-5 flex-1 flex flex-col justify-between">
              <div>
                <div className="flex justify-between items-start mb-2">
                  <h3 className="font-bold text-lg text-vapor">{item.name}</h3>
                  <span className="font-black text-amethyst-400">₹{item.price}</span>
                </div>
                <p className="text-sm text-vapor-muted leading-relaxed line-clamp-2">{item.description}</p>
              </div>
              <button
                onClick={() => addToCart(item)}
                className="mt-5 w-full py-3 rounded-lg font-bold border border-white/10 bg-white/5 text-vapor hover:bg-amethyst hover:text-white hover:border-amethyst transition-all shadow-sm hover:shadow-glow-amethyst"
              >
                Add to Order
              </button>
            </div>
          </div>
        ))}

        {filteredMenu.length === 0 && (
          <div className="col-span-full text-center py-20 text-vapor-muted">
            <p className="text-4xl mb-4">🍽️</p>
            <p className="font-semibold text-lg">No items in this category yet.</p>
          </div>
        )}
      </div>

      {/* Floating Cart Button */}
      {cartCount > 0 && (
        <div className="fixed bottom-6 left-1/2 -translate-x-1/2 w-11/12 max-w-md z-50 animate-slide-up">
          <div className="bg-vapor text-background px-6 py-4 rounded-2xl shadow-[0_20px_40px_rgba(0,0,0,0.5)] flex justify-between items-center cursor-pointer hover:scale-[1.02] transition-transform">
            <div className="flex items-center gap-3">
              <div className="bg-background text-vapor w-8 h-8 rounded-full flex items-center justify-center font-bold">
                {cartCount}
              </div>
              <div>
                <p className="font-bold text-sm">View your order</p>
                <p className="text-xs font-semibold opacity-70">
                  {cart.map((c) => c.name).slice(0, 2).join(", ")}
                  {cart.length > 2 ? " ..." : ""}
                </p>
              </div>
            </div>
            <p className="font-black text-lg">₹{cartTotal}</p>
          </div>
        </div>
      )}
    </main>
  );
}