//
//  InspirationsData.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Foundation

struct InspirationsData {
  static let inspirations: [String] = [
    "an atmospheric sleep soundscape with distant celestial melodies, creating a sense of floating in a calm night sky",
    "a dreamy music box melody that transports listeners to a serene and restful dreamland",
    "a calming meditation piece with the sounds of falling rain, distant thunder, and gentle wind chimes",
    "an evolving ambient soundscape that progresses through the changing seasons, from the blossoming of spring to the hush of winter",
    "a folk rock song that combines acoustic instruments with rock elements, telling a storytelling narrative",
    "a progressive rock epic with intricate instrumental sections, dynamic shifts, and thought-provoking melodies",
    "an orchestral overture reminiscent of the Classical era, featuring intricate orchestration and well-defined musical themes",
    "a meditation ambience with soft, pulsating tones that guide the listener into a deep state of relaxation and inner reflection",
    "a meditative drone piece that mirrors the rhythmic patterns of ocean waves, gradually building in intensity and subsiding like the tide"
  ]
  
  static func getRandomInspiration() -> String {
    return inspirations.randomElement() ?? ""
  }
}

