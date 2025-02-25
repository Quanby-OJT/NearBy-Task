import { NgClass, NgIf } from '@angular/common';
<<<<<<< HEAD
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterOutlet } from '@angular/router';
=======
import { Component, numberAttribute } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterOutlet } from '@angular/router';
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
import { UserAccountService } from 'src/app/services/userAccount';
import { ButtonComponent } from 'src/app/shared/components/button/button.component';
import Swal from 'sweetalert2';

@Component({
  selector: 'app-update-user',
  imports: [RouterOutlet, ReactiveFormsModule, NgIf, ButtonComponent, NgClass],
  templateUrl: './update-user.component.html',
  styleUrl: './update-user.component.css',
})
export class UpdateUserComponent {
  form!: FormGroup;
  submitted = false;
  imagePreview: File | null = null;
  duplicateEmailError: any = null;
  success_message: any = null;
<<<<<<< HEAD

  constructor(
    private _formBuilder: FormBuilder,
    private UserAccountService: UserAccountService,
    private router: Router,
=======
  userId: string | null = null;
  imageUrl: string | null = null;
  userData: any = null;
  first_name: string = '';
  profileImage: string | null = null;

  constructor(
    private _formBuilder: FormBuilder,
    private userAccountService: UserAccountService,
    private router: Router,
    private route: ActivatedRoute,
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
  ) {}

  ngOnInit(): void {
    this.formValidation();
<<<<<<< HEAD
=======
    this.userId = this.route.snapshot.paramMap.get('id');
    if (this.userId) {
      this.loadUserData();
    }
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
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
<<<<<<< HEAD
      profileImage: ['', Validators.required],
=======
    });
  }
  loadUserData(): void {
    const userId = Number(this.userId);

    this.userAccountService.getUserById(userId).subscribe({
      next: (response: any) => {
        this.userData = response.user;
        this.form.patchValue({
          firstName: response.user.first_name,
          middleName: response.user.middle_name,
          lastName: response.user.last_name,
          bday: response.user.birthdate,
          userRole: response.user.user_role,
          email: response.user.email,
          status: response.user.acc_status,
        });
        this.profileImage = response.user.image_link;
      },
      error: (error: any) => {
        console.error('Error fetching user data:', error);
      },
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
    });
  }

  onFileChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
<<<<<<< HEAD
      this.imagePreview = input.files[0];
=======
      const file = input.files[0];
      this.imagePreview = file;

      const reader = new FileReader();
      reader.onload = () => {
        this.imageUrl = reader.result as string;
      };
      reader.readAsDataURL(file);
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
    }
  }

  get f() {
    return this.form.controls;
  }

  onSubmit() {
    this.submitted = true;

    if (this.form.invalid) {
<<<<<<< HEAD
      // console.log('Form is invalid. Please check the errors.');
=======
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
      Swal.fire({
        icon: 'error',
        title: 'Validation Error',
        text: 'Please check the form for errors!',
      });
      return;
    }

<<<<<<< HEAD
    console.log('Form Submitted Successfully!');
    console.log('Form Values:', this.form.value);

    const formData = new FormData();

=======
    const userId = Number(this.userId);
    const email = this.form.value.email;
    this.updateUserAccount(userId);
  }

  updateUserAccount(userId: number): void {
    const formData = new FormData();
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
    formData.append('first_name', this.form.value.firstName);
    formData.append('middle_name', this.form.value.middleName);
    formData.append('last_name', this.form.value.lastName);
    formData.append('birthday', this.form.value.bday);
    formData.append('email', this.form.value.email);
    formData.append('acc_status', this.form.value.status);
    formData.append('user_role', this.form.value.userRole);
<<<<<<< HEAD
    if (this.imagePreview) {
      formData.append('image', this.imagePreview);
    }
    this.UserAccountService.insertUserAccount(formData).subscribe(
      (response) => {
        // console.log('User added successfully:', response);
        // console.log(formData);
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'User registered successfully!',
        });

        this.form.reset();
        this.submitted = false;
      },
      (error: any) => {
        // console.error('Error adding user:', error);
        this.duplicateEmailError = 'Email already exists';
        Swal.fire({
          icon: 'error',
          title: 'Registration Failed',
          text: 'Email already exists. Please use a different email.',
=======

    if (this.imagePreview) {
      formData.append('image', this.imagePreview, this.imagePreview.name);
    }

    // for (const [key, value] of (formData as any).entries()) {
    //   console.log(`${key}:`, value);
    // }

    this.userAccountService.updateUserAccount(userId, formData).subscribe(
      (response) => {
        Swal.fire({
          icon: 'success',
          title: 'Success',
          text: 'User updated successfully!',
        }).then(() => {
          this.router.navigate(['user-management']);
        });
      },

      (error) => {
        Swal.fire({
          icon: 'error',
          title: 'Update Failed',
          text: error.error?.error,
>>>>>>> df973ae4ff448f3ff020ccef71d20a44589e69b3
        });
      },
    );
  }

  navigateToUsermanagement(): void {
    this.router.navigate(['user-management']);
  }
}
