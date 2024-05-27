import 'package:flutter/material.dart';

// Import constants
import 'package:iapp/config/colors.dart';
import 'package:iapp/config/strings.dart';

// Import widgets
import 'package:iapp/widgets/normal_login/custom_login_button.dart';
import 'package:iapp/widgets/normal_login/footer_login.dart';
import 'package:iapp/widgets/normal_login/header_login.dart';
import 'package:iapp/widgets/normal_login/custom_divider.dart';

// Import pages
import 'package:iapp/screens/login_register/register_page.dart';
import 'package:iapp/screens/login_register/forgot_pass_page.dart';

class LoginPage extends StatelessWidget {
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
                          'assets/images/background/bg_login.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                            SizedBox(height: 16),
                            TextField(
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
                            ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordPage()),
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
                              onPressed: () {
                                // Add your sign-in logic here
                              },
                            ),
                            SizedBox(height: 16),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()),
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
