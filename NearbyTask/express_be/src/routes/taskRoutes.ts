// routes/userRoutes.ts
import { Router } from "express";
import TaskController from "../controllers/taskController";


const router = Router();

router.post("/addTask", TaskController.createTask);

router.get("/displayTask", TaskController.getAllTasks);

export default router;
