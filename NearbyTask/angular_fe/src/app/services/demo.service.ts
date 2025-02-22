import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class DemoService {
  private apiUrl = `${environment.apiUrl}/display`;

  constructor(private http: HttpClient) {}

  // Fetch all users
  // getAllUsers(): Observable<any> {
  //   return this.http.get<any>(this.apiUrl);
  // }

  getAllUsers(): Observable<any> {
    return this.http.get<any>(this.apiUrl);
  }
}
