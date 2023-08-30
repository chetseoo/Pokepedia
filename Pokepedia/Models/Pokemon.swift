import Foundation
import SwiftUI
import UIKit

struct Pokemon {
    let id: String
    let name: String
    var image: UIImage?
    let appearance: String
    let type: [Type]
}

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
        case .Normal: return Color.gray
        case .Fire: return Color.orange
        case .Water: return Color.blue
        case .Grass: return Color.green
        case .Electric: return Color.yellow
        case .Ice: return Color.indigo
        case .Fighting: return Color.red
        case .Poison: return Color.purple
        case .Ground: return Color.brown
        case .Flying: return Color.mint
        case .Psychic: return Color.pink
        case .Bug: return Color.green
        case .Rock: return Color.gray
        case .Ghost: return Color.purple
        case .Dragon: return Color.blue
        case .Fairy: return Color.pink
        case .Dark: return Color.black
        case .Steel: return Color.teal
        }
    }
}
