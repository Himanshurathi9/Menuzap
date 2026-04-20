import { pgTable, text, uuid, boolean, jsonb, timestamp, pgEnum } from "drizzle-orm/pg-core";

export const businessTypeEnum = pgEnum("business_type", [
  "cafe",
  "restaurant",
  "hotel",
  "bar",
  "bakery",
  "cloud_kitchen",
]);

export const planEnum = pgEnum("plan", ["starter", "growth", "pro", "hotel"]);

export const cafes = pgTable("cafes", {
  id: uuid("id").primaryKey().defaultRandom(),
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
  businessType: businessTypeEnum("business_type").default("cafe"),
  ownerId: uuid("owner_id").notNull(),
  whatsappNumber: text("whatsapp_number"),
  secondaryWhatsapp: text("secondary_whatsapp"),
  isAcceptingOrders: boolean("is_accepting_orders").default(true),
  plan: planEnum("plan").default("starter"),
  planExpiresAt: timestamp("plan_expires_at"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export type Cafe = typeof cafes.$inferSelect;
export type NewCafe = typeof cafes.$inferInsert;