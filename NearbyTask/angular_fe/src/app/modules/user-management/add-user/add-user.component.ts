import { UserAccountService } from './../../../services/userAccount';
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
  imagePreview: File | null = null;

  constructor(private _formBuilder: FormBuilder, private UserAccountService: UserAccountService) {}

  ngOnInit(): void {
    this.formValidation();
  }

  formValidation(): void {
    this.form = this._formBuilder.group({
      firstName: ['', Validators.required],
      middleName: [''],
      lastName: ['', Validators.required],
      status: ['', Validators.required],
      userRole: ['', Validators.required],
      email: ['', Validators.required],
      bday: ['', Validators.required],
      profileImage: ['', Validators.required],
    });
  }

  onFileChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      this.imagePreview = input.files[0];
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

    const formData = new FormData();

    formData.append('first_name', this.form.value.firstName);
    formData.append('middle_name', this.form.value.middleName);
    formData.append('last_name', this.form.value.lastName);
    formData.append('birthday', this.form.value.bday);
    formData.append('email', this.form.value.email);
    formData.append('acc_status', this.form.value.status);
    formData.append('user_role', 'true');
    if (this.imagePreview) {
      formData.append('image', this.imagePreview);
    }

    this.UserAccountService.insertUserAccount(formData).subscribe(
      (response) => {
        console.log('User added successfully:', response);
        console.log(formData);

        this.form.reset();
      },
      (error: any) => {
        console.error('Error adding user:', error);
      },
    );
  }
}
