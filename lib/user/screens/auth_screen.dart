import 'dart:math';

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

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final _form = GlobalKey<FormState>();
  late AnimationController _controller;
  late Animation<double> _animation;

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) return;

    _form.currentState!.save();

    final authNotifier = ref.read(authControllerProvider);

    try {
      if (_isLogin) {
        await authNotifier.signIn(_enteredEmail, _enteredPassword);
      } else {
        await authNotifier.signUp(
          _enteredEmail,
          _enteredPassword,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } catch (error) {
      if (mounted) ScaffoldMessenger.of(context).clearSnackBars();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    }
  }

  void _flipCard() {
    if (_controller.status != AnimationStatus.forward &&
        _controller.status != AnimationStatus.reverse) {
      if (_isLogin) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      setState(() {
        _isLogin = !_isLogin;
      });
    }
  }

  Widget _buildFront() {
    return _buildCard(isFront: true);
  }

  Widget _buildBack() {
    return _buildCard(isFront: false);
  }

  Widget _buildCard({required bool isFront}) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  validator: (email) => isValidEmail(email),
                  onSaved: (value) {
                    _enteredEmail = value!.trim();
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (password) => isValidPassword(password),
                  onFieldSubmitted: (_) => _submit(),
                  onSaved: (value) {
                    _enteredPassword = value!.trim();
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(isFront ? 'Login' : 'Signup'),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  iconAlignment:
                      isFront ? IconAlignment.end : IconAlignment.start,
                  onPressed: _flipCard,
                  label: Text(
                    isFront
                        ? 'Create new account'
                        : 'I already have an account',
                  ),
                  icon: RotatedBox(
                    quarterTurns: isFront ? 0 : 2,
                    child: Icon(Icons.arrow_right_alt),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.primary),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final isFront = _controller.value < 0.5;
                  final transform =
                      Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(pi * _animation.value);

                  return Transform(
                    transform: transform,
                    alignment: Alignment.center,
                    child:
                        isFront
                            ? _buildFront()
                            : Transform(
                              transform: Matrix4.identity()..rotateY(pi),
                              alignment: Alignment.center,
                              child: _buildBack(),
                            ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
