import { Request, Response } from "express";
import { Tasks } from "../models/taskModel";
import { TaskAssignment } from "../models/taskAssignmentModel"

class TaskController{
    static async create(req: Request, res: Response){
        try{
            const {task_title, task_description, task_begin_date, duration, period, price, urgent, remarks} = req.body

            const newTask = await Tasks.create({
                task_title, 
                task_description, 
                task_begin_date, 
                duration, 
                period, 
                contact_price: price, 
                urgent,
                remarks
            })
        }
        catch(error){
            res.status(500).json({ error: error instanceof Error ? error.message : "Unknown error" });
        }
    }
}

class TaskAssignmentController{

}

export default {TaskController, TaskAssignmentController}