import 'package:flutter/material.dart';
import 'package:flashcard_app/widgets/flip_card.dart';
import 'package:flashcard_app/widgets/drawer_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/base_page.dart';

// Ana sayfa widget'ı - Durumu değişebilen bir widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// Ana sayfa widget'ının durum sınıfı
class _HomePageState extends State<HomePage> {
  // Sayfa kontrolcüsü - kartlar arasında geçiş yapmak için
  final PageController _pageController = PageController();

  // Kelime listesi - İngilizce kelimeler ve Türkçe anlamları
  final List<Map<String, String>> words = [
   
  {'word': 'Perpetuate', 'meaning': 'Sürekliliğini sağlamak, devam ettirmek'},
  {'word': 'Capricious', 'meaning': 'Dengesiz, değişken'},
  {'word': 'Languid', 'meaning': 'Zayıf, halsiz'},
  {'word': 'Didactic', 'meaning': 'Öğretici, ders veren'},
  {'word': 'Eclectic', 'meaning': 'Çeşitli, farklı kaynaklardan seçilmiş'},
  {'word': 'Heinous', 'meaning': 'Ağır suçlu, korkunç'},
  {'word': 'Intransigent', 'meaning': 'Inatçı, değişmez'},
  {'word': 'Jocular', 'meaning': 'Şakacı, neşeli'},
  {'word': 'Cacophony', 'meaning': 'Gürültü, karmaşa'},
  {'word': 'Pernicious', 'meaning': 'Zararlı, tehlikeli'},
  {'word': 'Fluctuate', 'meaning': 'Dalgalanmak, değişmek'},
  {'word': 'Diatribe', 'meaning': 'Sert eleştiri'},
  {'word': 'Immutable', 'meaning': 'Değiştirilemez, sabit'},
  {'word': 'Benevolent', 'meaning': 'İyi niyetli, yardımsever'},
  {'word': 'Blasphemous', 'meaning': 'Tanrıya küfreden, dinsiz'},
  {'word': 'Obfuscate', 'meaning': 'Kafa karıştırmak, bulanıklaştırmak'},
  {'word': 'Ascetic', 'meaning': 'Dünya nimetlerinden uzak duran'},
  {'word': 'Inculpate', 'meaning': 'Suçlamak'},
  {'word': 'Erratic', 'meaning': 'Düzensiz, kararsız'},
  {'word': 'Candid', 'meaning': 'İçten, dürüst'},
  {'word': 'Aberration', 'meaning': 'Sapma, yanlışlık'},
  {'word': 'Inane', 'meaning': 'Anlamsız, saçma'},
  {'word': 'Garrulous', 'meaning': 'Geveze, çok konuşan'},
  {'word': 'Altruism', 'meaning': 'Başkalarını düşünme, fedakarlık'},
  {'word': 'Hackneyed', 'meaning': 'Sık kullanılan, basmakalıp'},
  {'word': 'Benign', 'meaning': 'İyi huylu, zararsız'},
  {'word': 'Gratuitous', 'meaning': 'Gereksiz, haksız yere yapılan'},
  {'word': 'Luminous', 'meaning': 'Parlak, ışık saçan'},
  {'word': 'Exacerbate', 'meaning': 'Kötüleştirmek, şiddetlendirmek'},
  {'word': 'Facetious', 'meaning': 'Ciddiyetsiz, şaka yollu'},
  {'word': 'Juxtapose', 'meaning': 'Yan yana koymak, karşılaştırmak'},
  {'word': 'Frivolous', 'meaning': 'Ciddiyetsiz, boş'},
  {'word': 'Indefatigable', 'meaning': 'Yorulmaz'},
  {'word': 'Iconoclast', 'meaning': 'Geleneklere karşı çıkan kişi'},
  {'word': 'Delineate', 'meaning': 'Tanımlamak, açıklamak'},
  {'word': 'Nefarious', 'meaning': 'Kötü, rezil'},
  {'word': 'Equanimity', 'meaning': 'Soğukkanlılık'},
  {'word': 'Exculpate', 'meaning': 'Aklamak, temize çıkarmak'},
  {'word': 'Opulent', 'meaning': 'Zengin, lüks'},
  {'word': 'Polemical', 'meaning': 'Tartışmalı, karşıt görüşlü'},
  {'word': 'Antithesis', 'meaning': 'Zıtlık, karşıtlık'},
  {'word': 'Belligerent', 'meaning': 'Savaşçı, kavgacı'},
  {'word': 'Copious', 'meaning': 'Bol, çok'},
  {'word': 'Demure', 'meaning': 'Çekingen, utangaç'},
  {'word': 'Apathetic', 'meaning': 'İlgisiz, duyarsız'},
  {'word': 'Arduous', 'meaning': 'Zorlu, güç'},
  {'word': 'Flabbergasted', 'meaning': 'Şaşkın, afallamış'},
  {'word': 'Esoteric', 'meaning': 'Anlaşılması zor, dar bir kitleye hitap eden'},
  {'word': 'Exorbitant', 'meaning': 'Aşırı, fahiş'},
  {'word': 'Benevolent', 'meaning': 'İyi niyetli, yardımsever'},
  {'word': 'Impecunious', 'meaning': 'Parasız, yoksul'},
  {'word': 'Mellifluous', 'meaning': 'Hoş, akıcı ses'},
  {'word': 'Cognizant', 'meaning': 'Farkında, bilincinde'},
  {'word': 'Inexorable', 'meaning': 'Durum değiştiremeyen, çaresiz'},
  {'word': 'Lethargic', 'meaning': 'Uykulu, halsiz'},
  {'word': 'Fastidious', 'meaning': 'Titiz, zor beğenen'},
  {'word': 'Juxtapose', 'meaning': 'Yan yana koymak, karşılaştırmak'},
  {'word': 'Aesthetic', 'meaning': 'Estetik, güzellik anlayışı'},
  {'word': 'Intrepid', 'meaning': 'Cesur, korkusuz'},
  {'word': 'Indolent', 'meaning': 'Tembel, uyuşuk'},
  {'word': 'Hackneyed', 'meaning': 'Sık kullanılan, basmakalıp'},
  {'word': 'Laconic', 'meaning': 'Az ve öz, kısa'}
]
;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Ana Sayfa',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FlipCard(
                      frontText: words[index]['word'] ?? 'Kelime',
                      backText: words[index]['meaning'] ?? 'Anlam',
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_pageController.page != 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_pageController.page != words.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
