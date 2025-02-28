import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Output } from '@angular/core';
import { TaskService } from 'src/app/services/task.service';

@Component({
  selector: 'app-task-list',
  standalone: true, 
  imports: [CommonModule],
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css'],
  providers: [TaskService] 
})
export class TaskListComponent {
  tasks: any[] = [];
  filteredTasks: any[] = [];
  displayedTasks: any[] = []; // Stores tasks to be shown in the table
  tasksPerPage: number = 10; // Default to 10

  @Output() changeTab = new EventEmitter<{ tabName: string, task: any }>(); 

  constructor(private taskService: TaskService) {}

  ngOnInit(): void {
    this.taskService.getTasks().subscribe(
      (response) => {
        this.tasks = response.tasks;
        this.filteredTasks = response.tasks;
        this.updateDisplayedTasks();
      },
      (error) => {
        console.error('Error fetching tasks:', error);
      }
    );
  }

  onChangeTab(tabName: string, task: any) {  
    this.changeTab.emit({ tabName, task }); 
  }

  // Refresh tasks after disabling
  refreshTasks() {
    this.taskService.getTasks().subscribe({
      next: (response) => {
        this.tasks = response.tasks;
        this.filteredTasks = response.tasks;
        this.updateDisplayedTasks();
      },
      error: (err) => console.error('Refresh failed:', err)
    });
  }

  // Filters tasks by status
  filterTasks(event: Event) {
    const selectedValue = (event.target as HTMLSelectElement).value.toLowerCase();

    if (selectedValue === "") {
      this.filteredTasks = this.tasks; 
    } else {
      this.filteredTasks = this.tasks.filter(task => 
        task.status && task.status.toLowerCase() === selectedValue
      );
    }
    this.updateDisplayedTasks(); // Update table based on filter
  }

  // Updates the displayed tasks based on pagination
  updateDisplayedTasks() {
    this.displayedTasks = this.filteredTasks.slice(0, this.tasksPerPage);
  }

  // Handles dropdown change to set tasks per page
  changeTasksPerPage(event: Event) {
    this.tasksPerPage = parseInt((event.target as HTMLSelectElement).value, 10);
    this.updateDisplayedTasks();
  }
}
