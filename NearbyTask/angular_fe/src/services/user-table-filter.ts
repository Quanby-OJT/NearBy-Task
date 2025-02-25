import { Injectable, signal } from '@angular/core';

@Injectable({
  providedIn: 'root',
})
export class UserTableFilterService {
  searchField = signal<string>('');
  statusField = signal<string>('');
  orderField = signal<string>('');
  roleField = signal<string>('');
  pageSizeField = signal<number>(10);
  currentPageField = signal<number>(1);

  constructor() {}
}
