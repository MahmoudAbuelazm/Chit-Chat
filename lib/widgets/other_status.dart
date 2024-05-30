import 'package:flutter/material.dart';

class OtherStatus extends StatelessWidget {
  const OtherStatus(
      {super.key,
      required this.name,
      required this.time,
      required this.imageUrl,
      required this.isSeen,
      required this.statusCount});
  final String name;
  final String time;
  final String imageUrl;
  final bool isSeen;
  final int statusCount;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CustomPaint(
        painter: StatusPainter(
          isSeen: isSeen,
          statusCount: statusCount,
        ),
        child: CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "Today at $time",
        style: TextStyle(
          color: Colors.grey[900],
          fontSize: 14,
        ),
      ),
    );
  }
}

deegreToAngle(double degree) {
  return degree * 3.14 / 180;
}

class StatusPainter extends CustomPainter {
  final bool isSeen;
  final int statusCount;
  StatusPainter({required this.isSeen, required this.statusCount});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = isSeen ? Colors.grey : const Color(0xff21bfa6)
      ..style = PaintingStyle.stroke;
    drawArc(canvas, size, paint);
  }

  void drawArc(Canvas canvas, Size size, Paint paint) {
    if (statusCount == 1) {
      canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height),
          deegreToAngle(0), deegreToAngle(360), false, paint);
    } else {
      double degree = -90;
      double arc = 360 / statusCount;
      for (int i = 0; i < statusCount; i++) {
        canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height),
            deegreToAngle(degree + 4), deegreToAngle(arc - 8), false, paint);
        degree += arc;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
