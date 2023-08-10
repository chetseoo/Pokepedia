import Foundation
import UIKit

class Pokemon: Identifiable, ObservableObject {
    let id: String
    let name: String
    @Published var image: UIImage?

    init(id: String, name: String, image: UIImage?) {
        self.id = id
        self.name = name
        self.image = image
    }
}
