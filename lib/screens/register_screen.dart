import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  final void Function()? onTap;

  const RegisterScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: BlocProvider(
          create: (context) => AuthBloc(context.read<AuthService>()),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Icon(
                      Icons.message,
                      size: 100,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      "Let's create an account for you!",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            MyTextField(
                              controller: TextEditingController(text: state.email),
                              hintText: "Email",
                              onChanged: (email) =>
                                  context.read<AuthBloc>().add(EmailChanged(email)),
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: TextEditingController(text: state.password),
                              hintText: "Password",
                              obscureText: true,
                              onChanged: (password) =>
                                  context.read<AuthBloc>().add(PasswordChanged(password)),
                            ),
                            const SizedBox(height: 10),
                            MyTextField(
                              controller: TextEditingController(text: state.confirmPassword),
                              hintText: "Confirm password",
                              obscureText: true,
                              onChanged: (confirmPassword) => context
                                  .read<AuthBloc>()
                                  .add(ConfirmPasswordChanged(confirmPassword)),
                            ),
                            const SizedBox(height: 25),
                            if (state.isSubmitting)
                              const CircularProgressIndicator(),
                            if (!state.isSubmitting)
                              CustomButton(
                                onTap: () =>
                                    context.read<AuthBloc>().add(const SignUpSubmitted()),
                                title: "Sign Up",
                              ),
                            if (!state.passwordsMatch)
                              const Text(
                                "Passwords don't match!",
                                style: TextStyle(color: Colors.red),
                              ),
                            if (state.isFailure)
                              const Text(
                                "Registration failed. Please try again.",
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already a member?"),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: onTap,
                          child: const Text(
                            "Login now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
