import React from "react";

// Mock data to visualize the UI before we connect Supabase
const mockCategories = ["All Items", "Beverages", "Breakfast", "Snacks", "Desserts"];
const mockItems = [
  { id: 1, name: "Iced Amethyst Latte", price: "₹220", category: "Beverages", status: "Available", isVeg: true, image: "☕" },
  { id: 2, name: "Truffle Fries", price: "₹180", category: "Snacks", status: "Available", isVeg: true, image: "🍟" },
  { id: 3, name: "Grilled Chicken Panini", price: "₹280", category: "Breakfast", status: "Out of Stock", isVeg: false, image: "🥪" },
  { id: 4, name: "Dark Chocolate Brownie", price: "₹150", category: "Desserts", status: "Available", isVeg: true, image: "🍫" },
  { id: 5, name: "Matcha Frappe", price: "₹240", category: "Beverages", status: "Available", isVeg: true, image: "🍵" },
];

export default function MenuManagerPage() {
  return (
    <main className="min-h-screen p-6 lg:p-12">
      {/* Header Section */}
      <header className="flex flex-col md:flex-row md:items-center justify-between mb-10 gap-4">
        <div>
          <h1 className="text-3xl font-extrabold text-vapor tracking-tight">
            Menu Manager
          </h1>
          <p className="text-vapor-muted mt-1">
            Add, edit, and organize your digital menu.
          </p>
        </div>
        <button className="bg-amethyst text-white px-5 py-2.5 rounded-lg font-bold hover:bg-amethyst-600 transition-all shadow-glow-amethyst flex items-center justify-center space-x-2">
          <span>+ Add New Dish</span>
        </button>
      </header>

      {/* Category Tabs */}
      <div className="flex overflow-x-auto pb-4 mb-6 space-x-2 scrollbar-hide">
        {mockCategories.map((category, index) => (
          <button
            key={category}
            className={`whitespace-nowrap px-4 py-2 rounded-full font-medium transition-all ${
              index === 0
                ? "bg-amethyst text-white shadow-glow-amethyst"
                : "bg-white/5 text-vapor-muted hover:bg-white/10 hover:text-vapor border border-white/5"
            }`}
          >
            {category}
          </button>
        ))}
      </div>

      {/* Menu Items Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        {mockItems.map((item) => (
          <div
            key={item.id}
            className="glass-panel p-5 rounded-[var(--radius)] relative group hover:-translate-y-1 transition-transform duration-300 flex flex-col"
          >
            {/* Out of stock overlay */}
            {item.status === "Out of Stock" && (
              <div className="absolute inset-0 bg-background/60 backdrop-blur-[2px] z-10 rounded-[var(--radius)] flex items-center justify-center">
                <span className="bg-danger/20 text-danger border border-danger/30 px-3 py-1 rounded-md font-bold uppercase tracking-wide text-sm transform -rotate-12">
                  Sold Out
                </span>
              </div>
            )}

            {/* Dish Image Placeholder */}
            <div className="h-40 w-full bg-white/5 rounded-lg mb-4 flex items-center justify-center text-5xl border border-white/5">
              {item.image}
            </div>

            {/* Dish Info */}
            <div className="flex-1">
              <div className="flex justify-between items-start mb-2">
                <h3 className="text-lg font-bold text-vapor leading-tight pr-2">
                  {item.name}
                </h3>
                {/* Veg / Non-Veg Indicator */}
                <div className={`w-4 h-4 rounded-sm border-2 flex items-center justify-center flex-shrink-0 ${item.isVeg ? 'border-success' : 'border-danger'}`}>
                  <div className={`w-1.5 h-1.5 rounded-full ${item.isVeg ? 'bg-success' : 'bg-danger'}`}></div>
                </div>
              </div>
              <p className="text-amethyst-400 font-bold text-xl">{item.price}</p>
              <p className="text-vapor-muted text-sm mt-1">{item.category}</p>
            </div>

            {/* Action Buttons */}
            <div className="mt-6 pt-4 border-t border-white/5 flex justify-between items-center relative z-20">
              <button className="text-sm font-medium text-vapor-muted hover:text-vapor transition-colors">
                Edit Item
              </button>
              <button className={`w-10 h-5 rounded-full relative transition-colors ${item.status === 'Available' ? 'bg-success' : 'bg-white/10'}`}>
                <span className={`absolute top-0.5 left-0.5 bg-white w-4 h-4 rounded-full transition-transform ${item.status === 'Available' ? 'translate-x-5' : 'translate-x-0'}`}></span>
              </button>
            </div>
          </div>
        ))}
      </div>
    </main>
  );
}