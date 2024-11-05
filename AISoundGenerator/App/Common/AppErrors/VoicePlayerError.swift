//
//  VoicePlayerError.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 5.11.2024.
//

enum VoicePlayerError: String {
  case invalidDurationTime = "Ses dosyasında duration değeri doğru dönüştürülemedi."
  case durationKeyInvalid = "Ses dosyasından duration bilgisi alınamadı."
  case durationCantLoad = "Ses dosyasından duration bilgisi yüklenemedi"
  case anErrorOccured = "Bir hata meydana geldi."
}
