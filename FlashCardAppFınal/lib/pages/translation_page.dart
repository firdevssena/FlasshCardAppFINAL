import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/base_page.dart';

// Çeviri sayfası widget'ı
class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

// Çeviri sayfası widget'ının durum sınıfı
class _TranslationPageState extends State<TranslationPage> {
  // Kelime girişi için text kontrolcüsü
  final TextEditingController _wordController = TextEditingController();
  // Çeviri sonucunu tutan değişken
  String _translation = '';

  // Kelime sözlüğü - Türkçe-İngilizce çiftleri
  final Map<String, String> wordDictionary = {
    'merhaba': 'Hello',
    'kitap': 'Book',
    'araba': 'Car',
    'ev': 'House',
    'köpek': 'Dog',
    'güzel': 'Beautiful',
    'yemek': 'Food',
    'okul': 'School',
    'ağaç': 'Tree',
    'telefon': 'Phone',
    'saat': 'Clock',
    'gözlük': 'Glasses',
    'masa': 'Table',
    'bardak': 'Cup',
    'ayakkabı': 'Shoes',
    'pencere': 'Window',
    'kapı': 'Door',
    'bütün': 'Whole',
    'yüksek': 'High',
    'düşük': 'Low',
    'küçük': 'Small',
    'büyük': 'Big',
    'hızlı': 'Fast',
    'yavaş': 'Slow',
    'sıcak': 'Hot',
    'soğuk': 'Cold',
    'uzun': 'Long',
    'kısa': 'Short',
    'yüksek sesle': 'Loudly',
    'sessiz': 'Quiet',
    'tuz': 'Salt',
    'şeker': 'Sugar',
    'su': 'Water',
    'çay': 'Tea',
    'kahve': 'Coffee',
    'böcek': 'Insect',
    'gömlek': 'Shirt',
    'pantolon': 'Pants',
    'ceket': 'Jacket',
    'elbise': 'Dress',
    't-shirt': 'T-shirt',
    'saç': 'Hair',
    'diş': 'Tooth',
    'burun': 'Nose',
    'ağız': 'Mouth',
    'kulak': 'Ear',
    'göz': 'Eye',
    'yüz': 'Face',
    'boyun': 'Neck',
    'bacak': 'Leg',
    'ayak': 'Foot',
    'el': 'Hand',
    'parmak': 'Finger',
    'dudak': 'Lip',
    'yüzük': 'Ring',
    'müzik': 'Music',
    'film': 'Movie',
    'savaş': 'War',
    'barış': 'Peace',
    'köy': 'Village',
    'şehir': 'City',
    'ülke': 'Country',
    'deniz': 'Sea',
    'göl': 'Lake',
    'dağ': 'Mountain',
    'orman': 'Forest',
    'yol': 'Road',
    'hastalık': 'Disease',
    'ilaç': 'Medicine',
    'sağlık': 'Health',
    'öğretmen': 'Teacher',
    'öğrenci': 'Student',
    'sürekliliğini sağlamak': 'Perpetuate',
    'dengesiz': 'Capricious',
    'zayıf': 'Languid',
    'öğretici': 'Didactic',
    'çeşitli': 'Eclectic',
    'ağır suçlu': 'Heinous',
    'inatçı': 'Intransigent',
    'şakacı': 'Jocular',
    'gürültü': 'Cacophony',
    'zararlı': 'Pernicious',
    'dalgalanmak': 'Fluctuate',
    'sert eleştiri': 'Diatribe',
    'değiştirilemez': 'Immutable',
    'iyi niyetli': 'Benevolent',
    'tanrıya küfreden': 'Blasphemous',
    'kafa karıştırmak': 'Obfuscate',
    'dünya nimetlerinden uzak duran': 'Ascetic',
    'suçlamak': 'Inculpate',
    'düzensiz': 'Erratic',
    'içten': 'Candid',
    'sapma': 'Aberration',
    'anlamsız': 'Inane',
    'geveze': 'Garrulous',
    'başkalarını düşünme': 'Altruism',
    'sık kullanılan': 'Hackneyed',
    'iyi huylu': 'Benign',
    'gereksiz': 'Gratuitous',
    'parlak': 'Luminous',
    'kötüleştirmek': 'Exacerbate',
    'ciddiyetsiz': 'Facetious',
    'yan yana koymak': 'Juxtapose',
    'yorulmaz': 'Indefatigable',
    'geleneklere karşı çıkan': 'Iconoclast',
    'tanımlamak': 'Delineate',
    'kötü': 'Nefarious',
    'soğukkanlılık': 'Equanimity',
    'aklamak': 'Exculpate',
    'zengin': 'Opulent',
    'tartışmalı': 'Polemical',
    'zıtlık': 'Antithesis',
    'savaşçı': 'Belligerent',
    'bol': 'Copious',
    'çekingen': 'Demure',
    'ilgisiz': 'Apathetic',
    'zorlu': 'Arduous',
    'şaşkın': 'Flabbergasted',
    'anlaşılması zor': 'Esoteric',
    'aşırı': 'Exorbitant',
    'parasız': 'Impecunious',
    'hoş ses': 'Mellifluous',
    'farkında': 'Cognizant',
    'durum değiştiremeyen': 'Inexorable',
    'uykulu': 'Lethargic',
    'titiz': 'Fastidious',
    'estetik': 'Aesthetic',
    'cesur': 'Intrepid',
    'tembel': 'Indolent',
    'az ve öz': 'Laconic',
  };

  void _translateWord() {
    final word = _wordController.text.trim().toLowerCase(); 
    if (word.isNotEmpty) {
      if (wordDictionary.containsKey(word)) {
        setState(() {
          _translation = wordDictionary[word]!;
        });
      } else {
        setState(() {
          _translation = 'Çeviri bulunamadı';  
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Kelime Çevirisi",
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 182, 193), 
              Color.fromARGB(255, 173, 216, 230), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kelime giriş kutusu
              TextField(
                controller: _wordController,
                decoration: const InputDecoration(
                  labelText: 'Kelime Girin',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),

              // Çeviri butonu
              ElevatedButton(
                onPressed: _translateWord,
                child: const Text('Çevir'),
              ),
              const SizedBox(height: 20),

              Text(
                'Çeviri: ', 
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 60, 12, 76)),  
              ),
              Text(
                _translation,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),  
             ),
            ],
          ),
        ),
      ),
    );
  }
}
