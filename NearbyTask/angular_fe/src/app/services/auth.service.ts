import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  password: string = 'admin123';
  email: string = 'admin@gmail.com';
  constructor(private router: Router) {}

  login(email: string, password: string): boolean {
    if (email === this.email && password === this.password) {
      localStorage.setItem('token', 'dummy-jwt-token');
      localStorage.setItem('role', 'admin');
      return true;
    }
    return false;
  }

  logout(): void {
    localStorage.removeItem('token');
    localStorage.removeItem('role');
    this.router.navigate(['/auth']);
  }
}
