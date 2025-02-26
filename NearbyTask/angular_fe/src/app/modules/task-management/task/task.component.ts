import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TaskListsComponent } from './task-lists/task-lists.component';
import { TaskReportedListsComponent } from './task-reported-lists/task-reported-lists.component';
import { TaskActionComponent } from './task-action/task-action.component';

@Component({
  selector: 'app-task',
  imports: [CommonModule, TaskListsComponent, TaskReportedListsComponent, TaskActionComponent],
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
