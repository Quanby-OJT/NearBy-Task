import { createClient } from "@supabase/supabase-js";
import { config } from "../config/configuration"; 

const supabase = createClient(config.SUPABASE_URL as string, config.SUPABASE_KEY as string);

class User {
  static async create(userData: { first_name: string; last_name: string; email: string; password: string; image?: string }) {
    const { data, error } = await supabase
      .from("demo") // Dapat tama ang table name mo sa database
      .insert([userData]);

    if (error) throw new Error(error.message);
    return data;
  }
}

export { User };
