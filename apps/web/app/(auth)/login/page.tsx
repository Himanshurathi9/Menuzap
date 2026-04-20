"use client";

import React, { useState } from "react";
import Link from "next/link";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState("");

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    setIsLoading(true);
    setError("");

    try {
      // TODO: connect to NextAuth signIn("credentials", { email, password })
      await new Promise((r) => setTimeout(r, 1000)); // mock delay
      // On success, redirect to dashboard
      window.location.href = "/";
    } catch {
      setError("Invalid email or password. Please try again.");
    } finally {
      setIsLoading(false);
    }
  }

  return (
    <div className="min-h-screen bg-background flex items-center justify-center px-4 relative">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[60%] h-[300px] bg-amethyst/10 blur-[120px] rounded-full pointer-events-none" />

      <div className="w-full max-w-md relative z-10 animate-fade-in">
        {/* Logo */}
        <div className="text-center mb-8">
          <h1 className="text-3xl font-black text-vapor">
            Cafe<span className="text-amethyst text-glow">OS</span>
          </h1>
          <p className="text-vapor-muted mt-2">Sign in to your dashboard</p>
        </div>

        <div className="glass-panel rounded-2xl p-8">
          <form onSubmit={handleSubmit} className="space-y-5">
            {error && (
              <div className="bg-danger/10 border border-danger/20 text-danger text-sm rounded-lg px-4 py-3">
                {error}
              </div>
            )}

            <div>
              <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider mb-2">
                Email
              </label>
              <input
                type="email"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                placeholder="you@yourcafe.com"
                required
                className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors"
              />
            </div>

            <div>
              <div className="flex justify-between items-center mb-2">
                <label className="block text-sm font-semibold text-vapor-muted uppercase tracking-wider">
                  Password
                </label>
                <Link href="/forgot-password" className="text-xs text-amethyst-400 hover:text-amethyst transition-colors">
                  Forgot password?
                </Link>
              </div>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                placeholder="••••••••"
                required
                className="w-full bg-card border border-white/10 text-vapor rounded-lg px-4 py-3 placeholder:text-white/20 focus:outline-none focus:border-amethyst transition-colors"
              />
            </div>

            <button
              type="submit"
              disabled={isLoading}
              className="w-full bg-amethyst hover:bg-amethyst-600 disabled:opacity-60 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl shadow-glow-amethyst transition-all"
            >
              {isLoading ? "Signing in..." : "Sign In"}
            </button>
          </form>

          <p className="text-center text-vapor-muted text-sm mt-6">
            Don&apos;t have an account?{" "}
            <Link href="/register" className="text-amethyst-400 hover:text-amethyst font-semibold transition-colors">
              Create one free
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}