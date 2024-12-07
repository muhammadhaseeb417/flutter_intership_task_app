import 'package:flutter/material.dart';
import 'package:flutter_intership_task_app/commons/custom_textfield.dart';
import 'package:flutter_intership_task_app/consts.dart';
import 'package:flutter_intership_task_app/services/auth_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/backIcon.svg"),
          onPressed: () {
            // Add your back button logic here
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.jpg"),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _signFormKey = GlobalKey<FormState>();
    String? firstName, email, password, confirmPassword, phoneNumber;

    return Form(
      key: _signFormKey,
      child: Column(
        children: [
          CustomTextfield(
            hintText: "First Name*",
            onSaved: (value) {
              firstName = value;
            },
            inputType: 'first name',
            validatorRegExp: FIRST_NAME_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Last Name*",
            onSaved: (value) {},
            inputType: 'Last Name',
            validatorRegExp: LAST_NAME_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Enter Your Email*",
            onSaved: (value) {
              email = value;
            },
            inputType: 'Email',
            validatorRegExp: EMAIL_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Enter Your Phone Number*",
            onSaved: (value) {
              phoneNumber = value;
            },
            inputType: 'Phone Number',
            validatorRegExp: PHONE_NUMBER_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Enter Your Address*",
            onSaved: (value) {},
            inputType: 'Address',
            validatorRegExp: ADDRESS_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Gender*",
            inputType: '',
            onSaved: (value) {},
            validatorRegExp: GENDER_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Create Your Password*",
            isPassword: true,
            inputType: 'Password',
            onSaved: (value) {
              password = value;
            },
            validatorRegExp: PASSWORD_VALIDATION_REGEX,
          ),
          const SizedBox(height: 20),
          CustomTextfield(
            hintText: "Confirm Password*",
            isPassword: true,
            onSaved: (value) {
              confirmPassword = value;
            },
            inputType: 'Password',
            validatorRegExp: PASSWORD_VALIDATION_REGEX,
          ),
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              const Text("I agree with terms and condition"),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 57,
            width: 257,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  // Validate the form
                  if (_signFormKey.currentState?.validate() ?? false) {
                    _signFormKey.currentState?.save();

                    // Check if password and confirm password match
                    if (password == confirmPassword) {
                      // Call the signup API
                      final result = await AuthService.signup(
                          firstName!, email!, password!);

                      if (result["success"]) {
                        // If signup is successful, navigate to OTP screen
                        context.push(
                          "/otp",
                          extra: {
                            'email': email,
                            'phoneNumber': phoneNumber,
                          },
                        );
                      } else {
                        // If signup failed, show the error message in SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text(result["message"] ?? "Signup failed")),
                        );
                      }
                    } else {
                      // Show error message if passwords don't match
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52BF90),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push("/login");
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2E7758),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
