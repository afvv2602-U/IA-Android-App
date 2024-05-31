import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:aesthetica/widgets/diver_login/header_with_divider.dart';
import 'package:aesthetica/widgets/diver_login/footer_with_divider.dart';

class SubscriptionsPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const SubscriptionsPage({required this.cameras, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWithDivider(cameras: cameras),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Términos y Condiciones para Aesthetica',
                        style: TextStyle(
                          fontFamily: 'RalewayMedium',
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Última actualización: 6 Junio 2024',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '1. Aceptación de los Términos\n\n'
                        'Al suscribirse a nuestros servicios, usted acepta estos Términos y Condiciones y se compromete a cumplirlos. Si no está de acuerdo con alguna parte de los términos, no deberá suscribirse ni utilizar nuestros servicios.\n\n'
                        '2. Suscripciones\n\n'
                        'Ofrecemos diferentes planes de suscripción con diversas características y precios. Al suscribirse a uno de nuestros planes, usted acepta pagar las tarifas correspondientes de acuerdo con el plan seleccionado. Las suscripciones se renovarán automáticamente al final de cada período de suscripción, a menos que se cancelen previamente.\n\n'
                        '3. Pagos y Facturación\n\n'
                        'Los pagos de las suscripciones se realizarán a través de los métodos de pago disponibles en nuestra plataforma. Usted autoriza a Aesthetica a cobrar las tarifas de suscripción a través del método de pago seleccionado. Asegúrese de que la información de facturación proporcionada sea precisa y esté actualizada.\n\n'
                        '4. Cancelación y Reembolsos\n\n'
                        'Puede cancelar su suscripción en cualquier momento a través de la configuración de su cuenta en la plataforma. Las cancelaciones serán efectivas al final del período de suscripción en curso y no se emitirán reembolsos por los períodos ya pagados. Nos reservamos el derecho de emitir reembolsos a nuestra discreción.\n\n',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '5. Cambios en los Términos\n\n'
                        'Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento. Le notificaremos cualquier cambio importante a través de nuestra plataforma o por otros medios de comunicación. Es su responsabilidad revisar periódicamente estos términos para estar al tanto de las actualizaciones.\n\n',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Si tiene alguna pregunta o inquietud sobre estos Términos y Condiciones, no dude en ponerse en contacto con nosotros a través de los canales de soporte proporcionados en nuestra plataforma.',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FooterWithDivider(cameras: cameras),
        ],
      ),
    );
  }
}
