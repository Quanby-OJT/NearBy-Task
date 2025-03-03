import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class DataService {
  private userID: Number = 0;

  setUserID(data: Number) {
    this.userID = data;
  }

  getUserID() {
    return this.userID;
  }
}
