import { Router } from "express";
import AuthenticationController from "../controllers/authenticationController";
import { validateLogin, validateOTP } from "../validator/authValidator";
import { handleValidationErrors } from "../middleware/validationMiddleware";
import { isAuthenticated } from "../middleware/authenticationMiddleware";
import TaskController from "../controllers/taskController";
import UserAccountController from "../controllers/userAccountController";
import ProfileController from "../controllers/profileController";
import multer from "multer";
import { taskerValidation, userValidation, clientValidation } from "../validator/userValidator";

const router = Router();

router.get("/", (req, res) => {
    res.send("Hello. Who is this?")
})

router.use(handleValidationErrors)

const upload = multer({ storage: multer.memoryStorage() });
// Register user with image upload
router.post(
  "/create-new-user",
  upload.single("image"),
  userValidation,
  UserAccountController.registerUser
);

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
router.post("/create-new-tasker", taskerValidation, ProfileController.TaskerController.createTasker)

router.post("/create-new-client", clientValidation, ProfileController.ClientController.createClient)
router.post("/addTask", TaskController.createTask);

// Display all records
router.get("/userDisplay", UserAccountController.getAllUsers);
router.delete("/deleteUser/:id", UserAccountController.deleteUser);
router.get("/getUserData/:id", UserAccountController.getUserData);
router.put("/updateUserInfo/:id/", upload.single("image"),UserAccountController.updateUser)
router.get("/logout", AuthenticationController.logout);

export default router;
