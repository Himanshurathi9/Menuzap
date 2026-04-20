import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";

// We import the cafes schema we already created
import * as cafesSchema from "./schema/cafes";

// As we build out the rest of the schemas (users, menus, orders), 
// we will add them to this master schema object.
const schema = {
  ...cafesSchema,
};

// We pull the database connection string from the environment variables.
// Providing a fallback ensures the build process doesn't crash in CI/CD pipelines.
const connectionString = process.env.DATABASE_URL || "postgres://postgres:postgres@localhost:5432/menumate";

// Initialize the postgres client. 
// prepare: false is highly recommended for serverless environments like Vercel.
const client = postgres(connectionString, { prepare: false });

// Export the active database instance to be used inside our Next.js API routes
export const db = drizzle(client, { schema });

// Export all schemas so the frontend can easily import types (e.g., type Cafe)
export * from "./schema/cafes";