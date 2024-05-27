import 'package:flutter/material.dart';

// Constants
import 'package:iapp/config/colors.dart';
import 'package:iapp/config/strings.dart';
import 'package:iapp/widgets/normal_login/custom_divider.dart';

// Widgets
import 'package:iapp/widgets/normal_login/custom_login_button.dart';
import 'package:iapp/widgets/normal_login/footer_login.dart';
import 'package:iapp/widgets/normal_login/header_login.dart';

class ForgotPasswordPage extends StatelessWidget {
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
                Header(),
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
                            TextField(
                              decoration: InputDecoration(
                                hintText: AppStrings.email,
                                filled: true,
                                fillColor: AppColors.baseNeutralClara,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            CustomLoginButton(
                              text: 'ENVIAR',
                              onPressed: () {
                                // Add your reset password logic here
                              },
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
                    ],
                  ),
                ),
                CustomDivider(),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
