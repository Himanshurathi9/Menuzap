import { pgTable, text, uuid, integer, boolean, timestamp } from "drizzle-orm/pg-core";

export const cafeTables = pgTable("cafe_tables", {
  id: uuid("id").primaryKey().defaultRandom(),
  cafeId: uuid("cafe_id").notNull(),
  name: text("name").notNull(),
  tableNumber: integer("table_number").notNull(),
  qrCodeUrl: text("qr_code_url"),
  isActive: boolean("is_active").default(true),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type CafeTable = typeof cafeTables.$inferSelect;
export type NewCafeTable = typeof cafeTables.$inferInsert;