import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vietour/core/common/widgets/loader.dart';
import 'package:vietour/core/theme/app_pallete.dart';
import 'package:vietour/core/utils/show_snackbar.dart';
import 'package:vietour/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:vietour/features/auth/presentation/pages/signup_page.dart';
import 'package:vietour/features/auth/presentation/widgets/auth_field.dart';
import 'package:vietour/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:vietour/features/blog/persentation/pages/blog_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static route() => MaterialPageRoute(
    builder: (context) => const LoginPage(),
  );

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                BlogPage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, //Ngang
                mainAxisAlignment:
                    MainAxisAlignment.center, //Dọc
                children: [
                  const Text(
                    'Let\'s Travel you in.',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (formKey.currentState!
                          .validate()) {
                        context.read<AuthBloc>().add(
                          AuthLogin(
                            email:
                                emailController.text.trim(),
                            password:
                                passwordController.text
                                    .trim(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        AuthGoogleSignIn(),
                      );
                    }, // Call the sign up bloc
                    child: Text('Sign in with Google'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(SignupPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style:
                            Theme.of(
                              context,
                            ).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color:
                                      AppPallete.gradient2,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
