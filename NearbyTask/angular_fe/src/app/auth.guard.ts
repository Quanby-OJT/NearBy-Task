import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';

export const authGuard: CanActivateFn = (route, state) => {
  const router = inject(Router);

  const isLoggedIn = !!localStorage.getItem('token');
  const userRole = localStorage.getItem('role');

  const validRole: any[] = route.data['role'];

  if (!isLoggedIn) {
    router.navigate(['/auth']);
    return false;
  }

  if (!validRole.includes(userRole)) {
    router.navigate(['/auth']);
    return false;
  }

  return true;
};
