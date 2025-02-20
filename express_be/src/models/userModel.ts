import {supabase} from "../config/configuration";

class User {

  /**
   * This section can only be accessed by the Admin Only, all users can only create and edit their user information.
   * @param userData 
   * @returns 
   */
  static async create(userData: { first_name: string; last_name: string; email: string; password: string; image?: string }) {
    const { data, error } = await supabase
      .from("demo") // Dapat tama ang table name mo sa database
      .insert([userData]);

    if (error) throw new Error(error.message);
    return data;
  }
}

class Auth {
  /**
   * The following methods were meant for user authentication for both email and OTP.
   * @param email 
   * @returns 
   */

  static async authenticateLogin(email: string){
    const { data, error } = await supabase
    .from("user") // Dapat tama ang table name mo sa database
    .select("user_id, email, password").eq("email", email).single();

  if (error) throw new Error(error.message);
  return data;
  }

  static async createOTP(otp_input: {user_id: number, two_fa_code: string}){

    const addMinutes = (date: number, n: number) => {
      const d = new Date(date)
      d.setTime(d.getTime() + n * 60_000)
      return d
    }

    const otp = {
      ...otp_input,
      two_factor_code_expires_at: addMinutes(Date.now(), 20)
    }

    const {data, error} = await supabase.from("two_fa_code").insert([otp])

    if(error) throw new Error(error.message)

    return data
  }

  static async authenticateOTP(user_id: number){
    const {data, error} = await supabase.from("two_fa_code").select("two_fa_code, two_fa_code_expires_at").eq("user_id", user_id).single()

    if(error) throw new Error(error.message)

    return data
  }

  static async resetOTP(user_id: number){
    const {data, error} = await supabase.from("two_fa_code")
    .insert({      
      two_fa_code: null,
      two_fa_code_expires_at: null}
    ).eq("user_id", user_id)

    if(error) throw new Error(error.message)

    return data
  }
}

export { User, Auth };
