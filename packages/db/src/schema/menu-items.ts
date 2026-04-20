import { pgTable, text, uuid, boolean, integer, numeric, timestamp, pgEnum } from "drizzle-orm/pg-core";

export const dietTypeEnum = pgEnum("diet_type", ["veg", "non_veg", "vegan"]);

export const menuItems = pgTable("menu_items", {
  id: uuid("id").primaryKey().defaultRandom(),
  cafeId: uuid("cafe_id").notNull(),
  categoryId: uuid("category_id"),
  name: text("name").notNull(),
  description: text("description"),
  price: numeric("price", { precision: 10, scale: 2 }).notNull(),
  imageUrl: text("image_url"),
  dietType: dietTypeEnum("diet_type").default("veg"),
  isAvailable: boolean("is_available").default(true),
  isBestSeller: boolean("is_best_seller").default(false),
  isChefsSpecial: boolean("is_chefs_special").default(false),
  isNewItem: boolean("is_new_item").default(false),
  sortOrder: integer("sort_order").default(0),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at").defaultNow().notNull(),
});

export type MenuItem = typeof menuItems.$inferSelect;
export type NewMenuItem = typeof menuItems.$inferInsert;