import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TaskTableFooterComponent } from './task-table-footer.component';

describe('TaskTableFooterComponent', () => {
  let component: TaskTableFooterComponent;
  let fixture: ComponentFixture<TaskTableFooterComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TaskTableFooterComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(TaskTableFooterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
