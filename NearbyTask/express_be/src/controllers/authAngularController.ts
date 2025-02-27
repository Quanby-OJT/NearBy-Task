import { Request, Response } from "express";
import bcrypt from "bcrypt";
import { supabase } from "../config/configuration";
import { randomUUID } from "crypto";

class auth {
  static async login(req: Request, res: Response): Promise<any> {
    try {
      const { email, password } = req.body;
      const userSession: any = {};

      //   return res.json({ message: email, password: password });
      const { data: user, error } = await supabase
        .from("user")
        .select("*")
        .eq("email", email)
        .in("user_role", ["admin", "moderator"])
        .single();
      if (!user || error) {
        return res.status(404).json({ message: "User not found" });
      }

      const isPasswordValid = await bcrypt.compare(
        password,
        user.hashed_password
      );

      if (!isPasswordValid) {
        return res.status(401).json({ message: "Password is incorrect" });
      }

      const { error: updateError } = await supabase
        .from("user")
        .update({ status: true })
        .eq("user_id", user.user_id);

      if (error) {
        return res.status(500).json({ message: "Error updating user status" });
      } else {
        const sessionID = randomUUID();
        userSession[sessionID] = { user: user.user_id };

        return res.status(200).json({
          message: "Logged in successfully",
          userSession: userSession,
        });
      }
      // Generate a session ID for the user
    } catch (err) {
      return res.status(500).json({ message: "Error" + err });
    }
  }

  static async logout(req: Request, res: Response): Promise<any> {
    try {
      const { userID } = req.body;

      const { error } = await supabase
        .from("user")
        .update({ status: false })
        .eq("user_id", userID);

      if (error) {
        return res.status(500).json({ message: "Error updating user status" });
      }
      return res.status(200).json({ message: "User updated successfully" });
    } catch (error) {
      return res.status(500).json({ message: "Error" + error });
    }
  }
}
export default auth;
