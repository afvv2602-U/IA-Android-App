import 'package:flutter/material.dart';
import 'package:iapp/db/models/user_registration.dart';

// Config
import 'package:iapp/config/colors.dart';
import 'package:iapp/config/strings.dart';

// Widgets
import 'package:iapp/widgets/normal_login/custom_login_button.dart';
import 'package:iapp/widgets/normal_login/footer_login.dart';
import 'package:iapp/widgets/normal_login/header_login.dart';
import 'package:iapp/widgets/normal_login/custom_divider.dart';
import 'package:camera/camera.dart';

class RegisterPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const RegisterPage({required this.cameras, Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState?.validate() == true) {
      Map<String, dynamic> user = {
        'nombre': _nombreController.text,
        'apellido': _apellidoController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      await UserRegistration().registerUser(user);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado con éxito')),
      );
      Navigator.pop(context);
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  AppStrings.createAcc,
                                  style: TextStyle(
                                    fontFamily: 'RalewayMedium',
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _nombreController,
                                decoration: InputDecoration(
                                  hintText: 'Nombre',
                                  filled: true,
                                  fillColor: AppColors.baseNeutralClara,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su nombre';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _apellidoController,
                                decoration: InputDecoration(
                                  hintText: 'Apellido',
                                  filled: true,
                                  fillColor: AppColors.baseNeutralClara,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su apellido';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Correo electrónico',
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
                                decoration: InputDecoration(
                                  hintText: 'Contraseña',
                                  filled: true,
                                  fillColor: AppColors.baseNeutralClara,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, ingrese su contraseña';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              CustomLoginButton(
                                text: AppStrings.create,
                                onPressed: _registerUser,
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
