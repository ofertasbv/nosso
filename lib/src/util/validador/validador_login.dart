import 'dart:async';

class LoginValidators {
  String validateEmail(String text) {
    if (text.isEmpty) {
      return "preencha o valor com email";
    }
    if (text.contains("@")) {
      return "email inválido";
    }
  }

  String validateSenha(String text) {
    if (text.isEmpty) {
      return "preencha o valor com senha";
    }
    if (text.length < 8) {
      return "a senha deve ter 8 caracteres";
    }
  }

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 8) {
        sink.add(password);
      } else {
        sink.addError("Senha inválida, deve conter pelo menos 8 caracteres");
      }
    },
  );
}
