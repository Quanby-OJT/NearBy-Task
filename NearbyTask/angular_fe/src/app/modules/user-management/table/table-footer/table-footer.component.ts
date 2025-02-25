import { Component, Input } from '@angular/core';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { UserTableFilterService } from 'src/services/user-table-filter';
import { UsersComponent } from '../../users/users.component';

@Component({
  selector: 'app-table-footer',
  imports: [AngularSvgIconModule],
  templateUrl: './table-footer.component.html',
  styleUrl: './table-footer.component.css',
})
export class UserTableFooterComponent {
  constructor(public filterService: UserTableFilterService, public userSize: UsersComponent) {}

  get UserSize(): number {
    return this.userSize.UserSize;
  }

  onPageSizeChange(value: Event) {
    const selectElement = value.target as HTMLSelectElement;
    this.filterService.pageSizeField.set(Number(selectElement.value));
    this.filterService.currentPageField.set(1);

    console.log(this.UserSize);
  }

  get currentPage(): number {
    return this.filterService.currentPageField();
  }

  get pageSize(): number {
    return this.filterService.pageSizeField();
  }

  get totalPages(): number {
    return Math.ceil(this.UserSize / this.pageSize);
  }

  get startIndex(): number {
    return (this.currentPage - 1) * this.pageSize + 1;
  }

  get endIndex(): number {
    return Math.min(this.currentPage * this.pageSize, this.UserSize);
  }

  onNextPage(): void {
    if (this.currentPage < this.totalPages) {
      this.filterService.currentPageField.set(this.currentPage + 1);
    }
  }

  onPreviousPage(): void {
    if (this.currentPage > 1) {
      this.filterService.currentPageField.set(this.currentPage - 1);
    }
  }

  goToPage(page: number): void {
    if (page >= 1 && page <= this.totalPages) {
      this.filterService.currentPageField.set(page);
    }
  }

  isNumber(value: any): boolean {
    return typeof value === 'number';
  }

  getVisiblePages(): (number | '...')[] {
    const totalPages = this.totalPages;
    const currentPage = this.currentPage;

    if (totalPages <= 3) {
      return Array.from({ length: totalPages }, (_, i) => i + 1);
    }

    if (currentPage <= 2) {
      return [1, 2, 3, '...'];
    }

    if (currentPage >= totalPages - 1) {
      return ['...', totalPages - 2, totalPages - 1, totalPages];
    }

    return ['...', currentPage - 1, currentPage, currentPage + 1, '...'];
  }
}
