import 'package:flutter/material.dart';
import 'package:iapp/config/colors.dart';
import 'package:iapp/config/strings.dart';
import 'package:iapp/widgets/normal_login/custom_divider.dart';
import 'package:iapp/widgets/normal_login/custom_login_button.dart';
import 'package:iapp/widgets/normal_login/footer_login.dart';
import 'package:iapp/widgets/normal_login/header_login.dart';
import 'package:iapp/db/models/password_reset_helper.dart';
import 'package:camera/camera.dart';

class ForgotPasswordPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ForgotPasswordPage({required this.cameras, Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState?.validate() == true) {
      String email = _emailController.text;
      bool emailExists = await PasswordResetHelper().checkUserEmail(email);

      if (emailExists) {
        try {
          await PasswordResetHelper().sendResetEmail(email);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Correo de restablecimiento enviado')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al enviar el correo')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correo no registrado')),
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
                          'assets/images/background/bg_forgot_pass.jpg',
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
                              SizedBox(height: 50),
                              Text(
                                'Restablecer tu contraseña',
                                style: TextStyle(
                                  fontFamily: 'RalewayMedium',
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Te enviaremos un correo electrónico\npara restablecer tu contraseña',
                                style: TextStyle(
                                  fontFamily: 'RalewayExtraLight',
                                  fontSize: 18,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 40),
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
                              SizedBox(height: 40),
                              CustomLoginButton(
                                text: 'ENVIAR',
                                onPressed: _resetPassword,
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontFamily: 'RalewayMedium',
                                    fontSize: 16,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
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
