import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "../../packages/ui/src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Core System Mappings (This fixes the error!)
        background: "var(--background)",
        foreground: "var(--foreground)",
        border: "var(--border)",
        input: "var(--input)",
        ring: "var(--ring)",
        card: {
          DEFAULT: "var(--card)",
          foreground: "var(--card-foreground)",
        },
        popover: {
          DEFAULT: "var(--popover)",
          foreground: "var(--popover-foreground)",
        },
        
        // Custom Palette: Modern Royal
        obsidian: {
          DEFAULT: "#0A0A0E",
          light: "#121218",
          dark: "#050508",
        },
        vapor: {
          DEFAULT: "#F4F4F5",
          muted: "#A1A1AA",
        },
        amethyst: {
          400: "#C084FC",
          DEFAULT: "#9333EA", 
          600: "#7E22CE",
          glow: "rgba(147, 51, 234, 0.4)", 
        },
        
        // Status Colors
        success: "#10B981", 
        danger: "#EF4444",  
        warning: "#F59E0B", 
      },
      backgroundImage: {
        'glass-gradient': 'linear-gradient(135deg, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.01) 100%)',
        'royal-gradient': 'linear-gradient(to right bottom, #0A0A0E, #121218, #1A1A24)',
      },
      boxShadow: {
        'glass': '0 8px 32px 0 rgba(0, 0, 0, 0.37)',
        'glow-amethyst': '0 0 20px 0 rgba(147, 51, 234, 0.3)',
      },
      animation: {
        'fade-in': 'fadeIn 0.5s ease-out forwards',
        'slide-up': 'slideUp 0.4s cubic-bezier(0.16, 1, 0.3, 1) forwards',
        'pulse-slow': 'pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite',
      },
      keyframes: {
        fadeIn: {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        slideUp: {
          '0%': { opacity: '0', transform: 'translateY(20px)' },
          '100%': { opacity: '1', transform: 'translateY(0)' },
        },
      },
    },
  },
  plugins: [],
};

export default config;