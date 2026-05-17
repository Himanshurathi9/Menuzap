import { defineConfig } from "drizzle-kit";
import * as dotenv from "dotenv";
import { resolve } from "path";

// Load the root .env file regardless of where the script is run from
dotenv.config({ path: resolve(__dirname, "../../.env") });

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is missing in the .env file");
}

export default defineConfig({
    // Tell it exactly where to look from the root folder
    schema: "./packages/db/src/schema/*.ts",
    out: "./packages/db/migrations",
    dialect: "postgresql",
    dbCredentials: {
      url: process.env.DATABASE_URL,
    },
  });