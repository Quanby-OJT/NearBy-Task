import { supabase, mailer, port, url } from "./../config/configuration";
// controllers/userController.ts
import { Request, Response } from "express";
import { UserAccount } from "../models/userAccountModel";
import bcrypt from "bcrypt";
import crypto from "crypto";

class UserAccountController {
  static async createNewUser(req: Request, res: Response): Promise<any> {
    try {
      const { first_name, middle_name, last_name, email, role, password } =
        req.body;

      const hashpuppi = await bcrypt.hash(password, 10);
      const verificationToken = crypto.randomBytes(32).toString("hex");
      console.log(verificationToken);

      const newUser = await UserAccount.create({
        first_name,
        middle_name,
        last_name,
        email,
        user_role: role,
        hashed_password: hashpuppi,
        acc_status: "pending",
        verification_token: verificationToken,
      });

      const verificationLink =
        url + ":" + port + "/connect/verify?token=" + verificationToken;

      await mailer.sendMail({
        to: email,
        from: "noreply@nearbytask.com",
        subject: "Welcome to NearByTask",
        html: `<h1>Welcome to NearByTask</h1>
        <p>Hi ${first_name},</p>
        <p>Thank you for signing up with NearByTask. In Order to Verify your account, please click the following link: </p>
        <a href="${verificationLink}">Verify Account</a>.</p>
        <p>Right After to clicked the link, you will be redirected to setting up your profile.</p>
        <p>Best regards,</p>
        <p>NearByTask Team</p>`,
      });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }

  static async verifyEmail(req: Request, res: Response): Promise<any> {
    try {
      const { token } = req.body;

      const { data, error } = await supabase
        .from("user")
        .select("*")
        .eq("verification_token", token)
        .single();

      if (error)
        return res.status(400).json({ error: "Invalid or Expired Token." });

      const { error: activateError } = await supabase
        .from("user")
        .update({ acc_status: "active" })
        .eq("verification_token", token);

      if (activateError) throw new Error(activateError.message);

      res
        .status(200)
        .json({ message: "Email verified successfully. You can now log in." });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }

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
        verification_token: "",
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

  static async getUserData(req: Request, res: Response): Promise<void> {
    try {
      const userID = req.params.id;
      console.log(userID);

      const { data, error } = await supabase
        .from("user")
        .select("*")
        .eq("user_id", userID)
        .single();

      //console.log({data, error})

      if (error) {
        res.status(500).json({ error: error.message });
      } else if (!data) {
        res.status(404).json({ error: "User not found" });
      } else {
        res.status(200).json({ user: data });
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

  static async updateUser(req: Request, res: Response): Promise<any> {
    try {
      const userId = Number(req.params.id);
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

      const { data: existingUser, error: findError } = await supabase
        .from("user")
        .select("email, user_id")
        .eq("email", email)
        .neq("user_id", userId)
        .maybeSingle();

      if (existingUser) {
        return res.status(400).json({ error: "Email already exists" });
      }

      if (findError && findError.message !== "No rows found") {
        throw new Error(findError.message);
      }

      let imageUrl = "";
      if (imageFile) {
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

      const updateData: Record<string, any> = {
        first_name,
        middle_name,
        last_name,
        birthdate: birthday,
        email,
        acc_status,
        user_role,
      };

      if (imageFile) {
        updateData.image_link = imageUrl;
      }

      const { error } = await supabase
        .from("user")
        .update(updateData)
        .eq("user_id", userId);

      if (error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(200).json({ message: "User updated successfully" });
      }
    } catch (error) {
      res.status(500).json({
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }
}

export default UserAccountController;
