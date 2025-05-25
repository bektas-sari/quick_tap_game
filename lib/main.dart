// lib/main.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const QuickTapGame());

class QuickTapGame extends StatelessWidget {
  const QuickTapGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Tap Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[50],
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      home: const GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  static const Duration gameDuration = Duration(seconds: 30);
  static const double circleDiameter = 80;

  final Random _rng = Random();
  late Timer _timer;
  int _score = 0;
  double _posX = 0, _posY = 0;
  late AnimationController _animCtrl;
  late Animation<double> _scaleAnim;
  double _timeLeft = gameDuration.inSeconds.toDouble();
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) _animCtrl.reverse();
    });
    _scaleAnim =
        Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _spawnCircle(); // ilk konum
  }

  @override
  void dispose() {
    _timer.cancel();
    _animCtrl.dispose();
    super.dispose();
  }

  void _startGame(Size size) {
    setState(() {
      _score = 0;
      _timeLeft = gameDuration.inSeconds.toDouble();
      _running = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) {
        t.cancel();
        setState(() => _running = false);
      }
    });
    _spawnCircle(size: size);
  }

  void _spawnCircle({Size? size}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final s = size ?? MediaQuery.of(context).size;
      setState(() {
        _posX = _rng.nextDouble() * (s.width - circleDiameter);
        _posY = _rng.nextDouble() * (s.height - circleDiameter - 120); // üst çubuğa çarpmaması için
      });
      _animCtrl.forward(from: 0);
    });
  }

  void _onTap(Size size) {
    if (!_running) return;
    setState(() => _score++);
    _spawnCircle(size: size);
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Tap Game'),
        elevation: 4,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Puan ve zaman üst barı
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoChip(label: 'Score', value: _score.toString()),
                _InfoChip(label: 'Time', value: _timeLeft.toStringAsFixed(0)),
              ],
            ),
          ),

          // Dokunulabilir daire
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            left: _posX,
            top: _posY,
            child: GestureDetector(
              onTap: () => _onTap(screen),
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: circleDiameter,
                  height: circleDiameter,
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        spreadRadius: 1,
                        color: Colors.indigo.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Oyun bitiş kaplaması
          if (!_running && _timeLeft <= 0)
            _GameOverOverlay(
              score: _score,
              onRestart: () => _startGame(screen),
            ),
        ],
      ),
      floatingActionButton: !_running
          ? FloatingActionButton.extended(
        onPressed: () => _startGame(screen),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start'),
      )
          : null,
    );
  }
}

// ----- Yardımcı bileşenler -----
class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      label: Text('$label: $value',
          style: TextStyle(
            color: Colors.indigo[700],
            fontWeight: FontWeight.w600,
          )),
    );
  }
}

class _GameOverOverlay extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;
  const _GameOverOverlay({required this.score, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Game Over',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 12),
                Text('Your score: $score',
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onRestart,
                  icon: const Icon(Icons.replay),
                  label: const Text('Play Again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
