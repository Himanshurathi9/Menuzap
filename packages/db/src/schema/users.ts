import { pgTable, text, uuid, timestamp, pgEnum } from "drizzle-orm/pg-core";

export const userRoleEnum = pgEnum("user_role", [
  "owner",
  "manager",
  "waiter",
  "kitchen",
]);

export const users = pgTable("users", {
  id: uuid("id").primaryKey().defaultRandom(),
  cafeId: uuid("cafe_id"),
  email: text("email").notNull().unique(),
  name: text("name").notNull(),
  role: userRoleEnum("role").default("owner"),
  phone: text("phone"),
  avatarUrl: text("avatar_url"),
  passwordHash: text("password_hash"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
});

export type User = typeof users.$inferSelect;
export type NewUser = typeof users.$inferInsert;