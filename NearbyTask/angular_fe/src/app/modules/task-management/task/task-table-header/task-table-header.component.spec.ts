import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskTableHeaderComponent } from './task-table-header.component';

describe('TaskTableHeaderComponent', () => {
  let component: TaskTableHeaderComponent;
  let fixture: ComponentFixture<TaskTableHeaderComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskTableHeaderComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TaskTableHeaderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
