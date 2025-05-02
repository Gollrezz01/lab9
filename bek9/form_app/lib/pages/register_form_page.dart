import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: RegistrationPage()));
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 31, 19, 87), // Updated background color
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width > 600 ? 450 : 350, // Responsive width
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 198, 214, 18), const Color.fromARGB(255, 135, 50, 47)], // New gradient color
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Register Now",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 220, 119, 119),
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        labelText: "Full Name *",
                        icon: Icons.person,
                        validator: (value) => value!.isEmpty ? "Name cannot be empty" : null,
                      ),
                      _buildTextField(
                        controller: _phoneController,
                        labelText: "Phone Number *",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) => value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)
                            ? "Enter a valid phone number"
                            : null,
                      ),
                      _buildTextField(
                        controller: _emailController,
                        labelText: "Email Address",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => value!.isEmpty || !RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)
                            ? "Enter a valid email"
                            : null,
                      ),
                      _buildPasswordField(
                        controller: _passwordController,
                        labelText: "Password *",
                        obscureText: _obscurePassword,
                        onToggle: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      _buildPasswordField(
                        controller: _confirmPasswordController,
                        labelText: "Confirm Password *",
                        obscureText: _obscureConfirmPassword,
                        onToggle: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                        validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange.shade500, // Button color changed to deep orange
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 8,
                          shadowColor: Colors.deepOrange.shade300,
                          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserInfoPage(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text("Submit Form", style: TextStyle(color: const Color.fromARGB(255, 147, 71, 71))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
          prefixIcon: icon != null ? Icon(icon, color: const Color.fromARGB(255, 129, 34, 34)) : null,
          filled: true,
          fillColor: const Color.fromARGB(255, 91, 184, 45),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: Colors.deepOrange.shade400), // New border color
          ),
        ),
        validator: validator,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 16, color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 167, 71, 71),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 2, color: Colors.deepOrange.shade400), // New border color
          ),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.deepOrange.shade700),
            onPressed: onToggle,
          ),
        ),
        validator: validator ?? (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  UserInfoPage({required this.name, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Info"), backgroundColor: const Color.fromARGB(255, 24, 19, 25)), // Updated color
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 58, 63, 155))),
            SizedBox(height: 10),
            Text("Email: $email", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 126, 11, 11))),
            SizedBox(height: 10),
            Text("Phone: $phone", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 4, 1, 11))),
          ],
        ),
      ),
    );
  }
}