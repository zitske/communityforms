String getFirebaseAuthExceptions(String code) {
  switch (code) {
    case "INVALID_EMAIL":
      return "Email invalido";

    case "wrong-password":
      return "Senha errada";

    case "user-not-found":
      return "Usuario nao cadastrado";

    case "user-disabled":
      return "Usuario desativado";

    case "TOO_MANY_REQUESTS":
      return "Muitas tentativas. Tente mais tarde.";

    case "OPERATION_NOT_ALLOWED":
      return "Signing in with Email and Password is not enabled.";

    default:
      return 'Erro desconhecido gFAE';
  }
}
