import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onInputChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if not the last
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      }
    } else if (value.isEmpty) {
      // Move to previous field if not the first
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
      }
    }
  }

  Future<void> _verifyOtp() async {
    // Combine OTP from controllers
    String otp = _controllers.map((controller) => controller.text).join('');

    print('OTP entered: $otp'); // Debug print

    if (otp.length == 4) {
      try {
        // Call the verifyOtp API method
        var result = await AuthService.verifyOtp(
            "abc@gmail.com", otp); // Replace with actual email

        print('Verification result: $result'); // Debug print

        if (result["success"] == true) {
          final prefs = await SharedPreferences.getInstance();

          // Set 'isLoggedIn' to true
          await prefs.setBool('isLoggedIn', true);
          print('Login status set to true'); // Debug print

          // OTP verified successfully
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result["message"]),
            backgroundColor: Colors.green,
          ));

          // Navigate to the home screen
          context.go('/');
        } else {
          // OTP verification failed
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(result["message"]),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        print('Error during OTP verification: $e'); // Debug print
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      // Show error if OTP is incomplete
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid 4-digit OTP."),
        backgroundColor: Colors.orange,
      ));
    }
  }

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
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            // Logo Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.jpg", height: 40), // Adjust as needed
              ],
            ),
            const SizedBox(height: 40),
            // Heading Section
            const Center(
              child: Text(
                "Verification Code",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Info Section
            const Text(
              "We have sent the 4-digit Verification code to your\nPhone Number and Email Address",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Text(
              "abc@gmail.com and 0349******32",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF52BF90), // Text color
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF52BF90),
              ),
            ),
            const SizedBox(height: 30),
            // OTP Input Row Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => OtpInputField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  onChanged: (value) => _onInputChanged(value, index),
                ),
              ),
            ),
            const SizedBox(height: 150),
            // Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    text: "Resend",
                    backgroundColor: Colors.grey.shade200,
                    textColor: Colors.black,
                    onTap: () {
                      // Add resend logic
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: "Verify",
                    backgroundColor: const Color(0xFF52BF90),
                    textColor: Colors.white,
                    onTap: _verifyOtp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// The other widget classes (OtpInputField, CustomButton) remain the same as in the original code

// OTP Input Row with Focus Handling
class OtpInputRow extends StatefulWidget {
  const OtpInputRow({super.key});

  @override
  _OtpInputRowState createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onInputChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if not the last
      if (index < 3) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else if (value.isEmpty) {
      // Move to previous field if not the first
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => OtpInputField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          onChanged: (value) => _onInputChanged(value, index),
        ),
      ),
    );
  }
}

// Reusable OTP Input Field
class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: Colors.black54,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: onChanged,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "",
        ),
        style: const TextStyle(
          fontSize: 38,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Reusable Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
