import { Request, Response } from "express"
import { Auth } from "../models/authenticationModel"
import bcrypt from "bcrypt"
import generateOTP from "otp-generator"
import { mailer } from "../config/configuration"

class AuthenticationController {
    static async loginAuthentication(req: Request, res: Response): Promise<void> {
        try {
            const { email, password } = req.body
            const verifyLogin = await Auth.authenticateLogin(email)

            if (!verifyLogin) {
                res.status(404).json({ error: "Sorry, your email does not exist. Maybe you can sign up to find your clients/taskers." })
                return
            }

            //console.log(await bcrypt.hash(password, 10))

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

            const otpHtml = `
            <div class="bg-gray-100 p-6 rounded-lg shadow-lg">
              <h2 class="text-xl font-bold text-gray-800">🔒 Your OTP Code</h2>
              <p class="text-gray-700 mt-4">In order to use the application, enter the following OTP:</p>
              <div class="mt-4 text-center">
                <span class="text-3xl font-bold text-blue-600">${otp}</span>
              </div>
              <p class="text-red-500 mt-4">Note: This OTP will expire 5 minutes from now.</p>
              <p class="text-gray-500 mt-6 text-sm">If you didn't request this code, please ignore this email.</p>
            </div>`
          

            await mailer.sendMail({
                from: "noreply@nearbytask.com",
                to: email,
                subject: "Your OTP Code for NearByTask",
                html: otpHtml
            })

            res.status(200).json({ user_id: verifyLogin.user_id })
        } catch (error) {
            console.error(error)
            res.status(500).json({ error: "An error occurred while logging in. If the issue persists, contact the Administrator." })
        }
    }

    static async generateOTP(req: Request, res: Response): Promise<void>{

        try{

            const {userId} = req.body

            const otp = generateOTP.generate(6, {
            digits: true,
            upperCaseAlphabets: false,
            lowerCaseAlphabets: false,
            specialChars: false,
            })

            await Auth.createOTP({ user_id: userId, two_fa_code: otp })

            res.status(200).json({message: "Successfully Regenrated OTP. Please Check Your Email."})
        }catch(error){
            console.error(error)
            res.status(500).json({error: "An Error Occured while regenearating OTP. Please Try Again. If Issue persists, contact the Administrator."})
        }
    }

    static async otpAuthentication(req: Request, res: Response): Promise<void> {
        try {
            const { user_id, otp } = req.body
            const verifyOtp = await Auth.authenticateOTP(user_id)

            if(verifyOtp == null){
                res.status(401).json({error: "Please Login again"})
                return
            }

            if (verifyOtp.two_fa_code !== otp) {
                res.status(401).json({ error: "Invalid OTP. Please try again." })
                return
            }

            if(Date.parse(verifyOtp.two_fa_code_expires_at) <= Date.now()) {
                res.status(401).json({ error: "Your OTP has been expired. Please Sign In again."})
                await Auth.resetOTP(user_id)
            }

            Auth.resetOTP(user_id)
            req.session.user = user_id

            res.status(200).json({ user_id: user_id })
        } catch (error) {
            console.error(error)
            res.status(500).json({ error: "An error occurred while verifying OTP. Please try again." })
        }
    }

    static async logout(req: Request, res: Response): Promise<void> {
        req.session.destroy((error) => {
            if (error) {
                res.status(500).json({ error: "An error occurred while logging out. Please try again." })
                return
            }
            res.clearCookie("connect.sid")
            res.status(200).json({ message: "Successfully logged out." })
        })
    }
}

export default AuthenticationController
