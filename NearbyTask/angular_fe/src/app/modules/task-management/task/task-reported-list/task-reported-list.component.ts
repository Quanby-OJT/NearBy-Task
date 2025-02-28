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

  constructor(private taskService: TaskService) {}
  disableTask() {
    if (this.task?.job_post_id) {
      this.taskService.disableTask(this.task.job_post_id).subscribe({
        next: () => {
          this.changeTab('showTaskList'); // Navigate back after success
        },
        error: (err) => console.error('Disable failed:', err)
      });
    }
  }
}