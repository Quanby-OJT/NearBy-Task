import { validateLogin } from './../../../../../../../express_be/src/validator/authValidator';
import { NgClass, NgIf } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { AngularSvgIconModule } from 'angular-svg-icon';
import { ButtonComponent } from '../../../../shared/components/button/button.component';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrls: ['./sign-in.component.css'],
  imports: [FormsModule, ReactiveFormsModule, RouterLink, AngularSvgIconModule, NgIf, ButtonComponent, NgClass],
})
export class SignInComponent implements OnInit {
  form!: FormGroup;
  submitted = false;
  passwordTextType!: boolean;
  errorMessage: string | null = null;

  constructor(
    private readonly _formBuilder: FormBuilder,
    private readonly _router: Router,
    private authService: AuthService,
  ) {}

  onClick() {
    console.log('Button clicked');
  }

  ngOnInit(): void {
    this.form = this._formBuilder.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
    });
  }

  get f() {
    return this.form.controls;
  }

  togglePasswordTextType() {
    this.passwordTextType = !this.passwordTextType;
  }

  onSubmit() {
    this.submitted = true;

    const { email, password } = this.form.value;
    console.log('Email:', email, 'password:', password);
    this.login(email, password);
  }

  login(email: string, password: string) {
    if (this.authService.login(email, password)) {
      this._router.navigate(['/dashboard']);
    }

    this.errorMessage = 'Invalid email or password. Please try again.';
    this.form.reset();
    setTimeout(() => {
      this.errorMessage = null;
    }, 3000);
  }
}
