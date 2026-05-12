import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
 
/// Logo complet : icône 3 silhouettes + texte "Bx-Jeunes Impact"
class BxLogo extends StatelessWidget {
  const BxLogo({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: 84, height: 68,
        child: CustomPaint(painter: _LogoPainter()),
      ),
      const SizedBox(height: 16),
      RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(children: [
          TextSpan(
            text: 'Bx-Jeunes\n',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: -.5,
              height: 1.15,
            ),
          ),
          TextSpan(
            text: 'Impact',
            style: TextStyle(
              color: AppColors.red,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              letterSpacing: -.5,
            ),
          ),
        ]),
      ),
      const SizedBox(height: 10),
      const Text(
        'Connecter • Inspirer • Impacter',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          letterSpacing: .3,
        ),
      ),
    ]);
  }
}
 
/// Icône seule (3 silhouettes) — utile dans une AppBar
class BxLogoIcon extends StatelessWidget {
  final double size;
  const BxLogoIcon({super.key, this.size = 40});
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size * .8,
      child: CustomPaint(painter: _LogoPainter()),
    );
  }
}
 
class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    void person(Offset c, double r, Color color) {
      final p = Paint()..color = color;
      canvas.drawCircle(c, r * .44, p);
      canvas.drawArc(
        Rect.fromCenter(
            center: c.translate(0, r * .88),
            width: r * 1.55,
            height: r * 1.1),
        3.14159, 3.14159, true, p,
      );
    }
 
    person(Offset(s.width * .18, s.height * .38), s.width * .15, AppColors.red);
    person(Offset(s.width * .82, s.height * .38), s.width * .15, AppColors.orange);
    person(Offset(s.width * .50, s.height * .26), s.width * .20, AppColors.red);
  }
 
  @override
  bool shouldRepaint(_) => false;
}
 
/// Blob décoratif orange/jaune (bas-gauche de l'écran login)
class BlobDecoration extends StatelessWidget {
  final double size;
  const BlobDecoration({super.key, this.size = 220});
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size, height: size,
      child: CustomPaint(painter: _BlobPainter()),
    );
  }
}
 
class _BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final path = Path()
      ..moveTo(0, s.height * .55)
      ..quadraticBezierTo(
          s.width * .08, s.height * .18, s.width * .48, s.height * .28)
      ..quadraticBezierTo(
          s.width * .88, s.height * .38, s.width, s.height * .68)
      ..quadraticBezierTo(s.width * .78, s.height, s.width * .28, s.height)
      ..quadraticBezierTo(0, s.height, 0, s.height * .55)
      ..close();
 
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          colors: [AppColors.orange, AppColors.orangeLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Offset.zero & s),
    );
  }
 
  @override
  bool shouldRepaint(_) => false;
}
 