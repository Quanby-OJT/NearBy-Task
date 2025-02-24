import { Request, Response } from "express"
import { Auth } from "../models/userModel"
import bcrypt from "bcrypt"
import generateOTP from "otp-generator"

class AuthenticationController {
    static async loginAuthentication(req: Request, res: Response): Promise<void> {
        try {
            const { email, password } = req.body
            const verifyLogin = await Auth.authenticateLogin(email)

            if (!verifyLogin) {
                res.status(404).json({ error: "Sorry, your email does not exist. Maybe you can sign up to find your clients/taskers." })
                return
            }

            console.log(await bcrypt.hash(password, 10))

            const isPasswordValid = await bcrypt.compare(password, verifyLogin.hashed_password)
            if (!isPasswordValid) {
                res.status(414).json({ error: "Password is incorrect. Please try again." })
                return
            }

            const otp = generateOTP.generate(6, {
                digits: true,
                upperCaseAlphabets: false,
                lowerCaseAlphabets: false,
                specialChars: false,
            })

            await Auth.createOTP({ user_id: verifyLogin.user_id, two_fa_code: otp })

            res.status(200).json({ user_id: verifyLogin.user_id })
        } catch (error) {
            console.error(error)
            res.status(500).json({ error: "An error occurred while logging in. If the issue persists, contact the Administrator." })
        }
    }

    static async otpAuthentication(req: Request, res: Response): Promise<void> {
        try {
            const { user_id, otp } = req.body
            const verifyOtp = await Auth.authenticateOTP(user_id)

            if (!verifyOtp || verifyOtp.two_fa_code !== otp) {
                res.status(401).json({ error: "Invalid OTP. Please try again." })
                return
            }

            if(Date.parse(verifyOtp.two_fa_code_expires_at) <= Date.now()) res.status(401).json({ error: "Your OTP has been expired. Please Sign In again."})

            res.status(200).json({ message: "OTP verified successfully." })
        } catch (error) {
            console.error(error)
            res.status(500).json({ error: "An error occurred while verifying OTP. Please try again." })
        }
    }
}

export default AuthenticationController
