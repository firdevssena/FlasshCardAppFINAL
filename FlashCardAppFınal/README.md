Flashcard App
Flashcard App, kullanıcıların kelime dağarcıklarını geliştirmelerine yardımcı olan, interaktif ve modüler bir kelime kartı uygulamasıdır. Kullanıcılar İngilizce kelimeleri Türkçe anlamlarıyla kolayca öğrenir ve kartlara tıklayarak anlamlar arasında geçiş yapabilir.
 
Projenin Amacı
Bu proje, kullanıcıların 100 farklı kelimeyi İngilizce ve Türkçe anlamlarıyla öğrenip pekiştirmesini amaçlar. Kartlara tıklanarak kelimenin Türkçe karşılığı gösterilir. Sıralı geçiş imkanıyla öğrenme süreci desteklenir.
 
Teknik Detaylar
•    Flutter ile Dart dili kullanılarak geliştirilmiştir.
•    Stateful widget yapısı ile dinamik kart gösterimi sağlanır.
•    Kullanıcı etkileşimleri kartların ön ve arka yüzlerini çevirme ve sıralı ilerleme ile yönetilir.
•    Kullanıcı arayüzü Flutter widgetları ile akıcı ve kolay kullanımlıdır.
•    Firebase kullanılarak kullanıcı kimlik doğrulama (e-posta, Gmail, GitHub) ve kullanıcı bilgileri yönetimi sağlanır.
•    Supabase ile kullanıcı profil bilgileri ve ek tablolar saklanır.
•    Modüler yapı ile ortak bileşenler (AppBar, Drawer) tüm sayfalarda kullanılabilir.
 
Öne Çıkan Özellikler
•    Kelime Kartları: İngilizce kelime ve Türkçe anlamı dinamik olarak gösterilir.
•    Kart Çevirme: Kart önüne tıklanmasıyla arka yüz açılır.
•    Sıralı Geçiş: İleri tuşu ile kelimeler arasında geçiş yapılır.
•    Kullanıcı Girişi: Firebase Authentication ile e-posta, Gmail ve GitHub ile kayıt ve giriş.
•    Profil Yönetimi: Kullanıcı doğum tarihi, doğum yeri ve yaşadığı il Firebase’de tutulur.
•    Profil Verileri: Kullanıcı profiline ait detaylar Supabase üzerinde tutulur.
•    Ortak Bileşenler: AppBar ayrı widget olarak kodlanmış, tüm sayfalarda kullanılıyor.
•    Profil Sayfası: Base sayfadan türetilmiş modüler yapıya sahip.
 
Projedeki Sayfaların Görevleri ve İçerikleri
1.    home_page.dart
Uygulamanın ana işlevlerine erişim ve menü gösterimi.
2.    login_page.dart
Kullanıcıların güvenli e-posta, Gmail veya GitHub ile giriş yaptığı sayfa.
3.    register_page.dart
Yeni kullanıcı kayıt sayfası.
4.    settings_page.dart
Kullanıcı ayarlarının yapıldığı sayfa.
5.    translation_page.dart
Kelime çeviri özelliklerinin bulunduğu sayfa.
6.    profile_page.dart (Base sayfadan türetilmiş)
Kullanıcı profili ve detaylarının gösterildiği sayfa.
 
Login Bilgileri
•    Firebase Authentication ile e-posta, Gmail ve GitHub hesapları üzerinden kayıt ve giriş yapılabilir.
•    Kullanıcının doğum tarihi, doğum yeri ve yaşadığı il Firebase’de saklanmaktadır.
•    Giriş bilgilerinin yönetimi güvenli ve kalıcıdır.
 
 
Logo API Bilgileri
•    Drawer menüsünde kullanılan logo, internet üzerinden dinamik olarak Brandfetch API aracılığıyla çekilmektedir.
•    LogoProvider ve ResimSaglayici sınıfları ile logo dinamik olarak yüklenir ve LogoWidget ile gösterilir.
•    Yükleme sırasında kullanıcıya görsel yükleniyor animasyonu sunulur.
Kullanıcı Verilerinin Saklanması
•    Kullanıcı uid, e-posta, ad ve soyad bilgileri uygulama içinde hızlı erişim için SharedPreferences’ta tutulmaktadır.
•    Kullanıcı giriş yaptıktan sonra, profil bilgileri daha kapsamlı yönetim ve çevrimdışı erişim için SQLite veritabanında da saklanmaktadır.
•    Böylece hem hızlı veri erişimi sağlanmakta hem de uygulama kapalı olsa bile profil bilgileri yerel olarak güvenle muhafaza edilmektedir.
Cloud Firestore'da Not Saklama Örneği
Aşağıda Cloud Firestore'da bir kartın nasıl saklandığını gösteren örnek bulunmaktadır:
json
Copy
{
  "content": "Flashcard App ile kelime çalış",
  "email": "goren.fatima@gmail.com ",
  "isStarred": true,
  "timestamp": "June 3, 2025 at 10:00:00 AM UTC+3",
  "title": "FlashCardApp",
  "uid": "7wdOFgpBmtWF4N1Fmmuow3FwtBx1"}
 
Ekip Üyeleri ve Katkıları
Fatıma Zeynep Gören (ID: 030720092)
•    Firebase Authentication entegrasyonu
•    Google , Github login-sign up entegrasyonları.
•    Kayıt sayfası (register_page.dart)
•    Giriş sayfası (login_page.dart)
Firdevs Sena İlhan (ID: 030721058)
•    Kullanıcı arayüzü tasarımı,
•    Supabase ve ekran geçişleri.
•    Drawer şablonu
•    Tema yönetimi
 
Özgünlük ve Karmaşıklık
Uygulamanın en özgün özelliği, kartların ön ve arka yüzleri arasında dinamik geçiş sağlamasıdır. Ayrıca Firebase ve Supabase’in birlikte kullanımı ile hem kimlik doğrulama hem de detaylı profil yönetimi yapılmaktadır. Bu yapılar, uygulamanın güvenli, modüler ve sürdürülebilir olmasını sağlar.
 
Çalıştırma
Copy

flutter run -d chrome --web-port 5000


