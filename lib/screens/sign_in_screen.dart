import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes_app/screens/home_screen.dart';

import '../constant.dart';
import '../widgets/custom_button.dart';


class SignIn extends StatelessWidget {
  static String routeName = '/sign_in';

  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SignInBody(),
    );
  }
}

class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 27,
                  ),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Sign In with your email or password \nor continue with social media',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  const SignInForm(),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildSocialCard(
                          image: 'assets/icons/google.svg', press: () {}),
                      buildSocialCard(
                          image: 'assets/icons/apple-logo.svg', press: () {}),
                      buildSocialCard(
                          image: 'assets/icons/twitter-logo.svg', press: () {}),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // Spacer(flex: 2,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSocialCard(
      {required String image, required VoidCallback press}) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200,
          ),
          child: SvgPicture.asset(image),
        ),
      ),
    );
  }
}

class FormError extends StatelessWidget {
  final List<String> errors;

  const FormError({Key? key, required this.errors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          errors.length,
              (index) => Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 15,
                color: primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(errors[index])
            ],
          ),
        ),
      ],
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String? password;
  String? email;
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newEmail) => email = newEmail,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(emailNull)) {
                  setState(() {
                    errors.remove(emailNull);
                  });
                } else if (emailValidator.hasMatch(value) &&
                    errors.contains(invalidEmail)) {
                  setState(() {
                    errors.remove(invalidEmail);
                  });
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty && !errors.contains(emailNull)) {
                  setState(() {
                    errors.add(emailNull);
                  });
                } else if (!emailValidator.hasMatch(value) &&
                    !errors.contains(invalidEmail)) {
                  setState(() {
                    errors.add(invalidEmail);
                  });
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  suffixIcon: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Icon(Icons.email_rounded),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onSaved: (newPassword) => password = newPassword,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(passwordNull)) {
                  setState(() {
                    errors.remove(passwordNull);
                  });
                } else if (value.length >= 8 &&
                    errors.contains(passwordTooShort)) {
                  setState(() {
                    errors.remove(passwordTooShort);
                  });
                }
                return;
              },
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty && !errors.contains(passwordNull)) {
                  setState(() {
                    errors.add(passwordNull);
                  });
                } else if (value.length < 8 &&
                    !errors.contains(passwordTooShort)) {
                  setState(() {
                    errors.add(passwordTooShort);
                  });
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                  child: Icon(Icons.lock_rounded),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FormError(
              errors: errors,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: primaryColor,
                  value: remember,
                  onChanged: (value) {
                    setState(
                          () {
                        remember = value!;
                      },
                    );
                  },
                ),
                const Text('Remember me'),
                const Spacer(),
                GestureDetector(
                  onTap: (){},
                  child: const Text('Forgot Password',
                      style: TextStyle(decoration: TextDecoration.underline)),
                )
              ],
            ),
            const SizedBox(height: 30,),
            DefaultButton(
                text: 'Continue',
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                })
          ],
        ),
      ),
    );
  }
}
