import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskReportedListsComponent } from './task-reported-lists.component';

describe('TaskReportedListsComponent', () => {
  let component: TaskReportedListsComponent;
  let fixture: ComponentFixture<TaskReportedListsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskReportedListsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TaskReportedListsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
