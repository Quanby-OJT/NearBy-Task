import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskTableContentComponent } from './task-table-content.component';

describe('TaskTableContentComponent', () => {
  let component: TaskTableContentComponent;
  let fixture: ComponentFixture<TaskTableContentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskTableContentComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TaskTableContentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
