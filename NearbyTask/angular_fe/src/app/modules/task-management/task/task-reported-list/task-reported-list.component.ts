import { Component, EventEmitter, Input, Output } from '@angular/core';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { TaskService } from 'src/app/services/task.service';
@Component({
  selector: 'app-task-reported-list',
  standalone: true, 
  imports: [AngularSvgIconModule],
  templateUrl: './task-reported-list.component.html',
  styleUrls: ['./task-reported-list.component.css'] 
})
export class TaskReportedListComponent {
  @Input() task: any;
  @Output() tabChange = new EventEmitter<string>();

  changeTab(tabName: string) {
    this.tabChange.emit(tabName);
  }

  
  }