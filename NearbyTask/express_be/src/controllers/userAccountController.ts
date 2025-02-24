// controllers/userController.ts
import { Request, Response } from "express";
import { UserAccount } from "../models/userAccountModel";
import bcrypt from "bcrypt";
import { supabase } from "../config/configuration";
class UserAccountController {
  static async registerUser(req: Request, res: Response): Promise<void> {
    try {
      const {
        first_name,
        middle_name,
        last_name,
        birthdate,
        email,
        reported,
        acc_status,
      } = req.body;
      const imageFile = req.file;

      // Hash password
      const hashedPassword = await bcrypt.hash(birthdate, 10);

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
        birthdate,
        email,
        image_link: imageUrl,
        hashed_password: hashedPassword,
        reported,
        acc_status,
      });

      res
        .status(201)
        .json({ message: "User registered successfully!", user: newUser });
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
