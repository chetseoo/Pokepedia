import Alamofire
import Foundation
import SwiftSoup
import UIKit

class ViewModel: ObservableObject {
    @Published var pokemons = [Pokemon]()

    // String값을 Enum으로 바꿔주는 함수
    func convertToType(from string: String) -> Type? {
        return Type.allCases.first { $0.name == string }
    }

    func parsing() {
        let urlString = "https://pokemon.fandom.com/ko/wiki/전국도감"
        // 링크 내 한글 인코딩을 위한 작업
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!

        AF.request(url).responseString { response in
            guard let html = response.value else {
                return
            }

            do {
                let doc: Document = try SwiftSoup.parse(html)
                let NameAndType: Elements = try doc.select(".bg-white > td")

                var updatedPokemons = [Pokemon]()

                for (index, num) in NameAndType.enumerated() {
                    let name = try num.select("a").text()

                    if !name.isEmpty {
                        let typeIndex = index + 1
                        if typeIndex < NameAndType.count {
                            let typeElement = NameAndType[typeIndex]
                            let type = try typeElement.select("a").text()

                            let typeArray = type.split(separator: " ")
                            var enumType: [Type] = []
                            for index in 0 ..< typeArray.count {
                                if let convertedType = self.convertToType(from: String(typeArray[index])) {
                                    enumType.append(convertedType)
                                }
                            }
                            if !type.isEmpty {
                                print("포켓몬 이름 : \(name), 타입 : \(type)")
                                updatedPokemons.append(Pokemon(id: "1", korName: name, appearance: "ㅋ", type: enumType))
                                //print(Pokemon(id: "1", korName: name, appearance: "ㅋ", type: enumType))
                            }
                        }
                    }
                }

                DispatchQueue.main.async {
                    self.pokemons = updatedPokemons
                }

            } catch {
                print("crawl error")
            }
        }
    }
}
