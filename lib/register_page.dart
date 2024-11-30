import 'package:flutter/material.dart';
import 'package:help/auth_service.dart';
import 'package:help/home_page.dart';
import 'package:help/loginwrap.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  AuthService get authService => AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;

          var passwordController = TextEditingController();
          var nameController = TextEditingController();
          var emailController = TextEditingController();
          return Stack(
            children: [
              Container(color: Colors.white),
              Positioned(
                top: height * 0.1,
                left: width * 0.1,
                child: const Text(
                  'Registrar Conta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Ícone Circular
              Positioned(
                top: height * 0.2,
                left: width / 2 - (width * 0.15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage(
                                  title: 'Bem-vindo de volta',
                                )));
                  },
                  child: Container(
                      width: width * 0.3,
                      height: width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(width * 0.15),
                      ),
                      child: const Center(child: Text("Já tenho conta"))),
                ),
              ),
              Positioned(
                top: height * 0.45,
                left: width * 0.1,
                right: width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nome:'),
                    SizedBox(height: height * 0.01),
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        hintText: 'Digite seu nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.55,
                left: width * 0.1,
                right: width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('E-mail:'),
                    SizedBox(height: height * 0.01),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        hintText: 'Digite seu e-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.65,
                left: width * 0.1,
                right: width * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Senha:'),
                    SizedBox(height: height * 0.01),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade300,
                        hintText: 'Crie uma senha',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
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
                  // Ação ao clicar no botão de registrar
                  onTap: () async {
                    Future<bool> success = authService.register(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        nameController.text.trim());
                    if (await success) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erro ao criar conta')));
                    }
                  },
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(height * 0.035),
                    ),
                    child: const Center(
                      child: Text(
                        'REGISTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
}
