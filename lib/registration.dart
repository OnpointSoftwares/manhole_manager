import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Adjust height dynamically
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.red[300]!,
                  Colors.red[400]!,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure column takes only necessary space
                children: [
                  const SizedBox(height: 80),
                  Image.asset('assets/man.png', height: 150),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Full Name",
                    icon: Icons.account_box,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Email",
                    icon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Password",
                    icon: Icons.lock_outlined,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Confirm Password",
                    icon: Icons.lock_outlined,
                    isPassword: true,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Row(
                          children: const [Text("Login"), Icon(Icons.login)],
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Handle Registration
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black45,
                        ),
                        child: Row(
                          children: const [Text("Register"), Icon(Icons.app_registration)],
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Signup with:"),
              const SizedBox(width: 10),
              SocialIconButton(icon: Icons.facebook),
              const SizedBox(width: 10),
              SocialIconButton(icon: Icons.facebook),
              const SizedBox(width: 10),
              SocialIconButton(icon: Icons.apple),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black), // Text color adjusted for white background
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white, // Background set to white
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}

// Social Media Icon Button
class SocialIconButton extends StatelessWidget {
  final IconData icon;

  const SocialIconButton({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.red,
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: () {
          // Handle Social Login
        },
      ),
    );
  }
}
