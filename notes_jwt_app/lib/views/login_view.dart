import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'home_view.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  // LOGIN
  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = await authProvider.login(
      _emailController.text,

      _passwordController.text,
    );

    // SUCCESS
    if (success) {
      if (mounted) {
        Navigator.pushReplacement(
          context,

          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }
    }
    // FAILED
    else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Login gagal! '
              'Cek email & password',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login Notes App')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            // EMAIL
            TextField(
              controller: _emailController,

              decoration: const InputDecoration(
                labelText: 'Email',

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // PASSWORD
            TextField(
              controller: _passwordController,

              obscureText: true,

              decoration: const InputDecoration(
                labelText: 'Password',

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            // LOADING
            authProvider.isLoading
                ? const CircularProgressIndicator()
                // BUTTON LOGIN
                : SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      onPressed: _submit,

                      child: const Text('Masuk'),
                    ),
                  ),

            const SizedBox(height: 16),

            // GO REGISTER
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,

                  MaterialPageRoute(builder: (_) => const RegisterView()),
                );
              },

              child: const Text('Belum punya akun? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
