import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TaskComponent } from './task/task.component';
import { TaskReportedListComponent } from './task/task-reported-list/task-reported-list.component';


const routes: Routes = [
  {
    path: '',
    component: TaskComponent,
    children: [
      { path: 'task-management', redirectTo: 'task-management', pathMatch: 'full' },
      { path: 'task-management', component: TaskComponent },
      { path: 'task-disable', component: TaskReportedListComponent },
      { path: '**', redirectTo: 'errors/404' },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class TaskRoutingModule {}
