import { Component } from '@angular/core';
import { TaskListsComponent } from './task-lists/task-lists.component';
import { TaskReportedListsComponent } from './task-reported-lists/task-reported-lists.component';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-task',
  imports: [TaskListsComponent, TaskReportedListsComponent, CommonModule],
  templateUrl: './task.component.html',
  styleUrl: './task.component.css'
})
export class TaskComponent {
//Default to TaskList muna to
  currentComponent: string = "TaskList"; 
  
//Base on the Chosen Button from the user
  changeSelectedTask(tabName: string){
    this.currentComponent = tabName;
  }
}
