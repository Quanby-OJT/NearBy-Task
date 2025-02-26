import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskTableActionComponent } from './task-table-action.component';

describe('TaskTableActionComponent', () => {
  let component: TaskTableActionComponent;
  let fixture: ComponentFixture<TaskTableActionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskTableActionComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TaskTableActionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
