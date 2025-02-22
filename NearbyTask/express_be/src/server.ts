import express, { Application } from "express";
import cors from "cors";
import { port } from "./config/configuration";
import server from "./routes/apiRoutes"

const app: Application = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/connect", server);

// Start server
const PORT = port || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
