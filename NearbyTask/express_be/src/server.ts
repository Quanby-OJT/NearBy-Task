import express, { Application } from "express";
import cors from "cors";
import { port } from "./config/configuration";
import server from "./routes/apiRoutes";
import userRoute from "./routes/userRoutes";
import userAccountRoute from "./routes/userAccountRoutes";
import taskRoutes from "./routes/taskRoutes";
import dotenv from "dotenv";
import authRoutes from "./routes/authRoutes";

dotenv.config();
const app: Application = express();

// Middleware
app.use(cors({
  origin: "http://10.0.2.2:5000", // Replace with your frontend URL
  credentials: true, // Allow creden
}));
app.use(express.json());

// Routes
app.use(
  "/connect",
  server,
  userAccountRoute,
  userRoute,
  taskRoutes,
  authRoutes
);

// Start server
const PORT = port || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log("Click this to direct: http://localhost:" + PORT + "/connect");
});
