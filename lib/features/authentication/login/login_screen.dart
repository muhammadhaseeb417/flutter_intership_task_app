import 'package:flutter/material.dart';
import 'package:flutter_intership_task_app/consts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/custom_textfield.dart';
import '../../../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: -80,
              top: -100,
              child: Container(
                width: 318,
                height: 312,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: const Color(0xFF2E7758),
                ),
              ),
            ),
            Positioned(
              right: -170,
              top: -30,
              child: Container(
                width: 302,
                height: 297,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(500),
                  color: const Color(0xFF52BF90),
                ),
              ),
            ),
            Positioned(
                top: 80,
                right: 30,
                child: SvgPicture.asset("assets/icons/Frame.svg")),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  const Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  // SvgPicture.asset(
                  //     "assets/Green_Simple_Healthy_Restaurant_Logo.svg"),
                  Image.asset(
                    "assets/logo.jpg",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Please Sign in or Sign Up in CarbonCap",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const LoginForm(),
                  const SizedBox(
                    height: 20,
                  ),
                  const BottomIcons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomIcons extends StatelessWidget {
  const BottomIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SvgPicture.asset("assets/icons/share.svg"),
            const Text('Share'),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Image.asset(
          "assets/icons/facebook.jpg",
          height: 65,
          width: 65,
        ),
        Image.asset(
          "assets/icons/linkedin.jpg",
          height: 65,
          width: 65,
        ),
        Image.asset(
          "assets/icons/whatsapp.jpg",
          height: 65,
          width: 65,
        ),
        Image.asset(
          "assets/icons/instagram.jpg",
          height: 65,
          width: 65,
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    String? email;

    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          CustomTextfield(
            height: 30,
            hintText: 'Enter Your Email',
            onSaved: (value) {
              email = value;
            },
            inputType: 'Email',
            validatorRegExp: EMAIL_VALIDATION_REGEX,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextfield(
            height: 30,
            hintText: 'Enter Your Password',
            isPassword: true,
            onSaved: (value) {},
            inputType: 'Password',
            validatorRegExp: PASSWORD_VALIDATION_REGEX,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('Remember Password'),
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  )
                ],
              ),
              const Text("Forget Password"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 57,
            width: 257,
            child: ElevatedButton(
              onPressed: () async {
                if (_loginFormKey.currentState?.validate() ?? false) {
                  _loginFormKey.currentState?.save();

                  // Call the login API
                  final result = await AuthService.login(email!);

                  if (result["success"]) {
                    // Get SharedPreferences instance
                    final prefs = await SharedPreferences.getInstance();

                    // Set 'isLoggedIn' to true
                    await prefs.setBool('isLoggedIn', true);

                    // If login is successful, navigate to the next screen (e.g., home)
                    context.pushReplacement(
                        "/"); // Replace "/" with your desired route, e.g., "/home"
                  } else {
                    // If login failed, show the error message in SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(result["message"] ?? "Login failed")),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52BF90),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "New in CarbonCap? ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push("/signup");
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2E7758),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
