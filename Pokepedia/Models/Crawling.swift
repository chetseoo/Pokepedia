//
//  Crawling.swift
//  Pokepedia
//
//  Created by 최서연 on 2023/09/02.
//

import Alamofire
import Foundation
import SwiftSoup

class ViewModel: ObservableObject {
    @Published var pokKorNameArray: [String] = []
    
    func crawling() {
        let urlString = "https://pokemon.fandom.com/ko/wiki/전국도감"
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedUrl)!

        var detailUrlArray: [String] = []
        let group = DispatchGroup()

        // 각 포켓몬의 상세정보 페이지의 링크 저장
        group.enter()
        AF.request(url).responseString { response in
            defer {
                group.leave()
            }
            guard let html = response.value else {
                return
            }

            do {
                let doc: Document = try SwiftSoup.parse(html)
                let td: Elements = try doc.select(".bg-white > td > a")

                for td in td {
                    let detailUrlString = try td.attr("href")
                    if detailUrlString.contains(")") {
                        detailUrlArray.append("https://pokemon.fandom.com\(detailUrlString)")
                    }
                }
                
            } catch {
                print("crawling error!")
            }
        }

        group.notify(queue: .main) {
            // 중복을 방지하기 위한 Set
            var processedNames = Set<String>()

            for pokUrl in detailUrlArray {
                let url = URL(string: pokUrl)!

                AF.request(url).responseString { res in
                    guard let detailHtml = res.value else {
                        return
                    }

                    do {
                        let doc: Document = try SwiftSoup.parse(detailHtml)
                        let elements: Elements = try doc.select(".name-ko > strong")

                        for ele in elements {
                            let name = try ele.text()
                            if !processedNames.contains(name) {
                                processedNames.insert(name)
                                self.pokKorNameArray.append(name)
                                print(name)
                            }
                        }

                    } catch {
                        print("crawling error!")
                    }
                }
            }
        }


        
        
    }
}
