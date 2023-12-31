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
        var IdArray: [String] = []

        AF.request(url).responseString { response in
            guard let html = response.value else {
                return
            }

            do {
                let doc: Document = try SwiftSoup.parse(html)
                let NameAndType: Elements = try doc.select(".bg-white > td")

                var updatedPokemons = [Pokemon]()
                var pokemonId = 1

                for (index, num) in NameAndType.enumerated() {
                    let name = try num.select("a")

                    if  try !(name.text().isEmpty) {
                        let aTag = try name.attr("href").removingPercentEncoding!
                        if !(aTag.contains("타입")){
                            let detailString = "https://pokemon.fandom.com\(aTag)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                            let detailUrl = URL(string: detailString)!
                            
                            AF.request(detailUrl).responseString{ res in
                                guard let detailHtml = res.value else {
                                    return
                                }
                                
                                do {
                                    let doc: Document = try SwiftSoup.parse(detailHtml)
                                    let pokName = try doc.select(".head > .name > strong").text()
                                    let pokId = try doc.select(".index > .rounded").text()
                                    print("\(pokName) : \(pokId)")
                                    
                                } catch {
                                    print("crawl errror")
                                }
                                
                            }
                        }
                            
                        
                        
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
                                updatedPokemons.append(Pokemon(id: "", korName: try name.text(), appearance: "", type: enumType))
                                pokemonId += 1
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
