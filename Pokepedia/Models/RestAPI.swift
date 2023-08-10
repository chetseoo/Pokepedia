import Alamofire
import Foundation
import SwiftSoup

func sendPost() {
    guard let url = URL(string: "https://pokemonkorea.co.kr/ajax/pokedex")
    else {
        return
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"

    // 전송할 값
    let paramText = "mode=load_more&word=&characters=&pn=2&area=&snumber=1&snumber2=1010&sortselval=number%20asc,number_count%20asc&typestr="
    let paramData = paramText.data(using: .utf8)

    // form-data 설정
    urlRequest.httpBody = paramData

    // Header 설정
    urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
    urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
    urlRequest.setValue("keep-alive", forHTTPHeaderField: "Connection")
    urlRequest.setValue("925", forHTTPHeaderField: "Content-Length")
    urlRequest.setValue("multipart/form-data; boundary=----WebKitFormBoundarybp9PDpTaAtef7UsA", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("PHPSESSID=s29bvdi879ik2l7qbaom5gekri", forHTTPHeaderField: "Cookie")
    urlRequest.setValue("pokemonkorea.co.kr", forHTTPHeaderField: "Host")
    urlRequest.setValue("\"Not/A)Brand\";v=\"99\", \"Google Chrome\";v=\"115\", \"Chromium\";v=\"115\"", forHTTPHeaderField: "sec-ch-ua")
    urlRequest.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
    urlRequest.setValue("macOS", forHTTPHeaderField: "sec-ch-ua-platform")
    urlRequest.setValue("cors", forHTTPHeaderField: "Sec-Fetch-Mode")
    urlRequest.setValue("same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
    urlRequest.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
    urlRequest.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")

    let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in

        // 서버가 응답이 없거나 통신이 실패
        if let e = error {
            NSLog("An error has occured: \(e.localizedDescription)")
            return
        }

        // 응답 처리 로직
        DispatchQueue.main.async {
            // 서버로부터 응답된 스트링 표시
            let output = String(data: data!, encoding: String.Encoding.utf8)
            print("result: \(output!)")

            if let pnValue = output?.split(separator: "&").first(where: { $0.contains("pn=") }) {
                let pn = pnValue.split(separator: "=").last
                print("pn value: \(pn ?? "")")
            }
        }
    }

    task.resume()
}







class testViewModel: ObservableObject{
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
                let elements: Elements = try doc.select(".bx-txt > h3")
                
                var pokemonNumberArray: [String] = []
                var pokemonNameArray: [String] = []
                
                for element in elements {
                    let text = try element.text()
                    let parts = text.split(separator: " ", maxSplits: 1)
                    if parts.count == 2 {
                        pokemonNumberArray.append(String(parts[0]))
                        pokemonNameArray.append(String(parts[1]))
                        
                        self.pokemons.append(Pokemon(id: String(parts[0]), name: String(parts[1])))
                    }
                }
                print("test: \(pokemonNumberArray)")
                print("test: \(pokemonNameArray)")
                
            } catch {
                print("crawl error")
            }
        }
    }
}
