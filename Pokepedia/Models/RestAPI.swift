import Alamofire
import Foundation
import SwiftSoup
import UIKit

class testViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()

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

                // 포켓몬 번호, 이름, 모습 적용
                for element in elements {
                    let text = try element.select("h3").text()
                    let parts = text.split(separator: " ", maxSplits: 1)

                    let appearance = try element.select("div > p").text()

                    pokemonAppearanceArray.append(appearance)

                    if parts.count == 2 {
                        pokemonNumberArray.append(String(parts[0]))
                        pokemonNameArray.append(String(parts[1]))

                        self.pokemons.append(Pokemon(id: String(parts[0]), name: String(parts[1]), image: nil, appearance: appearance))
                    }
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
                        print("\(String(describing: self.pokemons[index].image))")
                    }
                }

                print("test: \(pokemonNumberArray)")
                print("test: \(pokemonNameArray)")
                print("test: \(pokemonImageArray)")
                print("test: \(pokemonAppearanceArray)")

            } catch {
                print("crawl error")
            }
        }
    }
}
