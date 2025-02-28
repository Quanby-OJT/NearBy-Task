import { Router } from "express";
import LikeController from "../controllers/likeController";


const router = Router();

router.post("/likeJob", LikeController.createLike);

export default router;