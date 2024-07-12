import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "../components/login_button.dart";
import "../components/my_text_field.dart";
import "forgot_password.dart";
import "register_page.dart";
import "shop_page.dart";

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShopPage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title: Text(message));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: Color.fromARGB(0, 246, 31, 31),
            elevation: 0),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              const SizedBox(height: 50),
              //logo
              Image.asset("logo.png", height: 100, width: 100),

              const SizedBox(height: 50),

              Text("Que bom que você voltou!",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16)),
              const SizedBox(height: 25),

              //campo de usuário
              MyTextField(
                  controller: emailController,
                  hintText: "E-mail",
                  obscureText: false),
              const SizedBox(height: 10),
              //campo de senha
              MyTextField(
                  controller: passwordController,
                  hintText: "Senha",
                  obscureText: true),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ForgotPasswordPage();
                        }));
                      },
                      child: Text("Esqueceu a senha?",
                          style: TextStyle(color: Color.fromARGB(255, 240, 17, 17))),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25),
              //botão login
              LoginButton(onTap: signUserIn, text: "Entrar"),
              const SizedBox(height: 25),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Color.fromARGB(255, 10, 10, 10),
                    )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("ou",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary))),
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ))
                  ])),
              const SizedBox(height: 25),
              const SizedBox(height: 50),
              Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Ainda não possui uma conta?",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary)),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          child: const Text("Registre-se",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        )
                      ]))
            ])))));
  }
}
