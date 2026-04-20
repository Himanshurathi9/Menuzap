import Link from "next/link";

export default function NotFound() {
  return (
    <div className="min-h-screen bg-background flex flex-col items-center justify-center text-center px-6 relative">
      <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[60%] h-[300px] bg-amethyst/10 blur-[120px] rounded-full pointer-events-none" />

      <div className="relative z-10 animate-fade-in">
        <p className="text-8xl font-black text-amethyst text-glow mb-4">404</p>
        <h1 className="text-3xl font-extrabold text-vapor mb-3">Page not found</h1>
        <p className="text-vapor-muted max-w-sm mx-auto mb-8">
          The page you&apos;re looking for doesn&apos;t exist, or may have moved.
        </p>
        <div className="flex gap-4 justify-center flex-wrap">
          <Link
            href="/"
            className="bg-amethyst hover:bg-amethyst-600 text-white font-bold px-6 py-3 rounded-xl shadow-glow-amethyst transition-all"
          >
            Go to Dashboard
          </Link>
          <Link
            href="/login"
            className="bg-white/5 hover:bg-white/10 text-vapor border border-white/10 font-semibold px-6 py-3 rounded-xl transition-all"
          >
            Sign In
          </Link>
        </div>
      </div>
    </div>
  );
}