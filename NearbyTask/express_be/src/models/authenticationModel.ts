import session from "express-session";
import { supabase } from "../config/configuration";

// class User {

//   /**
//    * This section can only be accessed by the Admin Only, all users can only create and edit their user information.
//    * @param userData
//    * @returns
//    */
//   static async create(userData: { first_name: string; last_name: string; email: string; password: string; image?: string }) {
//     const { data, error } = await supabase
//       .from("demo") // Dapat tama ang table name mo sa database
//       .insert([userData]);

//     if (error) throw new Error(error.message);
//     return data;
//   }
// }

class Auth {
  /**
   * The following methods were meant for user authentication for both email and OTP.
   * @param email
   * @returns
   */

  static async authenticateLogin(email: string) {
    const { data, error } = await supabase
      .from("user")
      .select("user_id, email, hashed_password")
      .eq("email", email)
      .single();

    if (error) {
      if (error.code === "PGRST116") {
        // No rows found
        return null;
      }
      throw new Error(error.message);
    }

    return data;
  }

  static async createOTP(otp_input: { user_id: number; two_fa_code: string }) {
    const addMinutes = (date: number, n: number) => {
      const d = new Date(date);
      d.setTime(d.getTime() + n * 60_000);
      return d;
    };

    const otp = {
      ...otp_input,
      two_fa_code_expires_at: addMinutes(Date.now(), 20),
    };

    const { data: existingUser, error: existingError } = await supabase
      .from("two_fa_code")
      .select("two_fa_code, two_fa_code_expires_at")
      .eq("user_id", otp_input.user_id)
      .single();

    if (existingError && existingError.code !== "PGRST116") {
      throw new Error(existingError.message);
    }

    if (existingUser) {
      const { data, error } = await supabase
        .from("two_fa_code")
        .update({
          two_fa_code: otp.two_fa_code,
          two_fa_code_expires_at: otp.two_fa_code_expires_at,
        })
        .eq("user_id", otp.user_id);

      if (error) throw new Error(error.message);
      return data;
    } else {
      const { data, error } = await supabase.from("two_fa_code").insert([otp]);

      if (error) throw new Error(error.message);
      return data;
    }
  }

  static async authenticateOTP(user_id: number) {
    //console.log(`Querying for user_id: ${user_id} (${typeof user_id})`);

    const { data, error } = await supabase
      .from("two_fa_code")
      .select("two_fa_code, two_fa_code_expires_at")
      .eq("user_id", user_id)
      .maybeSingle(); // Allows 0 or 1 row without error

    //console.log(data, error);

    if (error) {
      throw new Error(error.message);
    }

    if (!data) {
      return null; // No OTP found for this user
    }

    return data;
  }

  static async resetOTP(user_id: number) {
    console.log("Resetting OTP for user_id: ", user_id, "...");
    const { data, error } = await supabase
      .from("two_fa_code")
      .update({
        two_fa_code: null,
        two_fa_code_expires_at: null,
      })
      .eq("user_id", user_id);

    if (error) throw new Error(error.message);
    return data;
  }

  static async getUserRole(user_id: number) {
    const { data, error } = await supabase
      .from("user")
      .select("user_role")
      .eq("user_id", user_id)
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  static async login(user_session: { user_id: number; session_key: string }) {
    const d = new Date();

    const { data, error } = await supabase.from("user_logs").insert({
      user_id: user_session.user_id,
      logged_in: d.getTime(),
      session: user_session.session_key,
    });

    if (error) throw new Error(error.message);
    return data;
  }

  static async logout(user_id: number) {
    const d = new Date();

    const { data, error } = await supabase
      .from("user_logs")
      .update({
        logged_out: d.setTime(Date.now()),
      })
      .eq("user_id", user_id);

    if (error) throw new Error(error.message);
    return data;
  }
}

export { Auth };
