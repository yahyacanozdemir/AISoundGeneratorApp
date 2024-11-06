# Voice Generator iOS App

![Voice Generator App](https://github.com/user-attachments/assets/97868171-2700-4d35-b7a8-d91b73b978f7)

Bu proje Papcorns şirketinin gönderdiği aday challange'ı kapsamıdna tarafımca 3 günlük süreçte, XCODE üzerinde ve Swift UIKit ile geliştirilmiş bir mobil uygulamadır. Uygulama, kullanıcıların farklı ses türlerinden ses dosyaları oluşturmasına, bunları çalmasına, indirmesine ve paylaşmasına olanak tanır.

## İçindekiler
- [Özellikler](#özellikler)
- [Sayfa Detayları](#sayfa-detayları)
- [Proje Yapısı](#proje-yapısı)
- [Kullanılan Kütüphaneler](#kullanılan-kütüphaneler)
- [Network Manager Sınıfı](#networkManager-sınıfı)
- [Kurulum](#kurulum)
- [Geliştirici](#geliştirici)

---

## Özellikler
![App Features](https://github.com/user-attachments/assets/04cf726b-8984-4449-9254-22e2d36e9a75)
![App Features](https://github.com/user-attachments/assets/66521fe1-4473-4280-a060-fb571763775e)

- **Ses Dosyası Üretimi:** Farklı ses türleri ve kullanıcı prompt’larına göre ses dosyaları üretilir.
- **Animasyonlu Geçişler:** Ses üretimi sırasında kullanıcıya animasyonlu bir arayüz gösterilir.
- **Ses Kontrolü:** Üretilen ses dosyası çalınabilir, duraklatılabilir, ileri-geri sarılabilir ve döngü şeklinde oynatılabilir.
- **İndirme ve Paylaşma:** Kullanıcı, üretilen ses dosyasını cihazına indirebilir veya paylaşabilir.
- **Geri Bildirimler:** Kullanıcıya veri çekme esnasında loading animasyonları ve geri bildirim popup’ları sunulur.

## Sayfa Detayları

### Anasayfa
- **Görev:** Uygulamanın açılış sayfası olarak kullanıcıdan input alan bir component içerir ve `getVoice` endpoint’ine çıkılır. İstek esnasında ekranı kitlemeyen animasyonlu bir loading görüntülenir. Gelen response'a göre ses türlerini listeler. 
- **İşlev:** Kullanıcı, bir ses türü seçerek ve bir prompt girerek aktif olan Coninue butonu aracılığıyla **Voice Generating** sayfasına yönlendirilir.

### Voice Generating
- **Görev:** Kullanıcının girdiği verilere göre ses dosyasının üretilmesini sağlar.
- **İşlev:** Kullanıcıdan alınan veriler doğrultusunda `startMusicGenerate` endpoint’ine istek gönderilir ve üretim esnasında animasyonlu bir arayüz görüntülenir.

### Voice Detail
- **Görev:** Üretilen ses dosyasının detaylarının görüntülendiği ve kontrol edildiği sayfa.
- **İşlev:** AVAudioPlayer üzerinde ses çalma, duraklatma, ileri/geri sarma ve döngü şeklinde oynatma işlemleri yapılabilir. Ayrıca, ses dosyasının indirilmesi ve paylaşılması sağlanır. Kullanıcı, Anasayfa’da girdiği prompt’u buradan kopyalayabilir.

## Teknik

### Proje Yapısı

#### Design Pattern
- **Coordinator:** Ekranlar arası geçişleri ve gezinmeyi merkezi bir yapıdan yönetmek için kullanılan bir tasarım desenidir. Bu pattern, her bir navigation akışını kendine özgü bir `Coordinator` sınıfı tarafından yönetilmesini sağlayarak, `View` ve bileşen sınıflarını UI ve içerik yönetimiyle sınırlar. Böylece, navigasyon mantığı kontrolcülerden ayrılarak daha modüler, test edilebilir ve sürdürülebilir bir yapı elde edilir.

#### Architecture
- **MVC-ComponentBase:** Uygulama, her bir sayfanın `BaseVC<BaseView>` sınıfından türetildiği, tüm bileşenlerin ise doğrudan `BaseView` sınıfından miras alarak yeniden kullanılabildiği, modüler ve kolay yönetilebilir bir mimari yapıyı kullanır. Bu mimari, ilgili `base` sınıflar ve protokoller aracılığıyla ağ işlemlerinin tek bir yapı üzerinden kolayca yönetilmesini sağlar. Bu yaklaşım, kodun anlaşılır ve tutarlı olmasını sağlarken yeniden kullanılabilirliği artırır ve geliştirme sürecini hızlandırır.

### Kullanılan Kütüphaneler

- **[SnapKit](https://github.com/SnapKit/SnapKit):** Kullanıcı arayüzünü Auto Layout ile dinamik şekilde oluşturmak için kullanıldı.
- **[Alamofire](https://github.com/Alamofire/Alamofire):** API (network) istekleri ve ses dosyası indirme işlemleri için kullanıldı.
- **[Kingfisher](https://github.com/onevcat/Kingfisher):** Remote görsellerin dinamik şekilde yüklenmesi için kullanıldı.

### NetworkManager Sınıfı

#### `NetworkDelegate` Protokolü

Ağ isteği sırasında alınan veri veya hataları yönetmek için kullanılan bir protokol:
- **`networkDataReceived`**: API’den başarılı bir veri geldiğinde çağrılır.
- **`networkErrorOccured`**: Bir hata meydana geldiğinde çağrılır; default olarak override edilmez.

#### `NetworkManager` Sınıfı

API işlemlerini ve ses dosyasını indirme işlemini yöneten singleton bir sınıftır.

- **`sendRequest`**: Genel bir API istek fonksiyonu. Geri dönüş tipi `Codable` olan modellerle çalışır ve JSON verilerini çözümleyerek `completion handler` ile sonuçları döndürür. `BaseVC` ve `BaseView` sınıflarından override edilerek kullanılabilir.
- **`downloadAudio`**: Belirtilen bir URL’den ses dosyasını indirir ve kullanıcı cihazına kaydeder. Başarılı bir indirme sonrasında kaydedilen dosya URL’sini döner.

## Kurulum

1. Bu repo’yu klonlayın:
   ```bash
   git clone https://github.com/kullanici-adi/Voice-Generator-iOS.git
   cd Voice-Generator-iOS

## Geliştirici

Bu proje, kullanıcı deneyimini ön planda tutarak geliştirilmiş, modüler ve kolayca genişletilebilir bir Swift uygulamasıdır. Projeye katkıda bulunmak veya sorularınızı iletmek için aşağıdaki bilgilere başvurabilirsiniz:

- **Geliştirici Adı:** [Yahya Can Özdemir]
- **E-posta:** [yahyacanozdemir@gmail.com]
- **LinkedIn:** [[LinkedIn Profiliniz](https://www.linkedin.com/in/yahyacanozdemir/)]

