import 'package:flutter/material.dart';

// Flashcard widget'ı
class FlashcardWidget extends StatefulWidget {
  // Kartın ön ve arka yüzündeki metinler
  final String frontText;
  final String backText;
  const FlashcardWidget({super.key, required this.frontText, required this.backText});

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

// Flashcard widget'ının durum sınıfı
class _FlashcardWidgetState extends State<FlashcardWidget> {
  // Kartın ön yüzünün gösterilip gösterilmediğini tutan değişken
  bool _isFront = true;

  // Kartı çeviren fonksiyon
  void _toggleCard() {
    setState(() {
      _isFront = !_isFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              _isFront ? widget.frontText : widget.backText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}