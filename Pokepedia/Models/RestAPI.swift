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
                let pokNumber: Elements = try doc.select(".bg-white > td")

                for (index, num) in pokNumber.enumerated() {
                    let name = try num.select("a").text()
                    
                    if !name.isEmpty {
                        let typeIndex = index + 1
                        if typeIndex < pokNumber.count {
                            let typeElement = pokNumber[typeIndex]
                            let type = try typeElement.select("a").text()
                            if !type.isEmpty {
                                print("포켓몬 이름 : \(name), 타입 : \(type)")
                            }
                        }
                    }
                }

            } catch {
                print("crawl error")
            }
        }
    }
}
