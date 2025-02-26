import { Component, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'app-task-reported-list',
  imports: [],
  templateUrl: './task-reported-list.component.html',
  styleUrl: './task-reported-list.component.css'
})
export class TaskReportedListComponent {
  @Output() tabChange = new EventEmitter<string>();

changeTab(tabName: string){
  this.tabChange.emit(tabName);
}
}