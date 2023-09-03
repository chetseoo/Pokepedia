//
//  Area.swift
//  Pokepedia
//
//  Created by 최서연 on 2023/09/02.
//

import Foundation

enum Area {
    case Kanto
    case Johto
    case Hoenn
    case Sinnoh
    case Unova
    case Kalos
    case Alola
    case Galar
    case Hisui
    case Paldea
    
    var name: String {
        switch self {
        case .Kanto: return "관동"
        case .Johto: return "성도"
        case .Hoenn: return "호연"
        case .Sinnoh: return "신오"
        case .Unova: return "하나"
        case .Kalos: return "칼로스"
        case .Alola: return "알로라"
        case .Galar: return "가라르"
        case .Hisui: return "히스이"
        case .Paldea: return "팔데아"
        }
    }
}
