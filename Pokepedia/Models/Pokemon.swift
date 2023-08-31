import Foundation
import UIKit

struct Pokemon: Hashable {
    let id: String
    let korName: String
    var image: UIImage?
    let appearance: String
    let type: [Type]
    // 지방
}
