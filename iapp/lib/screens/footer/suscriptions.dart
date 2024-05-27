import 'package:flutter/material.dart';

// Import widgets
import 'package:iapp/widgets/diver_login/header_with_divider.dart';
import 'package:iapp/widgets/diver_login/footer_with_divider.dart';

class SubscriptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWithDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white, // Fondo blanco
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
                        'Al suscribirse a nuestros servicios, usted acepta estos Términos y Condiciones y se compromete a cumplirlos. Si no está de acuerdo con alguna parte de estos términos, no debe utilizar nuestros servicios de suscripción.\n\n'
                        '2. Servicios de Suscripción\n\n'
                        'Nuestros servicios de suscripción ofrecen acceso a contenido y características exclusivas dentro de la Aplicación. Los detalles específicos de cada nivel de suscripción, incluyendo los beneficios y tarifas, se describen en la Aplicación.\n\n'
                        '3. Registro y Cuenta de Suscripción\n\n'
                        'Para acceder a los servicios de suscripción, debe crear una cuenta y proporcionar información precisa y completa. Usted es responsable de mantener la confidencialidad de su cuenta y contraseña, y de todas las actividades que ocurran bajo su cuenta.\n\n'
                        '4. Tarifas y Pagos\n\n'
                        'Las tarifas de suscripción se cobran de acuerdo con el plan seleccionado (mensual, anual, etc.). Al suscribirse, usted autoriza a Aesthetica SA a cargar a su método de pago elegido las tarifas de suscripción aplicables. Todas las tarifas son no reembolsables, salvo que la ley exija lo contrario.\n\n'
                        '5. Renovación Automática\n\n'
                        'A menos que cancele su suscripción, ésta se renovará automáticamente al final de cada período de suscripción. Usted autoriza a Aesthetica SA a cobrar las tarifas de suscripción aplicables en su método de pago al comienzo de cada período de renovación.\n\n'
                        '6. Cancelación de la Suscripción\n\n'
                        'Puede cancelar su suscripción en cualquier momento a través de la configuración de su cuenta en la Aplicación. La cancelación será efectiva al final del período de suscripción actual, y no se proporcionarán reembolsos por períodos de suscripción ya pagados.\n\n'
                        '7. Modificaciones a los Servicios de Suscripción\n\n'
                        'Nos reservamos el derecho de modificar los servicios de suscripción, incluyendo las tarifas y beneficios, en cualquier momento. Cualquier cambio será efectivo al final del período de suscripción actual. Le notificaremos de cualquier cambio material con antelación razonable.\n\n'
                        '8. Uso Aceptable\n\n'
                        'Usted se compromete a utilizar los servicios de suscripción de manera legal y conforme a estos Términos y Condiciones. No se permite compartir su cuenta de suscripción con otras personas ni utilizar la suscripción de manera fraudulenta o inapropiada.\n\n'
                        '9. Propiedad Intelectual\n\n'
                        'Todos los contenidos accesibles a través de los servicios de suscripción son propiedad de Aesthetica SA o de sus licenciantes y están protegidos por leyes de derechos de autor y otras leyes de propiedad intelectual. No se permite la reproducción, distribución o creación de obras derivadas sin nuestro consentimiento expreso por escrito.\n\n'
                        '10. Limitación de Responsabilidad\n\n'
                        'Los servicios de suscripción se proporcionan "tal cual" y "según disponibilidad". No garantizamos que los servicios estén libres de errores o que su uso sea ininterrumpido. En la máxima medida permitida por la ley, no seremos responsables por daños indirectos, incidentales, especiales, consecuentes o punitivos, incluyendo, pero no limitado a, pérdida de beneficios, datos o uso, resultantes de o relacionados con el uso o la imposibilidad de usar los servicios de suscripción.\n\n'
                        '11. Modificaciones a los Términos\n\n'
                        'Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento. Las modificaciones serán efectivas inmediatamente después de su publicación en la Aplicación. Su uso continuado de los servicios de suscripción después de cualquier cambio constituye su aceptación de los nuevos términos.\n\n'
                        '12. Terminación\n\n'
                        'Podemos suspender o terminar su acceso a los servicios de suscripción en cualquier momento, sin previo aviso, por cualquier motivo, incluyendo, pero no limitado a, el incumplimiento de estos Términos y Condiciones.\n\n'
                        '13. Ley Aplicable\n\n'
                        'Estos Términos y Condiciones se regirán e interpretarán de acuerdo con las leyes de España, sin dar efecto a ningún principio de conflicto de leyes.\n\n'
                        '14. Contacto\n\n'
                        'Si tiene alguna pregunta o inquietud acerca de estos Términos y Condiciones, por favor contáctenos en aesthetica.corp@gmail.com.\n\n'
                        'Al suscribirse a nuestros servicios, usted reconoce que ha leído, comprendido y acepta estar sujeto a estos Términos y Condiciones.',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ), // Add spacing before the footer appears
                      FooterWithDivider(),
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
