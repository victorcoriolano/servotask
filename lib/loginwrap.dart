import 'package:flutter/material.dart';
import 'package:help/auth_service.dart';
import 'package:help/home_page.dart';
import 'package:help/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  get authService => AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;

          return Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Positioned(
                top: height * 0.1,
                left: width * 0.1,
                child: const Text(
                  'SERVOTASK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                  top: height * 0.2,
                  left: width / 2 - (width * 0.15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(width * 0.15),
                      ),
                      child: const Center(
                        child: Text(
                          "REGISTRAR",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                top: height * 0.5,
                left: width * 0.1,
                right: width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('E-mail:'),
                    SizedBox(height: height * 0.01),
                    Container(
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: 'Digite seu e-mail',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.6,
                left: width * 0.1,
                right: width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Senha:'),
                    SizedBox(height: height * 0.01),
                    Container(
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: 'Digite sua senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: height * 0.1,
                left: width / 2 - (width * 0.15),
                child: GestureDetector(
                  onTap: () {
                    String email = emailController.text;
                    String password = passwordController.text;

                    //login
                    _submitSignIn(email, password).then((success) {
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      } else {
                        SnackBar snackBar = const SnackBar(
                            content: Text('Email ou senha incorretos'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  },
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(height * 0.035),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ENTRAR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.login, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<bool> _submitSignIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      SnackBar snackBar =
          const SnackBar(content: Text('Please fill in all fields'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    } else {
      SnackBar snackBar =
          const SnackBar(content: Text('Entrando na sua conta...'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Future<bool> success;
      try {
        success = authService.login(email, password);
        if (await success) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
        return false;
      }
    }
  }
}
