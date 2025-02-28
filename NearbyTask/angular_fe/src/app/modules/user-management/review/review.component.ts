import { NgClass, NgIf } from '@angular/common';
import { Component, Input, numberAttribute } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { ActivatedRoute, Router, RouterOutlet } from '@angular/router';
import { UserAccountService } from 'src/app/services/userAccount';
import { ButtonComponent } from 'src/app/shared/components/button/button.component';
import Swal from 'sweetalert2';
import { UsersComponent } from '../users/users.component';

@Component({
  selector: 'app-review',
  imports: [ButtonComponent, RouterOutlet, ReactiveFormsModule, NgIf, ButtonComponent, NgClass],
  templateUrl: './review.component.html',
  styleUrl: './review.component.css',
})
export class ReviewComponent {
  @Input() userId: Number | null = null;
  form!: FormGroup;
  submitted = false;
  imagePreview: File | null = null;
  duplicateEmailError: any = null;
  success_message: any = null;
  imageUrl: string | null = null;
  userData: any = null;
  first_name: string = '';
  profileImage: string | null = null;
  isDisabled: boolean = true;

  constructor(
    private _formBuilder: FormBuilder,
    private userAccountService: UserAccountService,
    private router: Router,
    private route: ActivatedRoute,
    private usersComponent: UsersComponent,
  ) {}

  ngOnInit(): void {
    this.formValidation();
    if (this.userId) {
      this.loadUserData();
    }

    console.log('Loading');
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
    });
  }
  loadUserData(): void {
    // const userId = Number(this.userId);
    if (!this.userId) return;

    this.userAccountService.getUserById(this.userId).subscribe({
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
    });
  }

  onFileChange(event: Event) {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      this.imagePreview = file;

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

    const userId = Number(this.userId);
    const email = this.form.value.email;
    this.updateUserAccount(userId);
  }

  updateUserAccount(userId: number): void {
    const formData = new FormData();
    formData.append('first_name', this.form.value.firstName);
    formData.append('middle_name', this.form.value.middleName);
    formData.append('last_name', this.form.value.lastName);
    formData.append('birthday', this.form.value.bday);
    formData.append('email', this.form.value.email);
    formData.append('acc_status', this.form.value.status);
    formData.append('user_role', this.form.value.userRole);

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
          setTimeout(() => {
            window.location.reload();
          }, 100);
        });
      },

      (error) => {
        Swal.fire({
          icon: 'error',
          title: 'Update Failed',
          text: error.error?.error,
        });
      },
    );
  }

  navigateToUsermanagement(): void {
    this.usersComponent.changeTabToreview(false, 123);
  }
}
