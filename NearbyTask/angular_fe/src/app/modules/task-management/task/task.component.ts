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
  styleUrls: ['./task.component.css'] // Dapat plural
})
export class TaskComponent {
  currentTab: string = "showTaskList";

  changeTab(tabName: string) {
    this.currentTab = tabName;
  }
}
