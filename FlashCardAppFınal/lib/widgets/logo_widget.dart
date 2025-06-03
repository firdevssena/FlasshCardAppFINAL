// Gerekli Flutter widget'larını ve servisleri içe aktarma
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/resim_saglayici.dart';

// Logo widget'ı
class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Resim sağlayıcı provider'ına erişim
    final resimSaglayici = Provider.of<ResimSaglayici>(context); 

    // Yükleme durumunu kontrol etme
    if (resimSaglayici.yukleniyor) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    // Resim URL'sinin varlığını kontrol etme
    if (resimSaglayici.imageURL == null) {
      return const Icon(Icons.error, color: Colors.red);
    }

    // Logo resmini gösterme
    return Image.network(
      resimSaglayici.imageURL!,
      height: 100,
      width: 100,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const CircularProgressIndicator(color: Colors.white);
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error, color: Colors.red);  
      },
    );
  }
}
