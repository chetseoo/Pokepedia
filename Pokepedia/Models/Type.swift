import Foundation
import SwiftUI

enum Type: String, CaseIterable {
    case Normal
    case Fire
    case Water
    case Grass
    case Electric
    case Ice
    case Fighting
    case Poison
    case Ground
    case Flying
    case Psychic
    case Bug
    case Rock
    case Ghost
    case Dragon
    case Fairy
    case Dark
    case Steel

    var name: String {
        switch self {
        case .Normal: return "노말"
        case .Fire: return "불꽃"
        case .Water: return "물"
        case .Grass: return "풀"
        case .Electric: return "전기"
        case .Ice: return "얼음"
        case .Fighting: return "격투"
        case .Poison: return "독"
        case .Ground: return "땅"
        case .Flying: return "비행"
        case .Psychic: return "에스퍼"
        case .Bug: return "벌레"
        case .Rock: return "바위"
        case .Ghost: return "고스트"
        case .Dragon: return "드래곤"
        case .Fairy: return "페어리"
        case .Dark: return "악"
        case .Steel: return "강철"
        }
    }

    var color: Color {
        switch self {
        case .Normal: return Color("Normal")
        case .Fire: return Color("Fire")
        case .Water: return Color("Water")
        case .Grass: return Color("Grass")
        case .Electric: return Color("Electric")
        case .Ice: return Color("Ice")
        case .Fighting: return Color("Fighting")
        case .Poison: return Color("Poison")
        case .Ground: return Color("Ground")
        case .Flying: return Color("Flying")
        case .Psychic: return Color("Psychic")
        case .Bug: return Color("Bug")
        case .Rock: return Color("Rock")
        case .Ghost: return Color("Ghost")
        case .Dragon: return Color("Dragon")
        case .Fairy: return Color("Fairy")
        case .Dark: return Color("Dark")
        case .Steel: return Color("Steel")
        }
    }
}
