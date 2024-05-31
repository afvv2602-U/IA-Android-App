import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:aesthetica/widgets/diver_login/header_with_divider.dart';
import 'package:aesthetica/widgets/diver_login/footer_with_divider.dart';

class TermsConditionsPage extends StatelessWidget {
  final List<CameraDescription> cameras;

  const TermsConditionsPage({required this.cameras, Key? key})
      : super(key: key);

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
                        'Al utilizar la Aplicación, usted acepta estos Términos y Condiciones y se compromete a cumplirlos. Si no está de acuerdo con alguna parte de estos términos, no debe utilizar la Aplicación.\n\n'
                        '2. Uso de la Aplicación\n\n'
                        'La Aplicación está destinada a usuarios que deseen explorar, compartir y vender obras de arte. Usted se compromete a utilizar la Aplicación de manera responsable y conforme a todas las leyes y regulaciones aplicables.\n\n'
                        '3. Registro de Cuenta\n\n'
                        'Para acceder a ciertas funciones de la Aplicación, es posible que deba crear una cuenta. Usted se compromete a proporcionar información precisa y completa al registrarse y a mantener la confidencialidad de su contraseña. Usted es responsable de todas las actividades que ocurran bajo su cuenta.\n\n'
                        '4. Derechos de Propiedad Intelectual\n\n'
                        'Todos los contenidos, incluidos, entre otros, textos, gráficos, logotipos, imágenes, y software, son propiedad de Aesthetica SA o de sus licenciantes y están protegidos por leyes de derechos de autor y otras leyes de propiedad intelectual. No se permite la reproducción, distribución o creación de obras derivadas sin nuestro consentimiento expreso por escrito.\n\n'
                        '5. Contenidos Generados por el Usuario\n\n'
                        'Usted puede subir, compartir y publicar contenido en la Aplicación. Al hacerlo, usted otorga a Aesthetica SA una licencia mundial, no exclusiva, libre de regalías, para usar, reproducir, modificar, distribuir y mostrar dicho contenido en la Aplicación y en cualquier medio relacionado con la promoción de la Aplicación.\n\n'
                        '6. Conducta Prohibida\n\n'
                        'Está prohibido:\n\n'
                        'Publicar contenido ofensivo, difamatorio, o ilegal.\n\n'
                        'Usar la Aplicación para cualquier propósito ilegal o no autorizado.\n\n'
                        'Infringir los derechos de propiedad intelectual de terceros.\n\n'
                        'Interferir con el funcionamiento de la Aplicación.\n\n'
                        '7. Compras y Pagos\n\n'
                        'Si realiza compras a través de la Aplicación, usted acepta pagar todos los cargos asociados con dichas compras. Todas las ventas son finales y no reembolsables, salvo que la ley exija lo contrario.\n\n'
                        '8. Política de Privacidad\n\n'
                        'El uso de la Aplicación está también sujeto a nuestra Política de Privacidad, la cual describe cómo recopilamos, utilizamos y compartimos su información personal. Le recomendamos que lea nuestra Política de Privacidad detenidamente.\n\n'
                        '9. Limitación de Responsabilidad\n\n'
                        'La Aplicación se proporciona "tal cual" y "según disponibilidad". No garantizamos que la Aplicación esté libre de errores o que su uso sea ininterrumpido. En la máxima medida permitida por la ley, no seremos responsables por daños indirectos, incidentales, especiales, consecuentes o punitivos, incluyendo, pero no limitado a, pérdida de beneficios, datos o uso, resultantes de o relacionados con el uso o la imposibilidad de usar la Aplicación.\n\n'
                        '10. Modificaciones a los Términos\n\n'
                        'Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento. Las modificaciones serán efectivas inmediatamente después de su publicación en la Aplicación. Su uso continuado de la Aplicación después de cualquier cambio constituye su aceptación de los nuevos términos.\n\n'
                        '11. Terminación\n\n'
                        'Podemos suspender o terminar su acceso a la Aplicación en cualquier momento, sin previo aviso, por cualquier motivo, incluyendo, pero no limitado a, el incumplimiento de estos Términos y Condiciones.\n\n'
                        '12. Ley Aplicable\n\n'
                        'Estos Términos y Condiciones se regirán e interpretarán de acuerdo con las leyes de España, sin dar efecto a ningún principio de conflicto de leyes.\n\n'
                        '13. Contacto\n\n'
                        'Si tiene alguna pregunta o inquietud acerca de estos Términos y Condiciones, por favor contáctenos en aesthetica.corp@gmail.com.\n\n'
                        'Al utilizar la Aplicación, usted reconoce que ha leído, comprendido y acepta estar sujeto a estos Términos y Condiciones.',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 50),
                      FooterWithDivider(cameras: cameras),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
