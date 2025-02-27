import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { catchError, Observable, throwError } from 'rxjs';
import { environment } from 'src/environments/environment';
import { SessionLocalStorage } from 'src/services/sessionStorage';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = `${environment.apiUrl}`;
  constructor(private router: Router, private http: HttpClient, private SessionLocalStorage: SessionLocalStorage) {}

  login(email: string, password: string): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/login`, { email, password }).pipe(
      catchError((error) => {
        console.error('HTTP Error:', error);
        return throwError(() => new Error(error?.error?.message || 'Unknown API Error'));
      }),
    );
  }

  logout(userID: Number): Observable<any> {
    // const user_id = this.SessionLocalStorage.getUserId();
    // console.log(user_id);
    return this.http.post<any>(`${this.apiUrl}/logout`, { userID }).pipe(
      catchError((error) => {
        console.error('HTTP Error:', error);
        return throwError(() => new Error(error?.error?.message || 'Unknown API Error'));
      }),
    );
    // console.log(user_id);
    // sessionStorage.removeItem('session');
    // this.router.navigate(['/auth']);
  }
}
