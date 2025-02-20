import { HttpClient } from '@angular/common/http';
import { Component, computed, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { toast } from 'ngx-sonner';
import { dummyData } from 'src/app/shared/dummy/user.dummy';
import { UserTableActionComponent } from '../table/table-action/table-action.component';
import { UserTableFooterComponent } from '../table/table-footer/table-footer.component';
import { UserTableHeaderComponent } from '../table/table-header/table-header.component';
import { UserTableRowComponent } from '../table/table-row/table-row.component';
import { Users } from 'src/model/user-management';
import { UserTableFilterService } from 'src/services/user-table-filter';

@Component({
  selector: 'app-users',
  imports: [
    AngularSvgIconModule,
    FormsModule,
    UserTableHeaderComponent,
    UserTableFooterComponent,
    UserTableRowComponent,
    UserTableActionComponent,
  ],
  templateUrl: './users.component.html',
  styleUrl: './users.component.css',
})
export class UsersComponent implements OnInit {
  users = signal<Users[]>([]);

  constructor(private http: HttpClient, private filterService: UserTableFilterService) {
    this.http.get<Users[]>('https://freetestapi.com/api/v1/users?limit=8').subscribe({
      next: (data) => this.users.set(data),
      error: (error) => {
        this.users.set(dummyData);
        this.handleRequestError(error);
      },
    });
  }

  public toggleUsers(checked: boolean) {
    this.users.update((users) => {
      return users.map((user) => {
        return { ...user, selected: checked };
      });
    });
  }

  private handleRequestError(error: any) {
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

  filteredUsers = computed(() => {
    const search = this.filterService.searchField().toLowerCase();
    const status = this.filterService.statusField();
    const order = this.filterService.orderField();

    return this.users()
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
  });

  ngOnInit() {}
}
