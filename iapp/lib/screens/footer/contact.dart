import 'package:flutter/material.dart';
import 'package:Aesthetica/config/colors.dart';
import 'package:Aesthetica/widgets/normal_login/custom_main_button.dart';
import 'package:Aesthetica/widgets/normal_login/footer_login.dart';
import 'package:Aesthetica/widgets/normal_login/header_login.dart';
import 'package:Aesthetica/widgets/normal_login/custom_divider.dart';
import 'package:camera/camera.dart';

class ContactPage extends StatelessWidget {
  final List<CameraDescription> cameras;
  final _formKey = GlobalKey<FormState>();

  ContactPage({required this.cameras, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(cameras: cameras),
            CustomDivider(),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Formulario de Contacto',
                        style: TextStyle(
                          fontFamily: 'RalewayMedium',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
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
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor, ingrese un correo válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Asunto',
                          filled: true,
                          fillColor: AppColors.baseNeutralClara,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese el asunto';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Descripción',
                          filled: true,
                          fillColor: AppColors.baseNeutralClara,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingrese una descripción';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      CustomButton(
                        text: 'Enviar',
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            // Enviar formulario
                          }
                        },
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            CustomDivider(),
            Footer(cameras: cameras),
          ],
        ),
      ),
    );
  }
}
