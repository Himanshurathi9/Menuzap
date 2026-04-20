#!/bin/bash

# ============================================================
#   MENUMATE — Full SaaS Structure Setup Script
#   Run: chmod +x setup_menumate.sh && ./setup_menumate.sh
# ============================================================

set -e  # Exit on any error

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

print_step() { echo -e "\n${BLUE}${BOLD}▶ $1${RESET}"; }
print_done() { echo -e "${GREEN}✔ $1${RESET}"; }
print_info() { echo -e "${CYAN}  $1${RESET}"; }
print_warn() { echo -e "${YELLOW}⚠ $1${RESET}"; }

echo -e "${BOLD}"
echo "  ╔══════════════════════════════════════════════╗"
echo "  ║        MENUMATE SaaS — Structure Setup       ║"
echo "  ║     Turborepo + Next.js 14 + Supabase        ║"
echo "  ╚══════════════════════════════════════════════╝"
echo -e "${RESET}"

# ─── PREREQUISITES CHECK ─────────────────────────────────────

print_step "Checking prerequisites..."

if ! command -v node &>/dev/null; then
  echo "Node.js not found. Install from https://nodejs.org (v20+ recommended)"
  exit 1
fi
print_done "Node.js $(node -v)"

if ! command -v pnpm &>/dev/null; then
  print_warn "pnpm not found. Installing..."
  npm install -g pnpm
fi
print_done "pnpm $(pnpm -v)"

if ! command -v git &>/dev/null; then
  echo "Git not found. Install from https://git-scm.com"
  exit 1
fi
print_done "git $(git --version)"

# ─── ROOT SETUP ──────────────────────────────────────────────

print_step "Creating root project folder..."

mkdir -p menumate
cd menumate

git init
print_done "Git initialized"

# ─── DIRECTORY TREE ──────────────────────────────────────────

print_step "Scaffolding full directory structure..."

# Apps
mkdir -p apps/web/app/\(marketing\)
mkdir -p apps/web/app/\(auth\)/login
mkdir -p apps/web/app/\(auth\)/register
mkdir -p apps/web/app/\(auth\)/forgot-password
mkdir -p apps/web/app/\(dashboard\)/menu/new
mkdir -p apps/web/app/\(dashboard\)/menu/\[categoryId\]
mkdir -p apps/web/app/\(dashboard\)/orders/history
mkdir -p apps/web/app/\(dashboard\)/orders/\[orderId\]
mkdir -p apps/web/app/\(dashboard\)/banners
mkdir -p apps/web/app/\(dashboard\)/tables
mkdir -p apps/web/app/\(dashboard\)/loyalty
mkdir -p apps/web/app/\(dashboard\)/analytics
mkdir -p apps/web/app/\(dashboard\)/broadcast
mkdir -p apps/web/app/\(dashboard\)/feedback
mkdir -p apps/web/app/\(dashboard\)/settings/profile
mkdir -p apps/web/app/\(dashboard\)/settings/notifications
mkdir -p apps/web/app/\(dashboard\)/settings/staff
mkdir -p apps/web/app/\(dashboard\)/settings/payments
mkdir -p apps/web/app/\(dashboard\)/settings/billing
mkdir -p apps/web/app/\(dashboard\)/onboarding
mkdir -p apps/web/app/\[cafeSlug\]/order/\[orderId\]
mkdir -p apps/web/app/\[cafeSlug\]/feedback

# API routes
mkdir -p apps/web/app/api/auth/\[...nextauth\]
mkdir -p apps/web/app/api/auth/register
mkdir -p apps/web/app/api/cafe/\[cafeId\]
mkdir -p apps/web/app/api/menu/\[itemId\]
mkdir -p apps/web/app/api/menu/categories
mkdir -p apps/web/app/api/orders/\[orderId\]/status
mkdir -p apps/web/app/api/orders/live
mkdir -p apps/web/app/api/banners
mkdir -p apps/web/app/api/tables
mkdir -p apps/web/app/api/loyalty/redeem
mkdir -p apps/web/app/api/analytics/revenue
mkdir -p apps/web/app/api/analytics/top-items
mkdir -p apps/web/app/api/notifications/whatsapp
mkdir -p apps/web/app/api/notifications/broadcast
mkdir -p apps/web/app/api/payments/create-order
mkdir -p apps/web/app/api/payments/webhook
mkdir -p apps/web/app/api/upload
mkdir -p apps/web/app/api/webhooks/stripe

# Web components
mkdir -p apps/web/components/dashboard
mkdir -p apps/web/components/menu
mkdir -p apps/web/components/forms
mkdir -p apps/web/components/shared
mkdir -p apps/web/components/providers
mkdir -p apps/web/hooks
mkdir -p apps/web/lib
mkdir -p apps/web/public/fonts
mkdir -p apps/web/public/icons
mkdir -p apps/web/public/images

# Landing app
mkdir -p apps/landing/app/pricing
mkdir -p apps/landing/app/features
mkdir -p apps/landing/app/blog/\[slug\]
mkdir -p apps/landing/components

# Docs app
mkdir -p apps/docs/pages

# Packages
mkdir -p packages/db/src/schema
mkdir -p packages/db/src/queries
mkdir -p packages/db/src/migrations
mkdir -p packages/ui/src/components
mkdir -p packages/ui/src/tokens
mkdir -p packages/auth/src
mkdir -p packages/whatsapp/src/templates
mkdir -p packages/whatsapp/src/providers
mkdir -p packages/config
mkdir -p packages/utils/src

# Tooling
mkdir -p tooling/eslint
mkdir -p tooling/prettier
mkdir -p tooling/typescript

# GitHub
mkdir -p .github/workflows

print_done "Directory tree created"

# ─── ROOT CONFIG FILES ────────────────────────────────────────

print_step "Writing root config files..."

# pnpm workspace
cat > pnpm-workspace.yaml << 'EOF'
packages:
  - "apps/*"
  - "packages/*"
  - "tooling/*"
EOF

# Root package.json
cat > package.json << 'EOF'
{
  "name": "menumate",
  "private": true,
  "scripts": {
    "build": "turbo build",
    "dev": "turbo dev",
    "lint": "turbo lint",
    "type-check": "turbo type-check",
    "test": "turbo test",
    "clean": "turbo clean",
    "format": "prettier --write \"**/*.{ts,tsx,md,json}\""
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
EOF

# turbo.json
cat > turbo.json << 'EOF'
{
  "$schema": "https://turbo.build/schema.json",
  "ui": "tui",
  "tasks": {
    "build": {
      "dependsOn": ["^build"],
      "inputs": ["$TURBO_DEFAULT$", ".env*"],
      "outputs": [".next/**", "!.next/cache/**", "dist/**"]
    },
    "dev": {
      "cache": false,
      "persistent": true
    },
    "lint": {
      "dependsOn": ["^lint"]
    },
    "type-check": {
      "dependsOn": ["^type-check"]
    },
    "test": {
      "dependsOn": ["^build"]
    },
    "clean": {
      "cache": false
    }
  }
}
EOF

# .gitignore
cat > .gitignore << 'EOF'
# Dependencies
node_modules
.pnp
.pnp.js

# Build outputs
.next
dist
build
out
.turbo

# Environment
.env
.env.local
.env.*.local

# OS
.DS_Store
Thumbs.db

# Logs
*.log
npm-debug.log*
yarn-debug.log*

# Vercel
.vercel

# Testing
coverage
.nyc_output

# IDE
.vscode
.idea
*.swp
*.swo
EOF

# .env.example
cat > .env.example << 'EOF'
# ── App ──────────────────────────────────────────
NEXT_PUBLIC_APP_URL=https://menumate.app
NEXT_PUBLIC_APP_NAME=MenuMate

# ── Supabase ─────────────────────────────────────
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
SUPABASE_SERVICE_ROLE_KEY=

# ── Auth (NextAuth v5) ───────────────────────────
NEXTAUTH_SECRET=
NEXTAUTH_URL=http://localhost:3000

# ── Cloudinary ───────────────────────────────────
CLOUDINARY_CLOUD_NAME=
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=

# ── WhatsApp (Twilio) ────────────────────────────
TWILIO_ACCOUNT_SID=
TWILIO_AUTH_TOKEN=
TWILIO_WHATSAPP_FROM=whatsapp:+14155238886

# ── Payments (Razorpay) ──────────────────────────
RAZORPAY_KEY_ID=
RAZORPAY_KEY_SECRET=
NEXT_PUBLIC_RAZORPAY_KEY_ID=

# ── Google Maps ──────────────────────────────────
NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=

# ── Stripe (subscriptions) ───────────────────────
STRIPE_SECRET_KEY=
STRIPE_WEBHOOK_SECRET=
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=

# ── Analytics ────────────────────────────────────
NEXT_PUBLIC_POSTHOG_KEY=
NEXT_PUBLIC_POSTHOG_HOST=https://app.posthog.com

# ── Error tracking ───────────────────────────────
NEXT_PUBLIC_SENTRY_DSN=
EOF

# README.md
cat > README.md << 'EOF'
# ☕ MenuMate — Digital Menu SaaS

> One QR code. Full restaurant. Zero hassle.

## Stack
- **Monorepo**: Turborepo + pnpm workspaces
- **Apps**: Next.js 14 (App Router), TypeScript
- **Database**: Supabase (Postgres + Realtime) + Drizzle ORM
- **Styling**: Tailwind CSS + shadcn/ui
- **Auth**: NextAuth.js v5
- **Notifications**: Twilio WhatsApp API
- **Payments**: Razorpay + Stripe
- **Deployment**: Vercel + Cloudflare

## Getting Started

```bash
# Install dependencies
pnpm install

# Copy environment variables
cp .env.example .env.local

# Start all apps in dev mode
pnpm dev
```

## Apps
| App | URL | Description |
|-----|-----|-------------|
| `apps/web` | app.menumate.app | Main product (dashboard + customer menu) |
| `apps/landing` | menumate.app | Marketing website |
| `apps/docs` | docs.menumate.app | Documentation |

## Packages
| Package | Description |
|---------|-------------|
| `packages/db` | Database schema, queries (Drizzle ORM) |
| `packages/ui` | Shared component library |
| `packages/auth` | Auth helpers |
| `packages/whatsapp` | WhatsApp notification service |
| `packages/utils` | Shared utilities & types |
EOF

print_done "Root config files written"

# ─── TOOLING ──────────────────────────────────────────────────

print_step "Writing tooling configs..."

# Base tsconfig
cat > tooling/typescript/base.json << 'EOF'
{
  "$schema": "https://json.schemastore.org/tsconfig",
  "compilerOptions": {
    "target": "ES2022",
    "lib": ["ES2022"],
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,
    "skipLibCheck": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true
  }
}
EOF

cat > tooling/typescript/nextjs.json << 'EOF'
{
  "$schema": "https://json.schemastore.org/tsconfig",
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
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Prettier
cat > tooling/prettier/index.mjs << 'EOF'
/** @type {import('prettier').Config} */
const config = {
  semi: true,
  singleQuote: false,
  tabWidth: 2,
  trailingComma: "all",
  printWidth: 100,
  plugins: ["prettier-plugin-tailwindcss"],
};

export default config;
EOF

cat > tooling/prettier/package.json << 'EOF'
{
  "name": "@menumate/prettier-config",
  "version": "0.0.1",
  "private": true,
  "main": "index.mjs",
  "dependencies": {
    "prettier-plugin-tailwindcss": "^0.6.1"
  }
}
EOF

# ESLint
cat > tooling/eslint/package.json << 'EOF'
{
  "name": "@menumate/eslint-config",
  "version": "0.0.1",
  "private": true,
  "main": "index.js",
  "dependencies": {
    "@typescript-eslint/eslint-plugin": "^7.0.0",
    "@typescript-eslint/parser": "^7.0.0",
    "eslint-config-next": "^14.2.3",
    "eslint-plugin-import": "^2.29.1"
  }
}
EOF

cat > tooling/eslint/index.js << 'EOF'
/** @type {import("eslint").Linter.Config} */
const config = {
  extends: [
    "next/core-web-vitals",
    "plugin:@typescript-eslint/recommended-type-checked",
  ],
  rules: {
    "@typescript-eslint/no-unused-vars": ["error", { argsIgnorePattern: "^_" }],
    "@typescript-eslint/consistent-type-imports": [
      "warn",
      { prefer: "type-imports", fixStyle: "inline-type-imports" },
    ],
  },
};

module.exports = config;
EOF

print_done "Tooling configs written"

# ─── PACKAGES ─────────────────────────────────────────────────

print_step "Writing packages..."

# ── packages/utils ──
cat > packages/utils/package.json << 'EOF'
{
  "name": "@menumate/utils",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts"
  },
  "dependencies": {
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.3.0",
    "date-fns": "^3.6.0",
    "zod": "^3.23.4"
  },
  "devDependencies": {
    "typescript": "^5.4.5"
  }
}
EOF

cat > packages/utils/src/index.ts << 'EOF'
export { cn } from "./cn";
export { formatCurrency } from "./currency";
export { formatDate, formatTime } from "./date";
export * from "./types";
EOF

cat > packages/utils/src/cn.ts << 'EOF'
import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}
EOF

cat > packages/utils/src/currency.ts << 'EOF'
export function formatCurrency(amount: number, currency = "INR"): string {
  return new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency,
    maximumFractionDigits: 0,
  }).format(amount);
}
EOF

cat > packages/utils/src/date.ts << 'EOF'
import { format } from "date-fns";

export function formatDate(date: Date | string): string {
  return format(new Date(date), "dd MMM yyyy");
}

export function formatTime(date: Date | string): string {
  return format(new Date(date), "hh:mm a");
}
EOF

cat > packages/utils/src/types.ts << 'EOF'
export type OrderStatus = "pending" | "preparing" | "served" | "completed" | "cancelled";
export type UserRole = "owner" | "manager" | "waiter" | "kitchen";
export type BusinessType = "cafe" | "restaurant" | "hotel" | "bar" | "bakery" | "cloud_kitchen";
export type PlanType = "starter" | "growth" | "pro" | "hotel";

export interface ApiResponse<T> {
  data: T | null;
  error: string | null;
  success: boolean;
}
EOF

# ── packages/db ──
cat > packages/db/package.json << 'EOF'
{
  "name": "@menumate/db",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts",
    "./schema": "./src/schema/index.ts"
  },
  "dependencies": {
    "@supabase/supabase-js": "^2.43.1",
    "drizzle-orm": "^0.30.10",
    "postgres": "^3.4.4",
    "zod": "^3.23.4"
  },
  "devDependencies": {
    "drizzle-kit": "^0.21.4",
    "typescript": "^5.4.5"
  },
  "scripts": {
    "db:generate": "drizzle-kit generate",
    "db:migrate": "drizzle-kit migrate",
    "db:push": "drizzle-kit push",
    "db:studio": "drizzle-kit studio"
  }
}
EOF

cat > packages/db/src/index.ts << 'EOF'
export { db } from "./client";
export * from "./schema";
export * from "./queries/cafes";
export * from "./queries/menu";
export * from "./queries/orders";
EOF

cat > packages/db/src/client.ts << 'EOF'
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

const connectionString = process.env.DATABASE_URL!;

const client = postgres(connectionString, { prepare: false });
export const db = drizzle(client, { schema });
EOF

cat > packages/db/src/schema/index.ts << 'EOF'
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
EOF

cat > packages/db/src/schema/cafes.ts << 'EOF'
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
EOF

cat > packages/db/src/schema/menu-items.ts << 'EOF'
import { pgTable, text, boolean, integer, timestamp } from "drizzle-orm/pg-core";

export const menuItems = pgTable("menu_items", {
  id: text("id").primaryKey().$defaultFn(() => crypto.randomUUID()),
  cafeId: text("cafe_id").notNull(),
  categoryId: text("category_id").notNull(),
  name: text("name").notNull(),
  description: text("description"),
  price: integer("price").notNull(), // in paise/cents
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
EOF

cat > packages/db/src/schema/orders.ts << 'EOF'
import { pgTable, text, integer, timestamp } from "drizzle-orm/pg-core";

export const orders = pgTable("orders", {
  id: text("id").primaryKey().$defaultFn(() => crypto.randomUUID()),
  cafeId: text("cafe_id").notNull(),
  tableId: text("table_id"),
  customerPhone: text("customer_phone"),
  customerName: text("customer_name"),
  status: text("status").default("pending"), // pending|preparing|served|completed|cancelled
  totalAmount: integer("total_amount").notNull(),
  paymentStatus: text("payment_status").default("unpaid"),
  paymentId: text("payment_id"),
  notes: text("notes"),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});
EOF

# Placeholder schemas
for schema_file in users menu-categories order-items banners tables loyalty feedback customers subscriptions; do
cat > packages/db/src/schema/${schema_file}.ts << EOF
// TODO: Define ${schema_file} schema
// See: MenuMate_FileStructure.txt for full column definitions
import { pgTable, text, timestamp } from "drizzle-orm/pg-core";

export const ${schema_file//-/_} = pgTable("${schema_file//-/_}", {
  id: text("id").primaryKey().\$defaultFn(() => crypto.randomUUID()),
  createdAt: timestamp("created_at").defaultNow(),
});
EOF
done

# Query stubs
for q in cafes menu orders analytics loyalty; do
cat > packages/db/src/queries/${q}.ts << EOF
// ${q} queries — implement using Drizzle ORM
import { db } from "../client";

export async function get${q^}() {
  // TODO: implement
}
EOF
done

# ── packages/whatsapp ──
cat > packages/whatsapp/package.json << 'EOF'
{
  "name": "@menumate/whatsapp",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts"
  },
  "dependencies": {
    "twilio": "^5.1.0"
  },
  "devDependencies": {
    "typescript": "^5.4.5"
  }
}
EOF

cat > packages/whatsapp/src/index.ts << 'EOF'
export { sendWhatsApp } from "./sender";
export * from "./templates/new-order";
export * from "./templates/order-status";
export * from "./templates/offer-broadcast";
EOF

cat > packages/whatsapp/src/sender.ts << 'EOF'
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
EOF

cat > packages/whatsapp/src/templates/new-order.ts << 'EOF'
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
  time?: string;
}

export function newOrderTemplate(params: NewOrderParams): string {
  const { tableName, items, totalAmount, notes, time } = params;
  const timeStr = time ?? new Date().toLocaleTimeString("en-IN", { hour: "2-digit", minute: "2-digit" });

  const itemsList = items
    .map((i) => `• ${i.name} x${i.quantity} — ₹${i.price * i.quantity}`)
    .join("\n");

  return `━━━━━━━━━━━━━━━━━━━━━━
🍽️ *NEW ORDER — MenuMate*
━━━━━━━━━━━━━━━━━━━━━━
📍 Table: *${tableName}*
🕐 Time: ${timeStr}

*ORDER DETAILS:*
${itemsList}

💰 Total: *₹${totalAmount}*${notes ? `\n📝 Note: "${notes}"` : ""}
━━━━━━━━━━━━━━━━━━━━━━`;
}
EOF

cat > packages/whatsapp/src/templates/order-status.ts << 'EOF'
export function orderStatusTemplate(tableName: string, status: string): string {
  const emoji: Record<string, string> = {
    preparing: "🍳",
    served: "🚀",
    completed: "✅",
    cancelled: "❌",
  };
  return `${emoji[status] ?? "📋"} Order for *${tableName}* is now *${status.toUpperCase()}*`;
}
EOF

cat > packages/whatsapp/src/templates/offer-broadcast.ts << 'EOF'
export function offerBroadcastTemplate(cafeName: string, offerText: string): string {
  return `☕ *${cafeName}*\n\n🎉 Today's Special Offer:\n${offerText}\n\nVisit us today! 🙌`;
}
EOF

# ── packages/ui ──
cat > packages/ui/package.json << 'EOF'
{
  "name": "@menumate/ui",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "exports": {
    ".": "./src/index.ts",
    "./styles": "./src/styles.css"
  },
  "dependencies": {
    "clsx": "^2.1.1",
    "tailwind-merge": "^2.3.0",
    "class-variance-authority": "^0.7.0",
    "lucide-react": "^0.379.0",
    "@radix-ui/react-dialog": "^1.0.5",
    "@radix-ui/react-dropdown-menu": "^2.0.6",
    "@radix-ui/react-tabs": "^1.0.4",
    "@radix-ui/react-toast": "^1.1.5",
    "@radix-ui/react-toggle": "^1.0.3",
    "@radix-ui/react-avatar": "^1.0.4"
  }
}
EOF

cat > packages/ui/src/index.ts << 'EOF'
// Core UI components — all built on Radix UI primitives
export { Button, type ButtonProps } from "./components/button";
export { Input } from "./components/input";
export { Card, CardContent, CardHeader, CardTitle } from "./components/card";
export { Badge } from "./components/badge";
export { Modal } from "./components/modal";
export { Spinner } from "./components/spinner";
export { Toggle } from "./components/toggle";
export { Avatar } from "./components/avatar";
EOF

# Create stub UI components
for comp in button input card badge modal spinner toggle avatar; do
cat > packages/ui/src/components/${comp}.tsx << EOF
// @menumate/ui — ${comp} component
// Build on top of Radix UI + CVA for variants
export function ${comp^}({ children, ...props }: React.HTMLAttributes<HTMLElement>) {
  return <div {...props}>{children}</div>;
}
EOF
done

cat > packages/ui/src/tokens/colors.ts << 'EOF'
export const colors = {
  brand: {
    primary: "#F97316",   // Orange — warm, food-friendly
    secondary: "#1C1917", // Near-black
    accent: "#FED7AA",    // Soft orange tint
  },
  status: {
    pending: "#F59E0B",
    preparing: "#3B82F6",
    served: "#10B981",
    cancelled: "#EF4444",
  },
} as const;
EOF

# ── packages/auth ──
cat > packages/auth/package.json << 'EOF'
{
  "name": "@menumate/auth",
  "version": "0.0.1",
  "private": true,
  "main": "./src/index.ts",
  "dependencies": {
    "next-auth": "^5.0.0-beta.19",
    "@auth/drizzle-adapter": "^1.1.0"
  }
}
EOF

cat > packages/auth/src/index.ts << 'EOF'
export { authOptions } from "./config";
export { getServerSession } from "./session";
export type { Session, User } from "./types";
EOF

cat > packages/auth/src/config.ts << 'EOF'
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
  pages: {
    signIn: "/login",
    error: "/login",
  },
  callbacks: {
    session: ({ session, token }) => ({
      ...session,
      user: { ...session.user, id: token.sub },
    }),
  },
};
EOF

cat > packages/auth/src/session.ts << 'EOF'
import { auth } from "./config";

export async function getServerSession() {
  return auth();
}
EOF

cat > packages/auth/src/types.ts << 'EOF'
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
EOF

print_done "Packages written"

# ─── APPS ─────────────────────────────────────────────────────

print_step "Writing app files..."

# ── apps/web package.json ──
cat > apps/web/package.json << 'EOF'
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
    "qr-code-styling": "^1.6.0-rc.1",
    "recharts": "^2.12.7",
    "cloudinary": "^2.2.0",
    "razorpay": "^2.9.2"
  },
  "devDependencies": {
    "@menumate/eslint-config": "workspace:*",
    "@menumate/prettier-config": "workspace:*",
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "autoprefixer": "^10.4.19",
    "postcss": "^8.4.38",
    "tailwindcss": "^3.4.3",
    "typescript": "^5.4.5"
  }
}
EOF

# next.config.js
cat > apps/web/next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  transpilePackages: ["@menumate/ui", "@menumate/utils", "@menumate/db"],
  images: {
    remotePatterns: [
      { protocol: "https", hostname: "res.cloudinary.com" },
      { protocol: "https", hostname: "images.unsplash.com" },
    ],
  },
  experimental: {
    serverComponentsExternalPackages: ["drizzle-orm", "postgres"],
  },
};

module.exports = nextConfig;
EOF

# tailwind.config.ts
cat > apps/web/tailwind.config.ts << 'EOF'
import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "../../packages/ui/src/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          DEFAULT: "#F97316",
          light: "#FED7AA",
          dark: "#C2410C",
        },
      },
      fontFamily: {
        sans: ["var(--font-inter)"],
        display: ["var(--font-cal-sans)"],
      },
    },
  },
  plugins: [],
};

export default config;
EOF

# tsconfig.json
cat > apps/web/tsconfig.json << 'EOF'
{
  "extends": "../../tooling/typescript/nextjs.json",
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

# Root layout
cat > apps/web/app/layout.tsx << 'EOF'
import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "MenuMate — Digital Menu for Cafes",
  description: "One QR code. Full restaurant. Zero hassle.",
  icons: { icon: "/icons/favicon.ico" },
  openGraph: {
    title: "MenuMate",
    description: "Digital menu platform for cafes & restaurants",
    images: ["/images/og-image.png"],
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
EOF

# globals.css
cat > apps/web/app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --brand: 249 115 22;       /* orange-500 */
    --brand-light: 254 215 170; /* orange-200 */
    --background: 255 255 255;
    --foreground: 28 25 23;    /* stone-900 */
  }

  * { box-sizing: border-box; }
  body {
    @apply bg-white text-stone-900 antialiased;
    font-feature-settings: "rlig" 1, "calt" 1;
  }
}
EOF

# Dashboard layout stub
cat > "apps/web/app/(dashboard)/layout.tsx" << 'EOF'
// Protected layout — wrap with auth check
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex h-screen overflow-hidden">
      {/* <Sidebar /> */}
      <main className="flex-1 overflow-auto">{children}</main>
    </div>
  );
}
EOF

# Dashboard home
cat > "apps/web/app/(dashboard)/page.tsx" << 'EOF'
export default function DashboardPage() {
  return (
    <div className="p-8">
      <h1 className="text-2xl font-bold">Welcome to MenuMate 👋</h1>
      <p className="text-stone-500 mt-1">Your cafe dashboard is ready.</p>
    </div>
  );
}
EOF

# Auth layout
cat > "apps/web/app/(auth)/layout.tsx" << 'EOF'
export default function AuthLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="min-h-screen grid place-items-center bg-stone-50">
      <div className="w-full max-w-md px-6">{children}</div>
    </div>
  );
}
EOF

# Login page
cat > "apps/web/app/(auth)/login/page.tsx" << 'EOF'
export default function LoginPage() {
  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-center">Welcome back ☕</h1>
      <p className="text-center text-stone-500">Sign in to your MenuMate account</p>
      {/* <LoginForm /> */}
    </div>
  );
}
EOF

# Register page
cat > "apps/web/app/(auth)/register/page.tsx" << 'EOF'
export default function RegisterPage() {
  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-center">Create your cafe ☕</h1>
      <p className="text-center text-stone-500">Get your digital menu live in minutes</p>
      {/* <RegisterForm /> */}
    </div>
  );
}
EOF

# Customer menu page
cat > "apps/web/app/[cafeSlug]/page.tsx" << 'EOF'
interface Props {
  params: { cafeSlug: string };
  searchParams: { table?: string };
}

export default function CafeMenuPage({ params, searchParams }: Props) {
  return (
    <main className="min-h-screen bg-white">
      {/* <BannerCarousel cafeSlug={params.cafeSlug} /> */}
      {/* <CategoryTabs /> */}
      {/* <MenuSection /> */}
      {/* <MapsSection /> */}
      <p className="p-8 text-center text-stone-400">
        Menu for: {params.cafeSlug} | Table: {searchParams.table ?? "—"}
      </p>
    </main>
  );
}
EOF

# Orders API route
cat > apps/web/app/api/orders/route.ts << 'EOF'
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  try {
    const body = await req.json();
    // TODO: 1. Validate with Zod
    // TODO: 2. Save order to DB
    // TODO: 3. Send WhatsApp notification
    // TODO: 4. Return order ID
    return NextResponse.json({ success: true, orderId: "temp-id" }, { status: 201 });
  } catch (error) {
    return NextResponse.json({ success: false, error: "Failed to place order" }, { status: 500 });
  }
}

export async function GET(req: NextRequest) {
  const cafeId = req.nextUrl.searchParams.get("cafeId");
  // TODO: Fetch orders for cafeId
  return NextResponse.json({ data: [], error: null });
}
EOF

# Upload API route
cat > apps/web/app/api/upload/route.ts << 'EOF'
import { NextRequest, NextResponse } from "next/server";
import { v2 as cloudinary } from "cloudinary";

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

export async function POST(req: NextRequest) {
  try {
    const formData = await req.formData();
    const file = formData.get("file") as File;
    const bytes = await file.arrayBuffer();
    const buffer = Buffer.from(bytes);
    const base64 = `data:${file.type};base64,${buffer.toString("base64")}`;

    const result = await cloudinary.uploader.upload(base64, {
      folder: "menumate/menu-items",
      transformation: [{ width: 800, height: 600, crop: "fill" }, { quality: "auto" }],
    });

    return NextResponse.json({ url: result.secure_url });
  } catch {
    return NextResponse.json({ error: "Upload failed" }, { status: 500 });
  }
}
EOF

# WhatsApp notification API
cat > apps/web/app/api/notifications/whatsapp/route.ts << 'EOF'
import { NextRequest, NextResponse } from "next/server";
import { sendWhatsApp, newOrderTemplate } from "@menumate/whatsapp";

export async function POST(req: NextRequest) {
  const { to, order } = await req.json();
  const message = newOrderTemplate(order);
  const sent = await sendWhatsApp(to, message);
  return NextResponse.json({ sent });
}
EOF

# Middleware
cat > apps/web/middleware.ts << 'EOF'
import { auth } from "@menumate/auth";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const PROTECTED_PATHS = ["/menu", "/orders", "/banners", "/tables", "/analytics", "/settings", "/loyalty", "/broadcast", "/feedback", "/onboarding"];

export function middleware(request: NextRequest) {
  const path = request.nextUrl.pathname;
  const isProtected = PROTECTED_PATHS.some((p) => path.startsWith(p));

  if (isProtected) {
    // TODO: Check session and redirect to /login if not authenticated
  }

  return NextResponse.next();
}

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};
EOF

# ── apps/landing ──
cat > apps/landing/package.json << 'EOF'
{
  "name": "@menumate/landing",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "next dev --port 3001",
    "build": "next build",
    "start": "next start",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "@menumate/ui": "workspace:*",
    "@menumate/utils": "workspace:*",
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
EOF

cat > apps/landing/app/layout.tsx << 'EOF'
export default function LandingLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
EOF

cat > apps/landing/app/page.tsx << 'EOF'
export default function LandingPage() {
  return (
    <main>
      <section className="min-h-screen flex flex-col items-center justify-center text-center px-4">
        <h1 className="text-6xl font-bold">☕ MenuMate</h1>
        <p className="mt-4 text-xl text-stone-500 max-w-xl">
          One QR code. Full restaurant. Zero hassle.
        </p>
        <a
          href="https://app.menumate.app/register"
          className="mt-8 px-8 py-4 bg-orange-500 text-white rounded-full font-semibold text-lg hover:bg-orange-600 transition"
        >
          Get Started Free →
        </a>
      </section>
    </main>
  );
}
EOF

cat > apps/landing/app/pricing/page.tsx << 'EOF'
export default function PricingPage() {
  return <div className="p-8"><h1 className="text-3xl font-bold">Pricing</h1></div>;
}
EOF

# ─── GITHUB ACTIONS ───────────────────────────────────────────

print_step "Writing GitHub Actions workflows..."

cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  pull_request:
    branches: [main, develop]

jobs:
  ci:
    name: Lint, Type-check & Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v3
        with:
          version: 9
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: "pnpm"
      - run: pnpm install --frozen-lockfile
      - run: pnpm lint
      - run: pnpm type-check
      - run: pnpm build
EOF

cat > .github/workflows/deploy-production.yml << 'EOF'
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    name: Deploy via Vercel
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v3
        with:
          version: 9
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: "pnpm"
      - run: pnpm install --frozen-lockfile
      - run: pnpm build
      # Vercel auto-deploys on push to main via Git integration
      # No manual deploy step needed when connected to Vercel
EOF

cat > .github/PULL_REQUEST_TEMPLATE.md << 'EOF'
## What does this PR do?

<!-- Brief description -->

## Type of change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist
- [ ] `pnpm lint` passes
- [ ] `pnpm type-check` passes
- [ ] `pnpm build` succeeds
- [ ] I tested this locally
EOF

print_done "GitHub Actions written"

# ─── VERCEL CONFIG ───────────────────────────────────────────

print_step "Writing Vercel config..."

cat > vercel.json << 'EOF'
{
  "framework": null,
  "installCommand": "pnpm install",
  "buildCommand": "pnpm build --filter=@menumate/web",
  "outputDirectory": "apps/web/.next"
}
EOF

print_done "Vercel config written"

# ─── DRIZZLE CONFIG ──────────────────────────────────────────

cat > packages/db/drizzle.config.ts << 'EOF'
import type { Config } from "drizzle-kit";

export default {
  schema: "./src/schema/index.ts",
  out: "./src/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: process.env.DATABASE_URL!,
  },
  verbose: true,
  strict: true,
} satisfies Config;
EOF

# ─── FINAL SUMMARY ───────────────────────────────────────────

echo ""
echo -e "${BOLD}${GREEN}╔════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║   ✅  MENUMATE structure created successfully!     ║${RESET}"
echo -e "${BOLD}${GREEN}╚════════════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${CYAN}📁 Structure summary:${RESET}"
echo -e "   ${YELLOW}apps/web${RESET}       → Main SaaS app (Next.js 14)"
echo -e "   ${YELLOW}apps/landing${RESET}   → Marketing website"
echo -e "   ${YELLOW}packages/db${RESET}    → Database schema (Drizzle ORM)"
echo -e "   ${YELLOW}packages/ui${RESET}    → Shared component library"
echo -e "   ${YELLOW}packages/whatsapp${RESET} → WhatsApp notifications"
echo -e "   ${YELLOW}packages/auth${RESET}  → Authentication helpers"
echo -e "   ${YELLOW}packages/utils${RESET} → Shared utilities & types"
echo ""
echo -e "${CYAN}🚀 Next steps:${RESET}"
echo ""
echo -e "  ${BOLD}1. Install dependencies${RESET}"
echo -e "     ${GREEN}cd menumate && pnpm install${RESET}"
echo ""
echo -e "  ${BOLD}2. Set up environment variables${RESET}"
echo -e "     ${GREEN}cp .env.example apps/web/.env.local${RESET}"
echo -e "     ${GREEN}# Fill in Supabase, Twilio, Cloudinary, Razorpay keys${RESET}"
echo ""
echo -e "  ${BOLD}3. Start development${RESET}"
echo -e "     ${GREEN}pnpm dev${RESET}"
echo -e "     ${GREEN}# web → localhost:3000${RESET}"
echo -e "     ${GREEN}# landing → localhost:3001${RESET}"
echo ""
echo -e "  ${BOLD}4. Deploy to Vercel${RESET}"
echo -e "     ${GREEN}pnpm install -g vercel${RESET}"
echo -e "     ${GREEN}vercel --cwd apps/web${RESET}"
echo ""
echo -e "  ${BOLD}5. Push database schema${RESET}"
echo -e "     ${GREEN}cd packages/db && pnpm db:push${RESET}"
echo ""
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}  Happy building! ☕  — MenuMate${RESET}"
echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo ""