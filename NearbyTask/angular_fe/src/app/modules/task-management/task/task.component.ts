import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { TaskTableContentComponent } from './task-table-content/task-table-content.component';
import { TaskTableActionComponent } from './task-table-action/task-table-action.component';
import { TaskTableHeaderComponent } from './task-table-header/task-table-header.component';
import { TaskTableFooterComponent } from './task-table-footer/task-table-footer.component';

@Component({
  selector: 'app-task',
  imports: [
    CommonModule,
    TaskTableContentComponent,
    TaskTableActionComponent,
    TaskTableHeaderComponent,  
    TaskTableFooterComponent
  ],
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
