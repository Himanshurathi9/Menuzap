import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";

import * as cafesSchema from "./schema/cafes";
import * as usersSchema from "./schema/users";
import * as menuItemsSchema from "./schema/menu-items";
import * as ordersSchema from "./schema/orders";
import * as tablesSchema from "./schema/tables";

const schema = {
  ...cafesSchema,
  ...usersSchema,
  ...menuItemsSchema,
  ...ordersSchema,
  ...tablesSchema,
};

const connectionString =
  process.env.DATABASE_URL || "postgres://postgres:postgres@localhost:5432/menumate";

const client = postgres(connectionString, { prepare: false });

export const db = drizzle(client, { schema });

// Re-export all types for use across the monorepo
export * from "./schema/cafes";
export * from "./schema/users";
export * from "./schema/menu-items";
export * from "./schema/orders";
export * from "./schema/tables";