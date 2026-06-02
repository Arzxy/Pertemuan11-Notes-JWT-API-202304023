import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    bool success = await authProvider.register(
      _nameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Register telah berhasil')),
        );

        Navigator.pushReplacement(
          context,

          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Register telah gagal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register Akun')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: _nameController,

              decoration: const InputDecoration(labelText: 'Nama'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _emailController,

              decoration: const InputDecoration(labelText: 'Email'),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: _passwordController,

              obscureText: true,

              decoration: const InputDecoration(labelText: 'Password'),
            ),

            const SizedBox(height: 24),

            authProvider.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submit,

                    child: const Text('Register'),
                  ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,

                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              },

              child: const Text('Sudah punya akun? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
