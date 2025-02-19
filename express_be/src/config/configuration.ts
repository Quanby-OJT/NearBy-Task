import dotenv from "dotenv";

// Load environment variables
dotenv.config();

export const config = {
  PORT: process.env.PORT,
  SUPABASE_URL: process.env.SUPABASE_URL,
  SUPABASE_KEY: process.env.SUPABASE_KEY,
};
