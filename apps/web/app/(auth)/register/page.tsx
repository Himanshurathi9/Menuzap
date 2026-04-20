"use client";

import React, { useState } from "react";
import Link from "next/link";

const BUSINESS_TYPES = ["Cafe", "Restaurant", "Hotel", "Bar", "Bakery", "Cloud Kitchen"];

export default function RegisterPage() {
  const [step, setStep] = useState(1);
  const [form, setForm] = useState({
    name: "",
    email: "",
    password: "",
    phone: "",
    cafeName: "",
    cafeSlug: "",
    businessType: "Cafe",
  });
  const [isLoading, setIsLoading] = useState(false);

  function handleChange(e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) {
    const { name, value } = e.target;
    setForm((prev) => {
      const updated = { ...prev, [name]: value };
      // Auto-generate slug from cafe name
      if (name === "cafeName") {
        updated.cafeSlug = value
          .toLowerCase()
          .trim()
          .replace(/[^\w\s]/g, "")
          .replace(/\s+/g, "");
      }
      return updated;
    });
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (step < 2) { setStep(2); return; }
    setIsLoading(true);
    await new Promise((r) => setTimeout(r, 1200));
    setIsLoading(false);
    window.location.href = "/onboarding";
  }

  return (
    <div className="min-h-screen bg-background flex items-center justify-center px-4 relative">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[60%] h-[300px] bg-amethyst/10 blur-[120px] rounded-full pointer-events-none" />

      <div className="w-full max-w-md relative z-10 animate-fade-in">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-black text-vapor">
            Cafe<span className="text-amethyst text-glow">OS</span>
          </h1>
          <p className="text-vapor-muted mt-2">
            {step === 1 ? "Create your account" : "Set up your cafe"}
          </p>
        </div>

        {/* Step Indicator */}
        <div className="flex items-center gap-2 mb-6 justify-center">
          {[1, 2].map((s) => (
            <React.Fragment key={s}>
              <div className={`w-8 h-8 rounded-full flex items-center justify-center text-sm font-bold transition-all ${
                step >= s ? "bg-amethyst text-white" : "bg-white/5 text-vapor-muted"
              }`}>
                {s}
              </div>
              {s < 2 && <div className={`flex-1 h-0.5 max-w-12 transition-all ${step > s ? "bg-amethyst" : "bg-white/10"}`} />}
            </React.Fragment>
          ))}
        </div>

        <div className="glass-panel rounded-2xl p-8">
          <form onSubmit={handleSubmit} className="space-y-5">
            {step === 1 && (
              <>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Full Name</label>
                  <input name="name" type="text" value={form.name} onChange={handleChange} required placeholder="Your name" className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors" />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Email</label>
                  <input name="email" type="email" value={form.email} onChange={handleChange} required placeholder="you@yourcafe.com" className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors" />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Phone (WhatsApp)</label>
                  <input name="phone" type="tel" value={form.phone} onChange={handleChange} required placeholder="+91 98765 43210" className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors" />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Password</label>
                  <input name="password" type="password" value={form.password} onChange={handleChange} required minLength={8} placeholder="Min 8 characters" className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors" />
                </div>
              </>
            )}

            {step === 2 && (
              <>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Cafe / Restaurant Name</label>
                  <input name="cafeName" type="text" value={form.cafeName} onChange={handleChange} required placeholder="Sun Cafe & Roasters" className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors" />
                </div>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Your Public URL</label>
                  <div className="flex items-center bg-card border border-white/10 rounded-lg overflow-hidden focus-within:border-amethyst transition-colors">
                    <span className="px-3 py-3 text-vapor-muted text-sm border-r border-white/10 bg-white/5 shrink-0">menumate.app/</span>
                    <input name="cafeSlug" type="text" value={form.cafeSlug} onChange={handleChange} required placeholder="suncafe" className="flex-1 bg-transparent text-vapor px-3 py-3 placeholder:text-white/20 focus:outline-none" />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">Business Type</label>
                  <select name="businessType" value={form.businessType} onChange={handleChange} className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 focus:outline-none focus:border-amethyst transition-colors appearance-none">
                    {BUSINESS_TYPES.map((t) => <option key={t} value={t}>{t}</option>)}
                  </select>
                </div>
              </>
            )}

            <button type="submit" disabled={isLoading} className="w-full bg-amethyst hover:bg-amethyst-600 disabled:opacity-60 text-white font-bold py-4 rounded-xl shadow-glow-amethyst transition-all">
              {isLoading ? "Creating account..." : step === 1 ? "Continue →" : "Create My Cafe"}
            </button>
          </form>

          <p className="text-center text-vapor-muted text-sm mt-6">
            Already have an account?{" "}
            <Link href="/login" className="text-amethyst-400 hover:text-amethyst font-semibold transition-colors">
              Sign in
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}