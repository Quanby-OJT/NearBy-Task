import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { TaskReportedListComponent } from './task-reported-list/task-reported-list.component';
import { TaskListComponent } from './task-list/task-list.component';
import { TaskService } from '../services/task.service'; // Import TaskService

@Component({
  selector: 'app-task',
  imports: [
    CommonModule,
    AngularSvgIconModule,
    TaskListComponent,
    TaskReportedListComponent,
  ],
  templateUrl: './task.component.html',
  styleUrl: './task.component.css'
})
export class TaskComponent implements OnInit {
  currentTab: string = "showTaskList";
  tasks: any[] = [];

  constructor(private taskService: TaskService) {}

  ngOnInit() {
    this.loadTasks();
  }

  loadTasks() {
    this.taskService.getTasks().subscribe({
      next: (response) => {
        this.tasks = response.tasks; // Assuming API returns { tasks: [...] }
      },
      error: (error) => {
        console.error("Error fetching tasks:", error);
      }
    });
  }

  changeTab(tabName: string) {
    this.currentTab = tabName;
  }
}
