import { Router } from "express";
import AuthenticationController from "../controllers/authenticationController";
import { validateLogin, validateOTP } from "../validator/authValidator";
import { handleValidationErrors } from "../middleware/validationMiddleware";
import auth from "../controllers/authAngularController";
const router = Router();

/** Authentication Routes */

router.post("/login", auth.login);
router.post("/logout", auth.logout);
router.post("/logout-without-session", auth.logoutWithoutSession);

export default router;
