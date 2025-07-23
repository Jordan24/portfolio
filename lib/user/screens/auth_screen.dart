import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/user/providers/auth_provider.dart';
import 'package:portfolio/user/validators/email_validator.dart';
import 'package:portfolio/user/validators/password_validator.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    final authNotifier = ref.read(authProvider.notifier);

    try {
      if (_isLogin) {
        await authNotifier.signIn(_enteredEmail, _enteredPassword);
      } else {
        await authNotifier.signUp(_enteredEmail, _enteredPassword);
      }
      if (mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      if (mounted) ScaffoldMessenger.of(context).clearSnackBars();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message!)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 12,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email Address',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator:
                                (email) =>
                                    isValidEmail(email)
                                        ? null
                                        : 'Please enter a valid email address.',
                            onSaved: (value) {
                              _enteredEmail = value!.trim();
                            },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            validator:
                                (password) =>
                                    isValidPassword(password)
                                        ? null
                                        : 'Password must be at least 8 characters long.',
                            onSaved: (value) {
                              _enteredPassword = value!.trim();
                            },
                          ),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? 'Create new account'
                                  : 'I already have an account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
