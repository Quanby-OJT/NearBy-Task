import { ThemeService } from 'src/app/core/services/theme.service';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { toast } from 'ngx-sonner';
import { UserTableActionComponent } from '../table/table-action/table-action.component';
import { UserTableFooterComponent } from '../table/table-footer/table-footer.component';
import { UserTableHeaderComponent } from '../table/table-header/table-header.component';
import { UserTableRowComponent } from '../table/table-row/table-row.component';
import { AddUserComponent } from '../add-user/add-user.component';
import { Router, RouterOutlet } from '@angular/router';
import { UserAccountService } from 'src/app/services/userAccount';
import { UserTableFilterService } from 'src/services/user-table-filter';

@Component({
  selector: 'app-users',
  standalone: true,
  imports: [
    AngularSvgIconModule,
    FormsModule,
    UserTableHeaderComponent,
    UserTableFooterComponent,
    UserTableRowComponent,
    UserTableActionComponent,
    AddUserComponent,
    RouterOutlet,
  ],
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css'],
})
export class UsersComponent implements OnInit {
  users: any[] = [];

  constructor(
    private http: HttpClient,
    private filterService: UserTableFilterService,
    private router: Router,
    private useraccount: UserAccountService,
  ) {}

  ngOnInit(): void {
    this.fetchUsers();
  }

  fetchUsers(): void {
    this.useraccount.getAllUsers().subscribe(
      (response: any) => {
        this.users = response.users;
      },
      (error: any) => {
        console.error('Error fetching users:', error);
        this.handleRequestError(error);
      },
    );
  }

  toggleUsers(checked: boolean): void {
    this.users = this.users.map((user) => ({
      ...user,
      selected: checked,
    }));
  }

  private handleRequestError(error: any): void {
    const msg = 'An error occurred while fetching users. Loading dummy data as fallback.';
    toast.error(msg, {
      position: 'bottom-right',
      description: error.message,
      action: {
        label: 'Undo',
        onClick: () => console.log('Action!'),
      },
      actionButtonStyle: 'background-color:#DC2626; color:white;',
    });
  }

  get filteredUsers(): any[] {
    const search = this.filterService.searchField().toLowerCase();
    const status = this.filterService.statusField();
    const order = this.filterService.orderField();

    return this.users
      .filter(
        (user) =>
          user.name.toLowerCase().includes(search) ||
          user.username.toLowerCase().includes(search) ||
          user.email.toLowerCase().includes(search) ||
          user.phone.includes(search),
      )
      .filter((user) => {
        if (!status) return true;
        switch (status) {
          case '1':
            return user.status === 1;
          case '2':
            return user.status === 2;
          case '3':
            return user.status === 3;
          default:
            return true;
        }
      })
      .sort((a, b) => {
        const defaultNewest = !order || order === '1';
        if (defaultNewest) {
          return new Date(b.created_at).getTime() - new Date(a.created_at).getTime();
        } else if (order === '2') {
          return new Date(a.created_at).getTime() - new Date(b.created_at).getTime();
        }
        return 0;
      });
  }

  navigateToAddUser(): void {
    this.router.navigate(['user-management/add-user']);
  }
}
