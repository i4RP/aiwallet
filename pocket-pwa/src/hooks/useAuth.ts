import { useState, useCallback } from 'react';
import type { AuthState, LoginPage } from '../types';

export function useAuth() {
  const [authState, setAuthState] = useState<AuthState>('unauthenticated');
  const [showLoginSheet, setShowLoginSheet] = useState(false);
  const [currentPage, setCurrentPage] = useState<LoginPage>('main');
  const [emailInput, setEmailInput] = useState('');
  const [isEmailValid, setIsEmailValid] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const validateEmail = useCallback((email: string) => {
    const regex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
    setIsEmailValid(regex.test(email));
  }, []);

  const showLogin = useCallback(() => {
    setShowLoginSheet(true);
    setCurrentPage('main');
  }, []);

  const dismissLogin = useCallback(() => {
    setShowLoginSheet(false);
    setCurrentPage('main');
    setEmailInput('');
    setIsEmailValid(false);
  }, []);

  const navigateToOtherSocials = useCallback(() => setCurrentPage('otherSocials'), []);
  const navigateToWalletSelection = useCallback(() => setCurrentPage('walletSelection'), []);
  const navigateBack = useCallback(() => setCurrentPage('main'), []);

  const mockLogin = useCallback(() => {
    setIsLoading(true);
    setTimeout(() => {
      setIsLoading(false);
      setShowLoginSheet(false);
      setAuthState('authenticated');
    }, 800);
  }, []);

  const logout = useCallback(() => {
    setAuthState('unauthenticated');
    setEmailInput('');
    setIsEmailValid(false);
  }, []);

  return {
    authState, showLoginSheet, currentPage, emailInput, isEmailValid, isLoading,
    setEmailInput, validateEmail, showLogin, dismissLogin,
    navigateToOtherSocials, navigateToWalletSelection, navigateBack,
    mockLogin, logout,
  };
}
