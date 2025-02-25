import { HttpClient } from '@angular/common/http';
import { Component, effect, OnInit } from '@angular/core';
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
import { ButtonComponent } from 'src/app/shared/components/button/button.component';

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
    ButtonComponent,
  ],
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css'],
})
export class UsersComponent implements OnInit {
  public users: any[] = [];
  public PaginationUsers: any[] = [];
  displayedUsers = this.filterService.currentUsers;

  constructor(
    private http: HttpClient,
    private filterService: UserTableFilterService,
    private router: Router,
    private useraccount: UserAccountService,
  ) {
    effect(() => {
      const currentPage = this.filterService.currentPageField();
      const pageSize = this.filterService.pageSizeField();
      this.loadUsers(currentPage, pageSize);
    });
  }

  loadUsers(page: number, pageSize: number) {
    this.useraccount.getUsers(page, pageSize).subscribe(
      (response) => {
        console.log('Fetched Users:', response.users);
        this.filterService.setCurrentUsers(response.users || []);
        this.filterService.userSizeField.set(response.total || 0);
      },
      (error) => {
        console.error('Load Users Error:', error);
      },
    );
  }

  ngOnInit(): void {
    this.fetchUsers();
    this.setUserSize();
  }

  setUserSize(): void {
    this.useraccount.getUsers(1, 10).subscribe((users) => {
      this.filterService.setUsers(this.users);
    });
  }

  get UserSize(): number {
    return this.users.length;
  }

  fetchUsers(): void {
    this.useraccount.getAllUsers().subscribe(
      (response: any) => {
        this.users = response.users;
        this.filterService.setUsers(this.users);
      },
      (error: any) => {
        console.error('Error fetching users:', error);
        this.handleRequestError(error);
      },
    );
  }

  get filteredUsers(): any[] {
    const search = this.filterService.searchField().toLowerCase() || '';
    console.log('Search Value:', search);
    const status = this.filterService.statusField();
    const pageSize = this.filterService.pageSizeField();
    const role = this.filterService.roleField();
    this.PaginationUsers = this.filterService.currentUsers();
    console.log('Current Users:', this.PaginationUsers);

    return this.PaginationUsers.filter(
      (user) =>
        user.first_name.toLowerCase().includes(search) ||
        user.last_name.toLowerCase().includes(search) ||
        user.email.toLowerCase().includes(search),
    )
      .filter((user) => {
        if (!status) return true;
        switch (status) {
          case '1':
            return user.acc_status === 'active';
          case '2':
            return user.acc_status === 'blocked';
          case '3':
            return user.acc_status === 'review';
          default:
            return true;
        }
      })
      .filter((user) => {
        if (!role) return true;
        switch (role) {
          case '1':
            return user.user_role === 'client';
          case '2':
            return user.user_role === 'tasker';
          case '3':
            return user.user_role === 'moderator';
          default:
            return true;
        }
      })
      .slice(0, pageSize);
  }

  toggleUsers(checked: boolean): void {
    this.users = this.users.map((user) => ({
      ...user,
      selected: checked,
    }));
  }

  // private handleRequestError(error: any): void {
  //   const msg = 'An error occurred while fetching users. Loading dummy data as fallback.';
  //   toast.error(msg, {
  //     position: 'bottom-right',
  //     description: error.message,
  //     action: {
  //       label: 'Undo',
  //       onClick: () => console.log('Action!'),
  //     },
  //     actionButtonStyle: 'background-color:#DC2626; color:white;',
  //   });
  // }

  handleRequestError(error: any): void {
    console.error('API Request Error:', error);
    toast.error(error?.message || 'An unknown error occurred');
  }

  navigateToAddUser(): void {
    this.router.navigate(['user-management/add-user']);
  }

  navigateToUpdateUser(): void {
    this.router.navigate(['user-management/update-user']);
  }
}
