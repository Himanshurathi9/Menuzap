# ============================================================
#   MENUMATE — Full SaaS Structure Setup (PowerShell)
#   Run: Set-ExecutionPolicy -Scope Process Bypass; .\setup_menumate.ps1
# ============================================================

$ErrorActionPreference = "Stop"

function Print-Step { param($msg) Write-Host "`n>> $msg" -ForegroundColor Cyan }
function Print-Done { param($msg) Write-Host "  OK  $msg" -ForegroundColor Green }

Write-Host ""
Write-Host "  ============================================" -ForegroundColor Yellow
Write-Host "    MENUMATE SaaS -- Full Structure Setup" -ForegroundColor Yellow
Write-Host "  ============================================" -ForegroundColor Yellow
Write-Host ""

# ─── CREATE ROOT FOLDER ──────────────────────────────────────

Print-Step "Creating folder structure..."

$folders = @(
  "menumate",
  "menumate\.github\workflows",
  "menumate\apps\web\app\(marketing)",
  "menumate\apps\web\app\(auth)\login",
  "menumate\apps\web\app\(auth)\register",
  "menumate\apps\web\app\(auth)\forgot-password",
  "menumate\apps\web\app\(dashboard)\menu\new",
  "menumate\apps\web\app\(dashboard)\menu\[categoryId]",
  "menumate\apps\web\app\(dashboard)\orders\history",
  "menumate\apps\web\app\(dashboard)\orders\[orderId]",
  "menumate\apps\web\app\(dashboard)\banners",
  "menumate\apps\web\app\(dashboard)\tables",
  "menumate\apps\web\app\(dashboard)\loyalty",
  "menumate\apps\web\app\(dashboard)\analytics",
  "menumate\apps\web\app\(dashboard)\broadcast",
  "menumate\apps\web\app\(dashboard)\feedback",
  "menumate\apps\web\app\(dashboard)\settings\profile",
  "menumate\apps\web\app\(dashboard)\settings\notifications",
  "menumate\apps\web\app\(dashboard)\settings\staff",
  "menumate\apps\web\app\(dashboard)\settings\payments",
  "menumate\apps\web\app\(dashboard)\settings\billing",
  "menumate\apps\web\app\(dashboard)\onboarding",
  "menumate\apps\web\app\[cafeSlug]\order\[orderId]",
  "menumate\apps\web\app\[cafeSlug]\feedback",
  "menumate\apps\web\app\api\auth\[...nextauth]",
  "menumate\apps\web\app\api\auth\register",
  "menumate\apps\web\app\api\cafe\[cafeId]",
  "menumate\apps\web\app\api\menu\[itemId]",
  "menumate\apps\web\app\api\menu\categories",
  "menumate\apps\web\app\api\orders\[orderId]\status",
  "menumate\apps\web\app\api\orders\live",
  "menumate\apps\web\app\api\banners",
  "menumate\apps\web\app\api\tables",
  "menumate\apps\web\app\api\loyalty\redeem",
  "menumate\apps\web\app\api\analytics\revenue",
  "menumate\apps\web\app\api\analytics\top-items",
  "menumate\apps\web\app\api\notifications\whatsapp",
  "menumate\apps\web\app\api\notifications\broadcast",
  "menumate\apps\web\app\api\payments\create-order",
  "menumate\apps\web\app\api\payments\webhook",
  "menumate\apps\web\app\api\upload",
  "menumate\apps\web\app\api\webhooks\stripe",
  "menumate\apps\web\components\dashboard",
  "menumate\apps\web\components\menu",
  "menumate\apps\web\components\forms",
  "menumate\apps\web\components\shared",
  "menumate\apps\web\components\providers",
  "menumate\apps\web\hooks",
  "menumate\apps\web\lib",
  "menumate\apps\web\public\fonts",
  "menumate\apps\web\public\icons",
  "menumate\apps\web\public\images",
  "menumate\apps\landing\app\pricing",
  "menumate\apps\landing\app\features",
  "menumate\apps\landing\app\blog\[slug]",
  "menumate\apps\landing\components",
  "menumate\apps\docs\pages",
  "menumate\packages\db\src\schema",
  "menumate\packages\db\src\queries",
  "menumate\packages\db\src\migrations",
  "menumate\packages\ui\src\components",
  "menumate\packages\ui\src\tokens",
  "menumate\packages\auth\src",
  "menumate\packages\whatsapp\src\templates",
  "menumate\packages\whatsapp\src\providers",
  "menumate\packages\config",
  "menumate\packages\utils\src",
  "menumate\tooling\eslint",
  "menumate\tooling\prettier",
  "menumate\tooling\typescript"
)

foreach ($folder in $folders) {
  New-Item -ItemType Directory -Path $folder -Force | Out-Null
}

Print-Done "All folders created"

# ─── HELPER FUNCTION ─────────────────────────────────────────

function Write-File {
  param($path, $content)
  $fullPath = "menumate\$path"
  $content | Set-Content -Path $fullPath -Encoding UTF8
}

# ─── ROOT FILES ──────────────────────────────────────────────

Print-Step "Writing root config files..."

Write-File "pnpm-workspace.yaml" @"
packages:
  - "apps/*"
  - "packages/*"
  - "tooling/*"
"@

Write-File "package.json" @"
{
  "name": "menumate",
  "private": true,
  "scripts": {
    "build": "turbo build",
    "dev": "turbo dev",
    "lint": "turbo lint",
    "type-check": "turbo type-check",
    "format": "prettier --write `"**/*.{ts,tsx,md,json}`""
  },
  "devDependencies": {
    "turbo": "^2.0.0",
    "prettier": "^3.2.5",
    "typescript": "^5.4.5"
  },
  "engines": {
    "node": ">=20",
    "pnpm": ">=9"
  },
  "packageManager": "pnpm@9.0.0"
}
"@

Write-File "turbo.json" @"
{
  "`$schema": "https://turbo.build/schema.json",
  "ui": "tui",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": { "dependsOn": ["^lint"] },
    "type-check": { "dependsOn": ["^type-check"] },
    "clean": { "cache": false }
  }
}
"@

Write-File ".gitignore" @"
node_modules
.next
dist
build
.turbo
.env
.env.local
.env.*.local
.DS_Store
*.log
.vercel
coverage
.vscode
"@

Write-File ".env.example" @"
# App
NEXT_PUBLIC_APP_URL=https://menumate.app
NEXT_PUBLIC_APP_NAME=MenuMate

# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# Auth
NEXTAUTH_SECRET=
NEXTAUTH_URL=http://localhost:3000

# Cloudinary
CLOUDINARY_CLOUD_NAME=
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=

# WhatsApp (Twilio)
TWILIO_ACCOUNT_SID=
TWILIO_AUTH_TOKEN=
TWILIO_WHATSAPP_FROM=whatsapp:+14155238886

# Razorpay
RAZORPAY_KEY_ID=
RAZORPAY_KEY_SECRET=
NEXT_PUBLIC_RAZORPAY_KEY_ID=

# Google Maps
NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=

# Stripe
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=
"@

Write-File "README.md" @"
# MenuMate - Digital Menu SaaS

> One QR code. Full restaurant. Zero hassle.

## Stack
- Monorepo: Turborepo + pnpm
- Framework: Next.js 14 App Router
- Database: Supabase + Drizzle ORM
- Styling: Tailwind CSS
- Auth: NextAuth.js v5
- Notifications: Twilio WhatsApp
- Payments: Razorpay + Stripe
- Deploy: Vercel + Cloudflare

## Start
npm install -g pnpm
pnpm install
pnpm dev
"@

Write-File "vercel.json" @"
{
  "buildCommand": "pnpm build --filter=@menumate/web",
  "outputDirectory": "apps/web/.next",
  "installCommand": "pnpm install"
}
"@

Print-Done "Root config files written"

# ─── TOOLING ─────────────────────────────────────────────────

Print-Step "Writing tooling files..."

Write-File "tooling\typescript\base.json" @"
{
  "`$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022"],
    "strict": true,
    "skipLibCheck": true,
    "declaration": true,
    "sourceMap": true
  }
}
"@

Write-File "tooling\typescript\nextjs.json" @"
{
  "`$schema": "https://json.schemastore.org/tsconfig",
  "extends": "./base.json",
  "compilerOptions": {
    "target": "ES2017",
    "lib": ["dom", "dom.iterable", "esnext"],
    "module": "esnext",
    "moduleResolution": "bundler",
    "jsx": "preserve",
    "allowJs": true,
    "incremental": true,
    "plugins": [{ "name": "next" }],
    "paths": { "@/*": ["./src/*"] }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
"@

Write-File "tooling\prettier\package.json" @"
{
  "name": "@menumate/prettier-config",
  "version": "0.0.1",
  "private": true,
  "main": "index.mjs"
}
"@

Write-File "tooling\prettier\index.mjs" @"
const config = {
  semi: true,
  singleQuote: false,
  tabWidth: 2,
  trailingComma: "all",
  printWidth: 100,
};
export default config;
"@

Write-File "tooling\eslint\package.json" @"
{
  "name": "@menumate/eslint-config",
  "version": "0.0.1",
  "private": true,
  "main": "index.js"
}
"@

Write-File "tooling\eslint\index.js" @"
const config = {
  extends: ["next/core-web-vitals"],
  rules: {
    "@typescript-eslint/no-unused-vars": ["error", { argsIgnorePattern: "^_" }]
  }
};
module.exports = config;
"@

Print-Done "Tooling files written"

# ─── PACKAGES ────────────────────────────────────────────────

Print-Step "Writing packages/utils..."

Write-File "packages\utils\package.json" @"
{
  "name": "@menumate/utils",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "dependencies": {
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.3.0",
    "date-fns": "^3.6.0",
    "zod": "^3.23.4"
  }
}
"@

Write-File "packages\utils\src\index.ts" @"
export { cn } from "./cn";
export { formatCurrency } from "./currency";
export { formatDate, formatTime } from "./date";
export * from "./types";
"@

Write-File "packages\utils\src\cn.ts" @"
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
"@

Write-File "packages\utils\src\currency.ts" @"
export function formatCurrency(amount: number, currency = "INR"): string {
  return new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency,
    maximumFractionDigits: 0,
  }).format(amount);
}
"@

Write-File "packages\utils\src\date.ts" @"
import { format } from "date-fns";

export function formatDate(date: Date | string): string {
  return format(new Date(date), "dd MMM yyyy");
}

export function formatTime(date: Date | string): string {
  return format(new Date(date), "hh:mm a");
}
"@

Write-File "packages\utils\src\types.ts" @"
export type OrderStatus = "pending" | "preparing" | "served" | "completed" | "cancelled";
export type UserRole = "owner" | "manager" | "waiter" | "kitchen";
export type BusinessType = "cafe" | "restaurant" | "hotel" | "bar" | "bakery" | "cloud_kitchen";
export type PlanType = "starter" | "growth" | "pro" | "hotel";

export interface ApiResponse<T> {
  data: T | null;
  error: string | null;
  success: boolean;
}
"@

Print-Step "Writing packages/db..."

Write-File "packages\db\package.json" @"
{
  "name": "@menumate/db",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "scripts": {
    "db:generate": "drizzle-kit generate",
    "db:migrate": "drizzle-kit migrate",
    "db:push": "drizzle-kit push",
    "db:studio": "drizzle-kit studio"
  },
  "dependencies": {
    "@supabase/supabase-js": "^2.43.1",
    "drizzle-orm": "^0.30.10",
    "postgres": "^3.4.4",
    "zod": "^3.23.4"
  },
  "devDependencies": {
    "drizzle-kit": "^0.21.4"
  }
}
"@

Write-File "packages\db\drizzle.config.ts" @"
import type { Config } from "drizzle-kit";

export default {
  schema: "./src/schema/index.ts",
  out: "./src/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
} satisfies Config;
"@

Write-File "packages\db\src\client.ts" @"
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

const client = postgres(process.env.DATABASE_URL!, { prepare: false });
export const db = drizzle(client, { schema });
"@

Write-File "packages\db\src\index.ts" @"
export { db } from "./client";
export * from "./schema";
"@

Write-File "packages\db\src\schema\index.ts" @"
export * from "./cafes";
export * from "./users";
export * from "./menu-categories";
export * from "./menu-items";
export * from "./orders";
export * from "./order-items";
export * from "./banners";
export * from "./tables";
export * from "./loyalty";
export * from "./feedback";
export * from "./customers";
export * from "./subscriptions";
"@

Write-File "packages\db\src\schema\cafes.ts" @"
import { pgTable, text, boolean, timestamp, jsonb } from "drizzle-orm/pg-core";

export const cafes = pgTable("cafes", {
  id: text("id").primaryKey().$defaultFn(() => crypto.randomUUID()),
  slug: text("slug").notNull().unique(),
  name: text("name").notNull(),
  logoUrl: text("logo_url"),
  coverUrl: text("cover_url"),
  address: text("address"),
  phone: text("phone"),
  googleMapsUrl: text("google_maps_url"),
  googlePlaceId: text("google_place_id"),
  instagramUrl: text("instagram_url"),
  openingHours: jsonb("opening_hours"),
  businessType: text("business_type").default("cafe"),
  ownerId: text("owner_id").notNull(),
  whatsappNumber: text("whatsapp_number"),
  secondaryWhatsapp: text("secondary_whatsapp"),
  isAcceptingOrders: boolean("is_accepting_orders").default(true),
  plan: text("plan").default("starter"),
  planExpiresAt: timestamp("plan_expires_at"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});
"@

Write-File "packages\db\src\schema\menu-items.ts" @"
import { pgTable, text, boolean, integer, timestamp } from "drizzle-orm/pg-core";

export const menuItems = pgTable("menu_items", {
  id: text("id").primaryKey().$defaultFn(() => crypto.randomUUID()),
  cafeId: text("cafe_id").notNull(),
  categoryId: text("category_id").notNull(),
  name: text("name").notNull(),
  description: text("description"),
  price: integer("price").notNull(),
  imageUrl: text("image_url"),
  isVeg: boolean("is_veg").default(true),
  isAvailable: boolean("is_available").default(true),
  isBestSeller: boolean("is_best_seller").default(false),
  isChefsSpecial: boolean("is_chefs_special").default(false),
  isNewItem: boolean("is_new_item").default(false),
  sortOrder: integer("sort_order").default(0),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});
"@

Write-File "packages\db\src\schema\orders.ts" @"
import { pgTable, text, integer, timestamp } from "drizzle-orm/pg-core";

export const orders = pgTable("orders", {
  id: text("id").primaryKey().$defaultFn(() => crypto.randomUUID()),
  cafeId: text("cafe_id").notNull(),
  tableId: text("table_id"),
  customerPhone: text("customer_phone"),
  customerName: text("customer_name"),
  status: text("status").default("pending"),
  totalAmount: integer("total_amount").notNull(),
  paymentStatus: text("payment_status").default("unpaid"),
  paymentId: text("payment_id"),
  notes: text("notes"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});
"@

# Stub schemas
$stubSchemas = @("users","menu-categories","order-items","banners","tables","loyalty","feedback","customers","subscriptions")
foreach ($s in $stubSchemas) {
  $varName = $s -replace "-","_"
  Write-File "packages\db\src\schema\$s.ts" @"
import { pgTable, text, timestamp } from "drizzle-orm/pg-core";

// TODO: Add full columns — see MenuMate_FileStructure.txt
export const $varName = pgTable("$varName", {
  id: text("id").primaryKey().`$defaultFn(() => crypto.randomUUID()),
  createdAt: timestamp("created_at").defaultNow(),
});
"@
}

# Query stubs
$queries = @("cafes","menu","orders","analytics","loyalty")
foreach ($q in $queries) {
  Write-File "packages\db\src\queries\$q.ts" @"
import { db } from "../client";
// TODO: Add $q queries using Drizzle ORM
"@
}

Print-Step "Writing packages/whatsapp..."

Write-File "packages\whatsapp\package.json" @"
{
  "name": "@menumate/whatsapp",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "dependencies": {
    "twilio": "^5.1.0"
  }
}
"@

Write-File "packages\whatsapp\src\index.ts" @"
export { sendWhatsApp } from "./sender";
export * from "./templates/new-order";
export * from "./templates/order-status";
export * from "./templates/offer-broadcast";
"@

Write-File "packages\whatsapp\src\sender.ts" @"
import twilio from "twilio";

const client = twilio(
  process.env.TWILIO_ACCOUNT_SID!,
  process.env.TWILIO_AUTH_TOKEN!
);

export async function sendWhatsApp(to: string, body: string): Promise<boolean> {
  try {
    await client.messages.create({
      from: process.env.TWILIO_WHATSAPP_FROM!,
      to: `whatsapp:${to}`,
      body,
    });
    return true;
  } catch (error) {
    console.error("[WhatsApp] Send failed:", error);
    return false;
  }
}
"@

Write-File "packages\whatsapp\src\templates\new-order.ts" @"
interface OrderItem {
  name: string;
  quantity: number;
  price: number;
}
interface NewOrderParams {
  tableName: string;
  items: OrderItem[];
  totalAmount: number;
  notes?: string;
}

export function newOrderTemplate(params: NewOrderParams): string {
  const { tableName, items, totalAmount, notes } = params;
  const time = new Date().toLocaleTimeString("en-IN", { hour: "2-digit", minute: "2-digit" });
  const itemsList = items.map((i) => `* ${i.name} x${i.quantity} -- Rs.${i.price * i.quantity}`).join("\n");

  return `NEW ORDER - MenuMate
Table: ${tableName}
Time: ${time}

ORDER:
${itemsList}

Total: Rs.${totalAmount}${notes ? `\nNote: ${notes}` : ""}`;
}
"@

Write-File "packages\whatsapp\src\templates\order-status.ts" @"
export function orderStatusTemplate(tableName: string, status: string): string {
  return `Order for Table ${tableName} is now: ${status.toUpperCase()}`;
}
"@

Write-File "packages\whatsapp\src\templates\offer-broadcast.ts" @"
export function offerBroadcastTemplate(cafeName: string, offerText: string): string {
  return `${cafeName}\n\nToday's Special Offer:\n${offerText}\n\nVisit us today!`;
}
"@

Print-Step "Writing packages/auth..."

Write-File "packages\auth\package.json" @"
{
  "name": "@menumate/auth",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "dependencies": {
    "next-auth": "^5.0.0-beta.19"
  }
}
"@

Write-File "packages\auth\src\index.ts" @"
export { authOptions } from "./config";
export { getServerSession } from "./session";
export type { Session, User } from "./types";
"@

Write-File "packages\auth\src\config.ts" @"
import type { NextAuthConfig } from "next-auth";
import Credentials from "next-auth/providers/credentials";

export const authOptions: NextAuthConfig = {
  providers: [
    Credentials({
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      authorize: async (credentials) => {
        // TODO: validate against DB
        return null;
      },
    }),
  ],
  pages: { signIn: "/login" },
};
"@

Write-File "packages\auth\src\session.ts" @"
// TODO: export getServerSession using next-auth
export async function getServerSession() {
  return null;
}
"@

Write-File "packages\auth\src\types.ts" @"
export interface User {
  id: string;
  email: string;
  name: string;
  cafeId: string;
  role: "owner" | "manager" | "waiter" | "kitchen";
}
export interface Session {
  user: User;
  expires: string;
}
"@

Print-Step "Writing packages/ui..."

Write-File "packages\ui\package.json" @"
{
  "name": "@menumate/ui",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "dependencies": {
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.3.0",
    "lucide-react": "^0.379.0"
  }
}
"@

Write-File "packages\ui\src\index.ts" @"
export { Button } from "./components/button";
export { Input } from "./components/input";
export { Card } from "./components/card";
export { Badge } from "./components/badge";
export { Spinner } from "./components/spinner";
"@

$uiComponents = @("button","input","card","badge","modal","spinner","toggle","avatar")
foreach ($c in $uiComponents) {
  $name = (Get-Culture).TextInfo.ToTitleCase($c)
  Write-File "packages\ui\src\components\$c.tsx" @"
// @menumate/ui -- $name component
export function $name({ children, ...props }: React.HTMLAttributes<HTMLDivElement>) {
  return <div {...props}>{children}</div>;
}
"@
}

Write-File "packages\ui\src\tokens\colors.ts" @"
export const colors = {
  brand: {
    primary: "#F97316",
    secondary: "#1C1917",
    accent: "#FED7AA",
  },
  status: {
    pending: "#F59E0B",
    preparing: "#3B82F6",
    served: "#10B981",
    cancelled: "#EF4444",
  },
} as const;
"@

Print-Done "All packages written"

# ─── APPS/WEB ────────────────────────────────────────────────

Print-Step "Writing apps/web..."

Write-File "apps\web\package.json" @"
{
  "name": "@menumate/web",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev --port 3000",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@menumate/auth": "workspace:*",
    "@menumate/db": "workspace:*",
    "@menumate/ui": "workspace:*",
    "@menumate/utils": "workspace:*",
    "@menumate/whatsapp": "workspace:*",
    "next": "^14.2.3",
    "react": "^18.3.1",
    "react-dom": "^18.3.1",
    "@supabase/supabase-js": "^2.43.1",
    "@tanstack/react-query": "^5.40.0",
    "zustand": "^4.5.2",
    "zod": "^3.23.4",
    "recharts": "^2.12.7",
    "cloudinary": "^2.2.0",
    "razorpay": "^2.9.2"
  },
  "devDependencies": {
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "autoprefixer": "^10.4.19",
    "postcss": "^8.4.38",
    "tailwindcss": "^3.4.3",
    "typescript": "^5.4.5"
  }
}
"@

Write-File "apps\web\next.config.js" @"
/** @type {import('next').NextConfig} */
const nextConfig = {
  transpilePackages: ["@menumate/ui", "@menumate/utils", "@menumate/db"],
  images: {
    remotePatterns: [
      { protocol: "https", hostname: "res.cloudinary.com" },
    ],
  },
};
module.exports = nextConfig;
"@

Write-File "apps\web\tsconfig.json" @"
{
  "extends": "../../tooling/typescript/nextjs.json",
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx"],
  "exclude": ["node_modules"]
}
"@

Write-File "apps\web\tailwind.config.ts" @"
import type { Config } from "tailwindcss";
const config: Config = {
  content: ["./app/**/*.{ts,tsx}", "./components/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        brand: { DEFAULT: "#F97316", light: "#FED7AA", dark: "#C2410C" },
      },
    },
  },
  plugins: [],
};
export default config;
"@

Write-File "apps\web\app\globals.css" @"
@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  --brand: 249 115 22;
  --background: 255 255 255;
  --foreground: 28 25 23;
}

body {
  background: white;
  color: #1c1917;
}
"@

Write-File "apps\web\app\layout.tsx" @"
import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "MenuMate -- Digital Menu for Cafes",
  description: "One QR code. Full restaurant. Zero hassle.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
"@

Write-File "apps\web\app\(auth)\layout.tsx" @"
export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ minHeight: "100vh", display: "grid", placeItems: "center", background: "#fafaf9" }}>
      <div style={{ width: "100%", maxWidth: 420, padding: "0 24px" }}>{children}</div>
    </div>
  );
}
"@

Write-File "apps\web\app\(auth)\login\page.tsx" @"
export default function LoginPage() {
  return (
    <div>
      <h1 style={{ fontSize: 28, fontWeight: 700, textAlign: "center" }}>Welcome back</h1>
      <p style={{ textAlign: "center", color: "#78716c", marginTop: 8 }}>Sign in to MenuMate</p>
      {/* TODO: Add LoginForm component */}
    </div>
  );
}
"@

Write-File "apps\web\app\(auth)\register\page.tsx" @"
export default function RegisterPage() {
  return (
    <div>
      <h1 style={{ fontSize: 28, fontWeight: 700, textAlign: "center" }}>Create your cafe</h1>
      <p style={{ textAlign: "center", color: "#78716c", marginTop: 8 }}>Get your menu live in minutes</p>
      {/* TODO: Add RegisterForm component */}
    </div>
  );
}
"@

Write-File "apps\web\app\(dashboard)\layout.tsx" @"
export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ display: "flex", height: "100vh", overflow: "hidden" }}>
      {/* TODO: <Sidebar /> */}
      <main style={{ flex: 1, overflowY: "auto", padding: 32 }}>{children}</main>
    </div>
  );
}
"@

Write-File "apps\web\app\(dashboard)\page.tsx" @"
export default function DashboardPage() {
  return (
    <div>
      <h1 style={{ fontSize: 24, fontWeight: 700 }}>Welcome to MenuMate</h1>
      <p style={{ color: "#78716c", marginTop: 4 }}>Your cafe dashboard is ready.</p>
      {/* TODO: Add StatsCards, LiveOrders, RevenueChart */}
    </div>
  );
}
"@

Write-File "apps\web\app\[cafeSlug]\page.tsx" @"
interface Props {
  params: { cafeSlug: string };
  searchParams: { table?: string };
}

export default function CafeMenuPage({ params, searchParams }: Props) {
  return (
    <main style={{ minHeight: "100vh", background: "white" }}>
      {/* TODO: <BannerCarousel /> */}
      {/* TODO: <CategoryTabs /> */}
      {/* TODO: <MenuGrid /> */}
      {/* TODO: <MapsSection /> */}
      <p style={{ padding: 32, textAlign: "center", color: "#a8a29e" }}>
        Menu: {params.cafeSlug} | Table: {searchParams.table ?? "walk-in"}
      </p>
    </main>
  );
}
"@

Write-File "apps\web\app\api\orders\route.ts" @"
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    // TODO: 1. Validate with Zod
    // TODO: 2. Save to DB via packages/db
    // TODO: 3. Call packages/whatsapp sendWhatsApp()
    // TODO: 4. Return order ID to customer
    return NextResponse.json({ success: true, orderId: "temp-id" }, { status: 201 });
  } catch {
    return NextResponse.json({ success: false, error: "Failed to place order" }, { status: 500 });
  }
}

export async function GET(req: NextRequest) {
  const cafeId = req.nextUrl.searchParams.get("cafeId");
  // TODO: Fetch all orders for cafeId from DB
  return NextResponse.json({ data: [], error: null });
}
"@

Write-File "apps\web\app\api\upload\route.ts" @"
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData();
    const file = formData.get("file") as File;
    // TODO: Upload to Cloudinary
    // const result = await cloudinary.uploader.upload(base64, { folder: "menumate" });
    // return NextResponse.json({ url: result.secure_url });
    return NextResponse.json({ url: "/placeholder.jpg" });
  } catch {
    return NextResponse.json({ error: "Upload failed" }, { status: 500 });
  }
}
"@

Write-File "apps\web\app\api\notifications\whatsapp\route.ts" @"
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  const { to, order } = await req.json();
  // TODO: import { sendWhatsApp, newOrderTemplate } from "@menumate/whatsapp"
  // const message = newOrderTemplate(order);
  // const sent = await sendWhatsApp(to, message);
  return NextResponse.json({ sent: true });
}
"@

Write-File "apps\web\middleware.ts" @"
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const PROTECTED = ["/menu", "/orders", "/banners", "/tables", "/analytics", "/settings"];

export function middleware(request: NextRequest) {
  const path = request.nextUrl.pathname;
  const isProtected = PROTECTED.some((p) => path.startsWith(p));
  if (isProtected) {
    // TODO: Check session cookie, redirect to /login if missing
  }
  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};
"@

# Component stubs
$dashComponents = @("sidebar","topbar","stats-card","order-card","menu-item-card","revenue-chart","quick-actions")
foreach ($c in $dashComponents) {
  $name = ($c -split "-" | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) }) -join ""
  Write-File "apps\web\components\dashboard\$c.tsx" @"
// TODO: Build $name component
export function $name() {
  return <div>$name</div>;
}
"@
}

$menuComponents = @("banner-carousel","category-tabs","dish-card","cart-drawer","order-form","order-status","search-bar","maps-section")
foreach ($c in $menuComponents) {
  $name = ($c -split "-" | ForEach-Object { (Get-Culture).TextInfo.ToTitleCase($_) }) -join ""
  Write-File "apps\web\components\menu\$c.tsx" @"
// TODO: Build $name component
export function $name() {
  return <div>$name</div>;
}
"@
}

# Hook stubs
$hooks = @("use-cafe","use-menu","use-orders","use-analytics","use-upload","use-qr","use-loyalty")
foreach ($h in $hooks) {
  Write-File "apps\web\hooks\$h.ts" @"
// TODO: implement $h hook
export function $h() {}
"@
}

# Lib stubs
$libs = @("auth","db","db-client","cloudinary","whatsapp","razorpay","qr","analytics","validations","utils")
foreach ($l in $libs) {
  Write-File "apps\web\lib\$l.ts" @"
// TODO: implement $l helpers
"@
}

Print-Done "apps/web written"

# ─── APPS/LANDING ────────────────────────────────────────────

Print-Step "Writing apps/landing..."

Write-File "apps\landing\package.json" @"
{
  "name": "@menumate/landing",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev --port 3001",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "^14.2.3",
    "react": "^18.3.1",
    "react-dom": "^18.3.1"
  },
  "devDependencies": {
    "typescript": "^5.4.5",
    "tailwindcss": "^3.4.3",
    "autoprefixer": "^10.4.19",
    "postcss": "^8.4.38"
  }
}
"@

Write-File "apps\landing\app\layout.tsx" @"
export default function Layout({ children }: { children: React.ReactNode }) {
  return <html lang="en"><body>{children}</body></html>;
}
"@

Write-File "apps\landing\app\page.tsx" @"
export default function LandingPage() {
  return (
    <main style={{ minHeight: "100vh", display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center", textAlign: "center", padding: "0 24px" }}>
      <h1 style={{ fontSize: 64, fontWeight: 800 }}>MenuMate</h1>
      <p style={{ fontSize: 20, color: "#78716c", marginTop: 16, maxWidth: 480 }}>
        One QR code. Full restaurant. Zero hassle.
      </p>
      <a href="http://localhost:3000/register" style={{ marginTop: 32, padding: "16px 40px", background: "#f97316", color: "white", borderRadius: 999, fontWeight: 600, fontSize: 18, textDecoration: "none" }}>
        Get Started Free
      </a>
    </main>
  );
}
"@

Write-File "apps\landing\app\pricing\page.tsx" @"
export default function PricingPage() {
  return <div style={{ padding: 32 }}><h1>Pricing</h1>{/* TODO: Add pricing cards */}</div>;
}
"@

Print-Done "apps/landing written"

# ─── GITHUB ACTIONS ──────────────────────────────────────────

Print-Step "Writing GitHub Actions..."

Write-File ".github\workflows\ci.yml" @"
name: CI
on:
  pull_request:
    branches: [main, develop]
jobs:
  ci:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v3
        with:
          version: 9
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: pnpm
      - run: pnpm install --frozen-lockfile
      - run: pnpm lint
      - run: pnpm type-check
      - run: pnpm build
"@

Write-File ".github\workflows\deploy-production.yml" @"
name: Deploy to Production
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v3
        with:
          version: 9
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: pnpm
      - run: pnpm install --frozen-lockfile
      - run: pnpm build
      # Vercel auto-deploys via Git integration -- no manual step needed
"@

Write-File ".github\PULL_REQUEST_TEMPLATE.md" @"
## What does this PR do?

## Type of change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change

## Checklist
- [ ] pnpm lint passes
- [ ] pnpm type-check passes
- [ ] Tested locally
"@

Print-Done "GitHub Actions written"

# ─── DONE ────────────────────────────────────────────────────

Write-Host ""
Write-Host "  ============================================" -ForegroundColor Green
Write-Host "    MENUMATE structure created successfully!" -ForegroundColor Green
Write-Host "  ============================================" -ForegroundColor Green
Write-Host ""
Write-Host "  NEXT STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  1. Install pnpm" -ForegroundColor Cyan
Write-Host "     npm install -g pnpm" -ForegroundColor White
Write-Host ""
Write-Host "  2. Install all dependencies" -ForegroundColor Cyan
Write-Host "     cd menumate" -ForegroundColor White
Write-Host "     pnpm install" -ForegroundColor White
Write-Host ""
Write-Host "  3. Set up environment variables" -ForegroundColor Cyan
Write-Host "     Copy .env.example to apps\web\.env.local" -ForegroundColor White
Write-Host "     Fill in your Supabase, Twilio, Cloudinary keys" -ForegroundColor White
Write-Host ""
Write-Host "  4. Start development" -ForegroundColor Cyan
Write-Host "     pnpm dev" -ForegroundColor White
Write-Host "     -- web    -> http://localhost:3000" -ForegroundColor White
Write-Host "     -- landing -> http://localhost:3001" -ForegroundColor White
Write-Host ""
Write-Host "  5. Deploy to Vercel" -ForegroundColor Cyan
Write-Host "     npm install -g vercel" -ForegroundColor White
Write-Host "     vercel" -ForegroundColor White
Write-Host ""
Write-Host "  Happy building! -- MenuMate" -ForegroundColor Yellow
Write-Host ""