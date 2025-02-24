import { NgClass, NgIf } from '@angular/common';
import { Component } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterOutlet } from '@angular/router';
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
  userId: string | null = null;
  imageUrl: string | null = null;

  constructor(
    private _formBuilder: FormBuilder,
    private userAccountService: UserAccountService,
    private router: Router,
    private route: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.formValidation();
    this.userId = this.route.snapshot.paramMap.get('id');
    if (this.userId) {
      this.loadUserData();
    }
  }

  formValidation(): void {
    this.form = this._formBuilder.group({
      firstName: ['', Validators.required],
      middleName: [''],
      lastName: ['', Validators.required],
      status: ['', Validators.required],
      userRole: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      bday: ['', Validators.required],
      profileImage: [''],
    });
  }
  loadUserData(): void {
    const userId = Number(this.userId);

    this.userAccountService.getUserById(userId).subscribe({
      next: (userData) => {
        if (userData) {
          this.form.patchValue({
            firstName: userData.first_name,
            middleName: userData.middle_name || '',
            lastName: userData.last_name,
            status: userData.acc_status,
            userRole: userData.user_role,
            email: userData.email,
            bday: userData.birthday,
          });

          this.imagePreview = userData.profile_image ? userData.profile_image : 'https://via.placeholder.com/150';
          console.log('User Data Loaded:', userData);
        } else {
          console.warn('User data is empty or undefined.');
        }
      },
      error: (error) => {
        console.error('Error loading user data:', error);
      },
    });
  }

  onFileChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      this.form.patchValue({ profileImage: file });

      // Convert image file to Base64 preview
      const reader = new FileReader();
      reader.onload = () => {
        this.imageUrl = reader.result as string;
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
      Swal.fire({
        icon: 'error',
        title: 'Validation Error',
        text: 'Please check the form for errors!',
      });
      return;
    }

    const formData = new FormData();
    formData.append('first_name', this.form.value.firstName);
    formData.append('middle_name', this.form.value.middleName);
    formData.append('last_name', this.form.value.lastName);
    formData.append('birthday', this.form.value.bday);
    formData.append('email', this.form.value.email);
    formData.append('acc_status', this.form.value.status);
    formData.append('user_role', this.form.value.userRole);
    if (this.imagePreview) {
      formData.append('image', this.imagePreview);
    }

    // this.userAccountService.updateUserAccount(this.userId, formData).subscribe(
    //   (response) => {
    //     Swal.fire({
    //       icon: 'success',
    //       title: 'Success',
    //       text: 'User updated successfully!',
    //     });
    //     this.router.navigate(['user-management']);
    //   },
    //   (error: any) => {
    //     this.duplicateEmailError = 'Email already exists';
    //     Swal.fire({
    //       icon: 'error',
    //       title: 'Update Failed',
    //       text: 'Email already exists. Please use a different email.',
    //     });
    //   },
    // );
  }

  navigateToUsermanagement(): void {
    this.router.navigate(['user-management']);
  }
}
