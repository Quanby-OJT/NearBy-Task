import {body} from "express-validator"

export const validateLogin = [
    body("email").notEmpty().withMessage("Email cannot be empty.").isEmail().withMessage("Email entered is not valid. Please Try Again."),
    body("password").notEmpty().withMessage("Please Enter your Password.").isLength({min: 6}).withMessage("Password must be at least 6 characters long.")
]

export const validateOTP = [
    body("otp").notEmpty().withMessage("Please enter your OTP").isLength({ min: 6, max: 6 }).withMessage("OTP must be exactly 6 digits")
]