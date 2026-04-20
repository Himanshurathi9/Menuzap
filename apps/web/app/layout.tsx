import type { Metadata, Viewport } from "next";
import { Plus_Jakarta_Sans } from "next/font/google";
import "./globals.css";

// We use Plus Jakarta Sans for that crisp, high-end SaaS typography
const font = Plus_Jakarta_Sans({ 
  subsets: ["latin"],
  weight: ["400", "500", "600", "700", "800"],
  variable: "--font-plus-jakarta",
});

export const metadata: Metadata = {
  title: "MenuMate | The Operating System for Cafes",
  description: "One Link. Full Restaurant. Zero Hassle. The complete digital presence for your cafe.",
  keywords: ["cafe menu", "digital menu", "restaurant saas", "qr code menu"],
  authors: [{ name: "MenuMate" }],
  openGraph: {
    title: "MenuMate | The Operating System for Cafes",
    description: "One Link. Full Restaurant. Zero Hassle.",
    url: "https://menumate.app",
    siteName: "MenuMate",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "MenuMate | The Operating System for Cafes",
    description: "One Link. Full Restaurant. Zero Hassle.",
  },
};

export const viewport: Viewport = {
  themeColor: "#0A0A0E", // Our Obsidian Black
  width: "device-width",
  initialScale: 1,
  maximumScale: 1, // Prevents auto-zooming on mobile inputs
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    // Forcing the 'dark' class ensures our Tailwind dark mode colors engage instantly
    <html lang="en" className="dark scroll-smooth">
      <body className={`${font.className} antialiased min-h-screen flex flex-col bg-background text-foreground overflow-x-hidden`}>
        {/* We can add global providers here later (like Toast notifications or Auth) */}
        {children}
      </body>
    </html>
  );
}