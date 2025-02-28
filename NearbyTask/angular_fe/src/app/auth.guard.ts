import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { SessionLocalStorage } from 'src/services/sessionStorage';
import { AuthService } from './services/auth.service';

export const authGuard: CanActivateFn = (route, state) => {
  const router = inject(Router);
  const session = inject(SessionLocalStorage);
  const authservice = inject(AuthService);

  const sessionData = session.getSession();
  // const sessionID = typeof sessionData === 'string' ? sessionData.trim() : JSON.stringify(sessionData).trim();

  // Get session data from localStorage
  const sessionFromStorage = sessionStorage.getItem('session') || '';

  // Clean both values
  // const cleanedSessionID = sessionID.replace(/^"|"$/g, '').trim();
  const cleanedStoredSessionID = sessionFromStorage.replace(/^"|"$/g, '').trim();

  console.log('Session ID:', sessionData);
  console.log('Session from Storage:', cleanedStoredSessionID);

  if (sessionData === cleanedStoredSessionID) {
    console.log('Match!');
    return true;
  } else {
    console.log('No match!');

    // Delay navigation to prevent immediate re-execution of authGuard
    if (sessionData) {
      console.log('From guard:', sessionData);
      authservice.logoutWithoutSession(cleanedStoredSessionID).subscribe({
        next: () => {
          setTimeout(() => {
            router.navigate(['/auth']);
          }, 100);

          return false;
        },
      });
    }

    setTimeout(() => {
      router.navigate(['/auth']);
    }, 100);

    return false;
  }
};
