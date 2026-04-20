import Sidebar from "@/components/dashboard/sidebar";
import { ReactNode } from "react";

export default function DashboardLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex h-screen overflow-hidden bg-background selection:bg-amethyst selection:text-white">
      {/* Sidebar Area 
        Hidden on mobile (we will build a mobile top-bar later), 
        visible on medium screens and up. 
      */}
      <div className="hidden md:flex flex-shrink-0 z-20 shadow-glass">
        <Sidebar />
      </div>

      {/* Main Content Wrapper */}
      <div className="flex flex-col flex-1 overflow-hidden w-full relative">
        {/* Background ambient glow effect 
          This sits behind the content to give it that premium feel 
        */}
        <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-amethyst/10 blur-[120px] rounded-full pointer-events-none z-0"></div>

        {/* Scrollable Content Area 
          The 'children' prop here is where your page.tsx gets injected
        */}
        <main className="flex-1 overflow-y-auto overflow-x-hidden relative z-10 scroll-smooth">
          {children}
        </main>
      </div>
    </div>
  );
}