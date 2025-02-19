import express, { Application } from "express";
import cors from "cors";
import { config } from "./config/configuration";
import userRoutes from "./routes/userRoutes";  // Import user routes

const app: Application = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/connect", userRoutes);

// Start server
const PORT = config.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
