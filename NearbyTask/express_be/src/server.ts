import express, { Application } from "express";
import cors from "cors";
import { port, session_key } from "./config/configuration";
import server from "./routes/apiRoutes";
import dotenv from "dotenv";
import session from "express-session"

dotenv.config();
const app: Application = express();

declare module 'express-session' {
  interface SessionData {
    user: string;
  }
}

// Middleware
app.use(cors({
  origin: "http://192.168.56.1:5000", // Replace with your frontend URL
  credentials: true, // Allow creden
}));
app.use(express.json());
app.use(session({ 
  secret: session_key,
  resave: false,
  saveUninitialized: false,
  cookie: {maxAge: 1000 * 60 * 60} //1 hour only
}))

// Routes
app.use("/connect", server);

// Start server
const PORT = port || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log("Click this to direct: http://localhost:" + PORT +  "/connect");
});
