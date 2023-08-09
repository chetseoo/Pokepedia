import Alamofire
import Foundation
import SwiftSoup

func sendPost(paramText: String) {
    guard let url = URL(string: "https://pokemonkorea.co.kr/ajax/pokedex")
    else {
        return
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"

    // 전송할 값
    let paramData = paramText.data(using: .utf8)

    // Header 설정
    urlRequest.setValue("Bearer 12345", forHTTPHeaderField: "Authorization")
    urlRequest.setValue("PHPSESSID=i46cb6io6519tp5vf94qj1gqci", forHTTPHeaderField: "Cookie")
    urlRequest.setValue("<calculated when request is sent>", forHTTPHeaderField: "Postman-Token")
    urlRequest.setValue("multipart/form-data; boundary=<calculated when request is sent>", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
    urlRequest.setValue("<calculated when request is sent>", forHTTPHeaderField: "Host")
    urlRequest.setValue("PostmanRuntime/7.32.3", forHTTPHeaderField: "User-Agent")
    urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
    urlRequest.setValue("gzip, deflate, br", forHTTPHeaderField: "Accept-Encoding")
    urlRequest.setValue("keep-alive", forHTTPHeaderField: "Connection")
    urlRequest.setValue(" cors", forHTTPHeaderField: "Sec-Fetch-Mode")
    urlRequest.setValue(" same-origin", forHTTPHeaderField: "Sec-Fetch-Site")
    urlRequest.setValue(" Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36", forHTTPHeaderField: "User-Agent")
    urlRequest.setValue(" XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
    urlRequest.setValue("\"Not/A)Brand\";v=\"99\", \"Google Chrome\";v=\"115\", \"Chromium\";v=\"115\"", forHTTPHeaderField: "sec-ch-ua")
    urlRequest.setValue("?0", forHTTPHeaderField: "sec-ch-ua-mobile")
    urlRequest.setValue("macOS", forHTTPHeaderField: "sec-ch-ua-platform")

    // form-data 설정
    urlRequest.httpBody = paramData

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
        }
    }

    task.resume()
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
            // #newsContents > div > div.postRankSubjectList.f_clear
            let elements: Elements = try doc.select(".bx-txt > h3")
            for element in elements {
                try print(element.text())
            }
            //print("test: \(doc)")
            
        } catch {
            print("crawl error")
        }
    }
}
