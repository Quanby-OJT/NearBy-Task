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
  @Output() changeTab = new EventEmitter<{ tabName: string, task: any }>(); 

  ngOnInit(): void {
    this.taskService.getTasks().subscribe(
      (response) => {
        this.tasks = response.tasks;
      },
      (error) => {
        console.error('Error fetching tasks:', error);
      }
    );
  }

  constructor(private taskService: TaskService) {} 

  onChangeTab(tabName: string, task: any) {  
    this.changeTab.emit({ tabName, task }); 
  }

  // Add this method to refresh tasks after disabling
  refreshTasks() {
  this.taskService.getTasks().subscribe({
    next: (response) => this.tasks = response.tasks,
    error: (err) => console.error('Refresh failed:', err)
  });
}

}