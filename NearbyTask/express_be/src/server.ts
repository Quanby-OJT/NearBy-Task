import express, { Application } from "express";
import cors from "cors";
import { port } from "./config/configuration";
import server from "./routes/apiRoutes";
import userRoute from "./routes/userRoutes";
import userAccountRoute from "./routes/userAccountRoutes";
import dotenv from "dotenv";

dotenv.config();
const app: Application = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/connect", server, userAccountRoute, userRoute);

// Start server
const PORT = port || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
