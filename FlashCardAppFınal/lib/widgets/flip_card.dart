import 'package:flutter/material.dart';

// Çevrilebilir kart widget'ı
class FlipCard extends StatefulWidget {
  // Kartın ön ve arka yüzündeki metinler
  final String frontText;
  final String backText;

  const FlipCard({super.key, required this.frontText, required this.backText});

  @override
  _FlipCardState createState() => _FlipCardState();
}

// Çevrilebilir kart widget'ının durum sınıfı
class _FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  // Animasyon kontrolcüsü ve rotasyon animasyonu
  late AnimationController _controller;
  late Animation<double> _rotation;

  // Kartın çevrilip çevrilmediğini tutan değişken
  bool _flipped = false;

  // Widget başlatıldığında çalışan metod
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0, end: 3.14159).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_flipped) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
          _flipped = !_flipped;
        });
      },
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final isUnder = _rotation.value > 1.5708; 

            return Transform(
              transform: Matrix4.rotationY(_rotation.value),
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 249, 214, 219),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: isUnder
                      ? _buildBackCard() 
                      : _buildFrontCard(), 
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Center(
      child: Transform(
        transform: Matrix4.rotationY(_rotation.value),
        alignment: Alignment.center,
        child: Text(
          widget.frontText,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Center(
      child: Transform(
        transform: Matrix4.rotationY(_rotation.value),
        alignment: Alignment.center,
        child: Text(
          widget.backText,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center, 
        ),
      ),
    );
  }
}
