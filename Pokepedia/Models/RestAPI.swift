import Alamofire
import Foundation
import SwiftSoup
import UIKit

class testViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()

    func convertToType(from string: String) -> Type? {
        return Type.allCases.first { $0.name == string }
    }

    func test() {
        guard let url = URL(string: "https://pokemonkorea.co.kr/pokedex")
        else {
            return
        }

        AF.request(url).responseString { response in
            guard let html = response.value else {
                return
            }

            do {
                let doc: Document = try SwiftSoup.parse(html)
                let elements: Elements = try doc.select(".bx-txt")
                let imageElements: Elements = try doc.select(".img > .tumb-wrp > img")

                var pokemonNumberArray: [String] = []
                var pokemonNameArray: [String] = []
                var pokemonImageArray: [String] = []
                var pokemonAppearanceArray: [String] = []
                // var pokemonTypeArray: [String] = []

                // 포켓몬 번호, 이름, 모습, 타입 적용
                for element in elements {
                    let text = try element.select("h3").text()
                    let parts = text.split(separator: " ", maxSplits: 1)

                    let appearance = try element.select("div > p").text()

                    let typeString = try element.select("span").text()
                    let typeArray = typeString.split(separator: " ")
                    let typeArrayStrings = typeArray.map { typeStr -> String in
                        String(typeStr)
                    }
                    let typeArrayEnums: [Type] = typeArrayStrings.compactMap { self.convertToType(from: $0) }

                    pokemonAppearanceArray.append(appearance)

                    //for index in 0 ..< typeArray.count {}

                    if parts.count == 2 {
                        pokemonNumberArray.append(String(parts[0]))
                        pokemonNameArray.append(String(parts[1]))
                    }

                    self.pokemons.append(Pokemon(id: String(parts[0]), name: String(parts[1]), image: nil, appearance: appearance, type: typeArrayEnums))
                }

                // 이미지 적용
                // TODO: 이미지 로딩은 추후 비동기실행으로 변경하기
                for imageEle in imageElements {
                    let src = try imageEle.attr("src")
                    pokemonImageArray.append(String(src))
                }

                for (index, imageUrlString) in pokemonImageArray.enumerated() {
                    if let imageUrl = URL(string: imageUrlString),
                       let imageData = try? Data(contentsOf: imageUrl),
                       let image = UIImage(data: imageData)
                    {
                        self.pokemons[index].image = image
                    }
                }

            } catch {
                print("crawl error")
            }
        }
    }
}
