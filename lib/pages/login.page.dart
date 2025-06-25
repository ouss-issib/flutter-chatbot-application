import 'package:flutter/material.dart';
import 'package:dwm_bot/pages/settings.page.dart'; // Import SettingsPage

class LoginPage extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Color(0xFF1565C0); // Blue shade

    return Scaffold(
      appBar: AppBar(
        title: Text("E-Chatbot Login"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("images/enset.png", width: 140),
              const SizedBox(height: 24),
              // Username and password fields
              _buildProfessionalInput(
                hintText: "Username",
                icon: Icons.person_outline,
                controller: userNameController,
                fillColor: Color(0xFFF5F5F5),
                hintColor: Colors.grey.shade600,
                borderColor: primaryColor,
              ),
              const SizedBox(height: 20),
              _buildProfessionalInput(
                hintText: "Password",
                icon: Icons.lock_outline,
                controller: passwordController,
                obscure: true,
                fillColor: Color(0xFFF5F5F5),
                hintColor: Colors.grey.shade600,
                borderColor: primaryColor,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String username = userNameController.text;
                    String passwd = passwordController.text;
                    if (username == "oussamabi" && passwd == "123456") {
                      Navigator.pushNamed(context, "/bot"); // Go to the chatbot page after login
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Button to go to SettingsPage to set the URL
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');  // Navigate to SettingsPage
                },
                child: Text("Set URL for Chatbot"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfessionalInput({
    required String hintText,
    required IconData icon,
    required TextEditingController controller,
    required Color fillColor,
    required Color hintColor,
    required Color borderColor,
    bool obscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: fillColor,
        prefixIcon: Icon(icon, color: borderColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }
}
