import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { AngularSvgIconModule } from 'angular-svg-icon';

@Component({
  selector: 'app-task-table-content',
  standalone: true,
  imports: [AngularSvgIconModule, CommonModule],
  templateUrl: './task-table-content.component.html',
  styleUrl: './task-table-content.component.css'
})
export class TaskTableContentComponent {

currentTab : string = "showTasksList";

changeTab(tabName: string){
  this.currentTab = tabName;
}
}
