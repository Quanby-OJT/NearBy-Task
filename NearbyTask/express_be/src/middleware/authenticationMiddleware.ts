import { Request, Response, NextFunction } from "express";

export function isAuthenticated(req: Request, res: Response, next: NextFunction): void {
    
    if (req.session.id) {
        next()
    }else{
        res.status(401).json({ errors: "Unauthorized" });
    }
};
