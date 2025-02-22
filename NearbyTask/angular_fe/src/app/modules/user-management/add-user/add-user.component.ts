import { NgClass, NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { RouterOutlet } from '@angular/router';
import { ButtonComponent } from 'src/app/shared/components/button/button.component';

@Component({
  selector: 'app-add-user',
  imports: [RouterOutlet, ReactiveFormsModule, NgIf, ButtonComponent, NgClass],
  templateUrl: './add-user.component.html',
  styleUrl: './add-user.component.css',
})
export class AddUserComponent {
  form!: FormGroup;
  submitted = false;
  imagePreview: string | ArrayBuffer | null = null;

  constructor(private _formBuilder: FormBuilder) {}

  ngOnInit(): void {
    this.form = this._formBuilder.group({
      firstName: ['', Validators.required],
      middleName: [''],
      lastName: ['', Validators.required],
      status: ['', Validators.required],
      userRole: ['', Validators.required],
      bday: ['', Validators.required],
    });
  }

  onFileChange(event: any) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e: ProgressEvent<FileReader>) => {
        this.imagePreview = e.target?.result as string | ArrayBuffer;
      };
      reader.readAsDataURL(file);
    }
  }

  get f() {
    return this.form.controls;
  }

  onSubmit() {
    this.submitted = true;

    if (this.form.invalid) {
      console.log('Form is invalid. Please check the errors.');
      return;
    }

    console.log('Form Submitted Successfully!');
    console.log('Form Values:', this.form.value);
  }
}
