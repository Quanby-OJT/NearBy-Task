import { Router } from "express";
import AuthenticationController from "../controllers/authenticationController";
import { validateLogin, validateOTP } from "../validator/authValidator";
import { handleValidationErrors } from "../middleware/validationMiddleware";
import { isAuthenticated } from "../middleware/authenticationMiddleware";
const router = Router();

router.get("/", (req, res) => {
    res.send("Hello. Who is this?")
})

/** Authentication Routes */
router.post("/login-auth",validateLogin,handleValidationErrors,AuthenticationController.loginAuthentication
);
router.post(
  "/otp-auth",
  validateOTP,
  handleValidationErrors,
  AuthenticationController.otpAuthentication
);

router.post(
    "/reset",
    AuthenticationController.generateOTP
)

/**Application Routes (if the user is authenticated) */


export default router;
