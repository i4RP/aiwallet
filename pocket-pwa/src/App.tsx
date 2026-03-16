import './App.css';
import { useAuth } from './hooks/useAuth';
import { WelcomeView } from './components/WelcomeView';
import { LoginSheet } from './components/auth/LoginSheet';
import { MainTabView } from './components/main/MainTabView';

function App() {
  const auth = useAuth();

  if (auth.authState === 'authenticated') {
    return <MainTabView onLogout={auth.logout} />;
  }

  return (
    <>
      <WelcomeView onGetStarted={auth.showLogin} />
      {auth.showLoginSheet && (
        <LoginSheet
          currentPage={auth.currentPage}
          emailInput={auth.emailInput}
          isEmailValid={auth.isEmailValid}
          onEmailChange={(email) => {
            auth.setEmailInput(email);
            auth.validateEmail(email);
          }}
          onDismiss={auth.dismissLogin}
          onMockLogin={auth.mockLogin}
          onNavigateToOtherSocials={auth.navigateToOtherSocials}
          onNavigateToWalletSelection={auth.navigateToWalletSelection}
          onNavigateBack={auth.navigateBack}
        />
      )}
    </>
  );
}

export default App;
