import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TaskService } from 'src/app/services/task.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-task',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './task.component.html',
  styleUrls: ['./task.component.css']
})
export class TaskComponent {
  Math = Math;
  tasks: any[] = [];
  filteredTasks: any[] = [];
  displayedTasks: any[] = [];
  paginationButtons: (number | string)[] = [];
  tasksPerPage: number = 10;
  currentPage: number = 1;
  totalPages: number = 1;

  constructor(
    private route: Router,
    private taskService: TaskService
  ) {}

  ngOnInit(): void {
    this.taskService.getTasks().subscribe(
      (response) => {
        this.tasks = response.tasks;
        this.filteredTasks = response.tasks;
        this.updatePagination();
      },
      (error) => console.error('Error fetching tasks:', error)
    );
  }

  filterTasks(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value.toLowerCase();
    this.filteredTasks = selectedValue === "" 
      ? this.tasks 
      : this.tasks.filter(task => task.status?.toLowerCase() === selectedValue);
    this.currentPage = 1;
    this.updatePagination();
  }

  searchTasks(event: Event) {
    const searchValue = (event.target as HTMLInputElement).value.toLowerCase();
    this.filteredTasks = this.tasks.filter(task => 
      task.specialization.toLowerCase().includes(searchValue)
    );
    this.currentPage = 1;
    this.updatePagination();
  }

  updatePagination() {
    this.totalPages = Math.ceil(this.filteredTasks.length / this.tasksPerPage);
    this.displayedTasks = this.filteredTasks.slice(
      (this.currentPage - 1) * this.tasksPerPage,
      this.currentPage * this.tasksPerPage
    );

    this.generatePagination();
  }

  generatePagination() {
    let maxPagesToShow = 3;
    let startPage = Math.max(1, this.currentPage - 1);
    let endPage = Math.min(this.totalPages, startPage + maxPagesToShow - 1);

    this.paginationButtons = [];

    if (startPage > 1) {
      this.paginationButtons.push(1);
      if (startPage > 2) {
        this.paginationButtons.push('...');
      }
    }

    for (let i = startPage; i <= endPage; i++) {
      this.paginationButtons.push(i);
    }

    if (endPage < this.totalPages) {
      if (endPage < this.totalPages - 1) {
        this.paginationButtons.push('...');
      }
      this.paginationButtons.push(this.totalPages);
    }
  }

  changeTasksPerPage(event: Event) {
    this.tasksPerPage = parseInt((event.target as HTMLSelectElement).value, 10);
    this.currentPage = 1;
    this.updatePagination();
  }

  goToPage(page: number | string) {
    const pageNumber = typeof page === 'string' ? parseInt(page, 10) : page;
    if (pageNumber >= 1 && pageNumber <= this.totalPages) {
      this.currentPage = pageNumber;
      this.updatePagination();
    }
  }
  
  disableTask(taskId: string) {
    this.route.navigate(['tasks-management/task-disable', taskId]);
  }
}
