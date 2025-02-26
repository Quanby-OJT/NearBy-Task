import { Component, EventEmitter, Output } from '@angular/core';

@Component({
  selector: 'app-task-list',
  imports: [],
  templateUrl: './task-list.component.html',
  styleUrl: './task-list.component.css'
})
export class TaskListComponent {
  @Output() changeTab = new EventEmitter<string>(); 

  onChangeTab(tabName: string) {
    this.changeTab.emit(tabName); 
  }
}
