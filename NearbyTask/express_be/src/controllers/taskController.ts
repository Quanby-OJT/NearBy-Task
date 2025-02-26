import { Request, Response } from "express";
import userModel from "../models/taskModel"; // Import the model

class TaskController {
  static async createTask(req: Request, res: Response): Promise<void> {
    try {
      console.log("Received insert data:", req.body);
      const { job_title, specialization, description, location, duration, num_of_days, urgency, contact_price, remarks, task_begin_date } = req.body;

      // Check for missing fields. This will be relocated to tasker/client validation.
      // if (!job_title || !specialization || !description || !location || 
      //     !duration || !num_of_days || !urgency || !contact_price || 
      //     !remarks || !task_begin_date) {
      //   res.status(400).json({ message: "Missing required fields" });
      //   return;
      // }

      // Call the model to insert data into Supabase
      const newTask = await userModel.createUser(
        description, duration, job_title, urgency, location, 
        num_of_days, specialization, contact_price, remarks, task_begin_date
      );

      res.status(201).json({ message: "Task created successfully", task: newTask });
    } catch (error) {
      res.status(500).json({ error: error instanceof Error ? error.message : "Unknown error" });
    }
  }
}

export default TaskController;
