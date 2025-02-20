import {body} from "express-validator"

export const userValidation = [
    body("name").isEmpty().isString().withMessage("Please Enter a Valid Name."),
    body("email").isEmpty().isEmail().withMessage("Email is not Valid. Please Try Again."),
    body("password").isEmpty().isStrongPassword().withMessage("Your password must have at least: symbols, numbers, letters, and it must be unique.")
]

export const taskerValidation = [

]