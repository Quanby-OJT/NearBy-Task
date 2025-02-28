import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { TaskReportedListComponent } from './task-reported-list/task-reported-list.component';
import { TaskListComponent } from './task-list/task-list.component';

@Component({
  selector: 'app-task',
  standalone: true, 
  imports: [
    CommonModule,
    AngularSvgIconModule,
    TaskListComponent,
    TaskReportedListComponent,
  ],
  templateUrl: './task.component.html',
  styleUrls: ['./task.component.css']
})
export class TaskComponent {
  currentTab: string = "showTaskList";
  selectedTask: any = null;

  changeTab(event: { tabName: string, task: any } | string) {
    if (typeof event === 'string') {
      // Handle case where only the tabName is passed (from TaskReportedListComponent)
      this.currentTab = event;
    } else {
      // Handle case where both tabName and task are passed (from TaskListComponent)
      this.currentTab = event.tabName;
      this.selectedTask = event.task;
    }
  }
}