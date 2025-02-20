import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http'; // Import ito
import { UserService } from './user.service';

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css'],
  imports: [ReactiveFormsModule, HttpClientModule] // Dapat nandito ito
})
export class AppComponent {
  userForm: FormGroup;

  constructor(private fb: FormBuilder, private userService: UserService) {
    this.userForm = this.fb.group({
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
      confirmPassword: ['', Validators.required],
      profileImage: [null, Validators.required]
    });
  }

  onFileChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      this.userForm.patchValue({ profileImage: file });
      this.userForm.get('profileImage')?.updateValueAndValidity();
    }
  }

  submitForm() {
    if (this.userForm.valid) {
      const formData = new FormData();
      formData.append('first_name', this.userForm.value.firstName);
      formData.append('last_name', this.userForm.value.lastName);
      formData.append('email', this.userForm.value.email);
      formData.append('password', this.userForm.value.password);

      if (this.userForm.value.profileImage instanceof File) {
        formData.append('image', this.userForm.value.profileImage);
      }

      this.userService.registerUser(formData).subscribe({
        next: () => alert('User registered successfully!'),
        error: (error) => alert('Error: ' + error.message)
      });
    } else {
      alert('Please fill in all fields correctly.');
    }
  }
}
