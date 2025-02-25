import express, { Application } from "express";
import cors from "cors";
import { port, session_key } from "./config/configuration";
import server from "./routes/apiRoutes";
import userRoute from "./routes/userRoutes";
import userAccountRoute from "./routes/userAccountRoutes";
import dotenv from "dotenv";
import session from "express-session"

dotenv.config();
const app: Application = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(session({ 
  secret: session_key,
  resave: false,
  saveUninitialized: false,
  cookie: {maxAge: 1000 * 60 * 60} //1 hour only
}))

// Routes
app.use("/connect", server, userAccountRoute, userRoute);

// Start server
const PORT = port || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
