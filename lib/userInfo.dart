import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Dynamic height for responsiveness
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
                mainAxisSize: MainAxisSize.min, // Minimize column size
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/man.png', height: 150),
                  const SizedBox(height: 20),
                  const Text(
                    "Company info",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Company Name",
                    icon: Icons.factory,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Address of the Company",
                    icon: Icons.location_pin,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Website Address",
                    icon: Icons.web,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    hintText: "Enter Company Email",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black45,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'adminHome');
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.save, color: Colors.white),
                        SizedBox(width: 5),
                        Text("Save", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
      style: const TextStyle(color: Colors.black), // Adjusted text color for readability
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
