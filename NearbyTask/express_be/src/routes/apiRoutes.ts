import { Router } from "express";
import AuthenticationController from "../controllers/authenticationController";
import { validateLogin, validateOTP } from "../validator/authValidator";
import { handleValidationErrors } from "../middleware/validationMiddleware";
import { isAuthenticated } from "../middleware/authenticationMiddleware";
import TaskController from "../controllers/taskController";
import UserAccountController from "../controllers/userAccountController";
import multer from "multer";

const router = Router();

router.get("/", (req, res) => {
    res.send("Hello. Who is this?")
})

router.use(handleValidationErrors)

/** Authentication Routes */
router.post("/login-auth", validateLogin, AuthenticationController.loginAuthentication
);
router.post(
  "/otp-auth",
  validateOTP,
  AuthenticationController.otpAuthentication
);

router.post(
    "/reset",
    AuthenticationController.generateOTP
)

router.use(isAuthenticated);

/**
 * Application Routes (if the user is authenticated). All routes beyond this point had a middleware 
 * 
 * */
router.post("/addTask", TaskController.createTask);
const upload = multer({ storage: multer.memoryStorage() });
// Register user with image upload
router.post(
  "/userAdd",
  upload.single("image"),
  UserAccountController.registerUser
);
// Display all records
router.get("/userDisplay", UserAccountController.getAllUsers);
router.delete("/deleteUser/:id", UserAccountController.deleteUser);
router.get("/getUserData/:id", UserAccountController.getUserData);
router.put(
  "/updateUserInfo/:id/",
  upload.single("image"),
  UserAccountController.updateUser
);
router.get("/logout", AuthenticationController.logout);


export default router;
