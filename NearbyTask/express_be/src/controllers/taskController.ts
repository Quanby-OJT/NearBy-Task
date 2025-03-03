import { Request, Response } from "express";
import userModel from "../models/taskModel"; // Import the model
import { supabase } from "../config/configuration";

class TaskController {
  static async createTask(req: Request, res: Response): Promise<void> {
    try {
      console.log("Received insert data:", req.body);
      const {user_id, job_title, specialization, description, location, duration, num_of_days, urgency, contact_price, remarks, task_begin_date } = req.body;
      let urgent = false;

      // Check for missing fields. This will be relocated to tasker/client validation.
      // if (!job_title || !specialization || !description || !location || 
      //     !duration || !num_of_days || !urgency || !contact_price || 
      //     !remarks || !task_begin_date) {
      //   res.status(400).json({ message: "Missing required fields" });
      //   return;
      // }

      if(urgency == "Urgent") urgent = true
      else if(urgency == "Non-Urgent") urgent = false

      // Call the model to insert data into Supabase
      const newTask = await userModel.createNewTask(user_id,
        description, duration, job_title, urgent, location, 
        num_of_days, specialization, contact_price, remarks, task_begin_date
      );

      res.status(201).json({ message: "Task created successfully", task: newTask });
    } catch (error) {
      console.error(error instanceof Error ? error.message : "Error Unknown")
      res.status(500).json({ error: error instanceof Error ? error.message : "Unknown error" });
    }
  }

  static async getAllTasks(req: Request, res: Response): Promise<void> {
    try {
      const { data, error } = await supabase.from("job_post").select();

      if (error) {
        res.status(500).json({ error: error.message });
      } else {  
        res.status(200).json({ tasks: data });
      }
    } catch (error) {
      res.status(500).json({
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }

  static async getTask(req: Request, res: Response): Promise<void> {
    try {
      const { client_id } = req.body
      const allTasks = await userModel.showTaskforClient(client_id);
      res.status(200).json({ tasks: allTasks });
    }catch(error){
      console.error(error);
      res.status(500).json({ error: error instanceof Error ? error.message : "Unknown error" });
    }
  }

  static async disableTask(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const { data, error } = await supabase
        .from('job_post')
        .update({ status: 'disabled' })
        .eq('job_post_id', id)
        .select();
  
      if (error) throw error;
      res.status(200).json({ message: 'Task disabled', task: data[0] });
    } catch (error) {
      res.status(500).json({ error: error instanceof Error ? error.message : "Unknown error" });
    }
  }

  /**
   * The purpose of this code is to make specialization assignnment easy for taskers and clients.
   * @param req 
   * @param res 
   */
  static async getAllSpecializations(req: Request, res: Response): Promise<void> {
    try {
      console.log("Received request to get all specializations");
      const { data, error } = await supabase.from("tasker_specialization").select('specialization');

      if (error) {
        console.error(error.message)
        res.status(500).json({ error: error.message });
      } else {  
        res.status(200).json({ tasks: data });
      }
    } catch (error) {
      res.status(500).json({
        error: error instanceof Error ? error.message : "Unknown error",
      });
    }
  }
}

export default TaskController;
