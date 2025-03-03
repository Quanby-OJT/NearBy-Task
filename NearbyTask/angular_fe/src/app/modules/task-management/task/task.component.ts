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
  tasksPerPage: number = 10;
  currentPage: number = 1;
  totalPages: number = 1;

  constructor(
    private route: Router,
    private taskService: TaskService) {}

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
  }

  changeTasksPerPage(event: Event) {
    this.tasksPerPage = parseInt((event.target as HTMLSelectElement).value, 10);
    this.currentPage = 1;
    this.updatePagination();
  }

  goToPage(page: number) {
    if (page >= 1 && page <= this.totalPages) {
      this.currentPage = page;
      this.updatePagination();
    }
  }

  disableTask(taskId: string) {
    this.route.navigate(['tasks-management/task-disable', taskId]);
  }
}
