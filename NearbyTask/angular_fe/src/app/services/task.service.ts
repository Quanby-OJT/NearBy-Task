import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class TaskService {
  private apiUrl = 'http://localhost:5000/connect/displayTask'; 

  constructor(private http: HttpClient) {}

  getTasks(): Observable<any> {
    return this.http.get<any>(this.apiUrl);
  }

disableTask(taskId: string): Observable<any> {
  return this.http.patch<any>(`${this.apiUrl}/${taskId}/disable`, {});
  }
}
