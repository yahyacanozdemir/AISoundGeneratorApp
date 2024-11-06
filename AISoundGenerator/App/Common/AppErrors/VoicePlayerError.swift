//
//  VoicePlayerError.swift
//  AISoundGenerator
//
//  Created by Yahya Can Özdemir on 5.11.2024.
//

enum VoicePlayerError: String {
  case invalidDurationTime = "Ses dosyasının süre değeri doğru dönüştürülemedi."
  case durationKeyInvalid = "Ses dosyasının süre bilgisi alınamadı."
  case durationCantLoad = "Ses dosyasından süre bilgisi yüklenemedi"
  case anErrorOccured = "Bir hata meydana geldi."
}
