import { Request, Response } from "express";

import { supabase } from "../config/configuration";
import likeModel from "../models/likeModel";

class LikeController {
    static async createLike(req: Request, res: Response): Promise<void> {
      try {
        console.log("Received insert data:", req.body);
        const { user_id, job_post_id, created_at} = req.body;
  
        // Check for missing fields
        if (!user_id || !job_post_id || !created_at) {
          res.status(400).json({ message: "Missing required fields" });
          return;
        }
  
        // Call the model to insert data into Supabase
        const newTask = await likeModel.create({
          user_id, 
          job_post_id, 
          created_at
        });
  
        res.status(201).json({ message: "Task created successfully", task: newTask });
      } catch (error) {
        res.status(500).json({ error: error instanceof Error ? error.message : "Unknown error" });
      }
    }
  
   
  }
  
  export default LikeController;
  