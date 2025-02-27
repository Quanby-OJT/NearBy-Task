import { Component, EventEmitter, Input, Output } from '@angular/core';

@Component({
  selector: 'app-task-reported-list',
  standalone: true, 
  imports: [],
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