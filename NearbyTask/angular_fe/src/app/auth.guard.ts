import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { SessionLocalStorage } from 'src/services/sessionStorage';

export const authGuard: CanActivateFn = (route, state) => {
  const router = inject(Router);
  const session = inject(SessionLocalStorage);

  const sessionData = session.getSession();
  const sessionID = typeof sessionData === 'string' ? sessionData.trim() : JSON.stringify(sessionData).trim();

  // Get session data from localStorage
  const sessionFromStorage = sessionStorage.getItem('session') || '';

  // Clean both values
  const cleanedSessionID = sessionID.replace(/^"|"$/g, '').trim();
  const cleanedStoredSessionID = sessionFromStorage.replace(/^"|"$/g, '').trim();

  console.log('Session ID:', cleanedSessionID);
  console.log('Session from Storage:', cleanedStoredSessionID);

  if (cleanedSessionID === cleanedStoredSessionID) {
    console.log('Match!');
    return true; // Allow access
  } else {
    console.log('No match!');

    // Delay navigation to prevent immediate re-execution of authGuard
    setTimeout(() => {
      router.navigate(['/auth']);
    }, 100);

    return false; // Block access
  }
};
