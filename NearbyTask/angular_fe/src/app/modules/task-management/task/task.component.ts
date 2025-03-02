import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TaskService } from 'src/app/services/task.service';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-task',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './task.component.html',
  styleUrls: ['./task.component.css']
})
export class TaskComponent {
  tasks: any[] = [];
  filteredTasks: any[] = [];
  displayedTasks: any[] = [];
  tasksPerPage: number = 10;

  constructor(private taskService: TaskService) {}

  ngOnInit(): void {
    this.taskService.getTasks().subscribe(
      (response) => {
        this.tasks = response.tasks;
        this.filteredTasks = response.tasks;
        this.updateDisplayedTasks();
      },
      (error) => console.error('Error fetching tasks:', error)
    );
  }

  filterTasks(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value.toLowerCase();
    this.filteredTasks = selectedValue === "" 
      ? this.tasks 
      : this.tasks.filter(task => task.status?.toLowerCase() === selectedValue);
    this.updateDisplayedTasks();
  }

  updateDisplayedTasks() {
    this.displayedTasks = this.filteredTasks.slice(0, this.tasksPerPage);
  }

  changeTasksPerPage(event: Event) {
    this.tasksPerPage = parseInt((event.target as HTMLSelectElement).value, 10);
    this.updateDisplayedTasks();
  }

  searchTasks(event: Event) {
    const searchValue = (event.target as HTMLInputElement).value.toLowerCase();
    this.filteredTasks = this.tasks.filter(task => 
      task.specialization.toLowerCase().includes(searchValue)
    );
    this.updateDisplayedTasks();
  }
}