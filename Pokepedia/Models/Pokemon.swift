import Foundation
import UIKit

struct Pokemon: Hashable {
    let totalId: Int
    let areaId: Int
    let korName: String
    let japName: String
    let engName: String
    let ecology: String
    let type: [Type]
    let area: Area
}
