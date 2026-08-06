import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

/// Animated floating blob/glow for hero backgrounds
class AnimatedBlob extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final Offset offset;

  const AnimatedBlob({
    super.key,
    required this.color,
    this.size = 400,
    this.duration = const Duration(seconds: 8),
    this.offset = Offset.zero,
  });

  @override
  State<AnimatedBlob> createState() => _AnimatedBlobState();
}

class _AnimatedBlobState extends State<AnimatedBlob>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final scale = 0.85 + 0.15 * _animation.value;
        return Transform.translate(
          offset: Offset(
            widget.offset.dx + 20 * math.sin(_animation.value * math.pi),
            widget.offset.dy + 20 * math.cos(_animation.value * math.pi),
          ),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    widget.color.withOpacity(0.3),
                    widget.color.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Particle background with floating dots
class ParticleBackground extends StatefulWidget {
  final Color color;
  final int particleCount;

  const ParticleBackground({
    super.key,
    this.color = AppColors.appleBlue,
    this.particleCount = 30,
  });

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    final rng = math.Random();
    for (var i = 0; i < widget.particleCount; i++) {
      _particles.add(_Particle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        size: rng.nextDouble() * 3 + 1,
        speed: rng.nextDouble() * 0.3 + 0.05,
        opacity: rng.nextDouble() * 0.5 + 0.1,
      ));
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        painter: _ParticlePainter(
          particles: _particles,
          progress: _controller.value,
          color: widget.color,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _Particle {
  final double x, y, size, speed, opacity;
  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color color;

  _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final dy = (p.y + progress * p.speed) % 1.0;
      final paint = Paint()
        ..color = color.withOpacity(p.opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(p.x * size.width, dy * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

/// Moving grid background
class GridBackground extends StatelessWidget {
  final Color color;
  final double cellSize;

  const GridBackground({
    super.key,
    this.color = AppColors.border,
    this.cellSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridBgPainter(color: color, cellSize: cellSize),
      size: Size.infinite,
    );
  }
}

class _GridBgPainter extends CustomPainter {
  final Color color;
  final double cellSize;

  _GridBgPainter({required this.color, required this.cellSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;
    for (double x = 0; x <= size.width; x += cellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += cellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridBgPainter old) => false;
}
