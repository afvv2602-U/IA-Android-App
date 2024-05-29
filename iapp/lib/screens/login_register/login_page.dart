import 'package:flutter/material.dart';
import 'package:iapp/db/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iapp/config/colors.dart';
import 'package:iapp/config/strings.dart';
import 'package:iapp/widgets/normal_login/custom_login_button.dart';
import 'package:iapp/widgets/normal_login/footer_login.dart';
import 'package:iapp/widgets/normal_login/header_login.dart';
import 'package:iapp/widgets/normal_login/custom_divider.dart';
import 'package:iapp/screens/login_register/register_page.dart';
import 'package:iapp/screens/login_register/forgot_pass_page.dart';
import 'package:iapp/screens/home/home_page.dart';
import 'package:iapp/db/models/user_login.dart';
import 'package:camera/camera.dart';

class LoginPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const LoginPage({required this.cameras, Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() == true) {
      String email = _emailController.text;
      String password = _passwordController.text;

      bool isValidUser = await UserLogin().validateUser(email, password);
      if (isValidUser) {
        int userId = await DatabaseHelper.instance.getUserId(email, password);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', email);
        prefs.setString('password', password);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AppHomePage(cameras: widget.cameras, userId: userId)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Header(cameras: widget.cameras),
                CustomDivider(),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/background/bg_login.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                AppStrings.signInTv,
                                style: TextStyle(
                                  fontFamily: 'RalewayMedium',
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: AppStrings.email,
                                  filled: true,
                                  fillColor: AppColors.baseNeutralClara,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su correo electrónico';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Por favor, ingrese un correo válido';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: AppStrings.signInPass,
                                  filled: true,
                                  fillColor: AppColors.baseNeutralClara,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su contraseña';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 8),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPasswordPage(
                                          cameras: widget.cameras),
                                    ),
                                  );
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.forgotPassword,
                                    style: TextStyle(
                                      fontFamily: 'RalewayMedium',
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              CustomLoginButton(
                                text: AppStrings.signIn,
                                onPressed: _login,
                              ),
                              SizedBox(height: 16),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterPage(
                                            cameras: widget.cameras)),
                                  );
                                },
                                child: Text(
                                  AppStrings.createAcc,
                                  style: TextStyle(
                                    fontFamily: 'RalewayMedium',
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDivider(),
                Footer(cameras: widget.cameras),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
