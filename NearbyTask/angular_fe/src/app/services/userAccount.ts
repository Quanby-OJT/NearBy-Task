import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class UserAccountService {
  private apiUrl = `${environment.apiUrl}`;

  constructor(private http: HttpClient) {}
  insertUserAccount(userData: FormData): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/userAdd`, userData);
  }

  deleteUser(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/deleteUser/${id}`);
  }

  getAllUsers(): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/userDisplay`);
  }

  getUserById(userID: Number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/getUserData/${userID}`);
  }

  checkEmailExists(email: string, userId: number): Observable<boolean> {
    return this.http.get<boolean>(`${this.apiUrl}/users/check-email?email=${email}&userId=${userId}`);
  }

  updateUserAccount(userID: Number, userData: FormData): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/updateUserInfo/${userID}`, userData);
  }
}
