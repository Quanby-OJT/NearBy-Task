import { supabase } from "./../config/configuration";
// controllers/userController.ts
import { Request, Response } from "express";
import { UserAccount } from "../models/userAccountModel";
import bcrypt from "bcrypt";
class UserAccountController {
  static async registerUser(req: Request, res: Response): Promise<any> {
    try {
      const {
        first_name,
        middle_name,
        last_name,
        birthday,
        email,
        acc_status,
        user_role,
      } = req.body;
      const imageFile = req.file;

      // check if the email exists
      const { data: existingUser, error: findError } = await supabase
        .from("user")
        .select("email")
        .eq("email", email)
        .maybeSingle();

      if (existingUser) {
        return res.status(400).json({ error: "Email already exists" });
      }

      if (findError && findError.message !== "No rows found") {
        throw new Error(findError.message);
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(last_name, 10);

      let imageUrl = "";
      if (imageFile) {
        // Upload image to Supabase Storage (crud_bucket)
        const { data, error } = await supabase.storage
          .from("crud_bucket")
          .upload(
            `users/${Date.now()}_${imageFile.originalname}`,
            imageFile.buffer,
            {
              cacheControl: "3600",
              upsert: false,
            }
          );

        if (error) throw new Error(error.message);

        const { data: publicUrlData } = supabase.storage
          .from("crud_bucket")
          .getPublicUrl(data.path);

        imageUrl = publicUrlData.publicUrl;
      }

      // Insert user into Supabase database
      const newUser = await UserAccount.create({
        first_name,
        middle_name,
        last_name,
        birthdate: birthday,
        email,
        image_link: imageUrl,
        hashed_password: hashedPassword,
        acc_status,
        user_role,
      });

      res.status(201).json({
        message: "User registered successfully!",
        user: newUser,
      });
    } catch (error) {
      res.status(500).json({
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }

  static async deleteUser(req: Request, res: Response): Promise<void> {
    try {
      const userID = req.params.id;

      const { data, error } = await supabase
        .from("user")
        .delete()
        .eq("user_id", userID);

      if (error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(200).json({ users: data });
      }
    } catch (error) {
      res.status(500).json({
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }
  static async getAllUsers(req: Request, res: Response): Promise<void> {
    try {
      const { data, error } = await supabase.from("user").select();

      if (error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(200).json({ users: data });
      }
    } catch (error) {
      res.status(500).json({
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }
}

export default UserAccountController;
