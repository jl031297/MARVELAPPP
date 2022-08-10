//
//  MVRestManager.swift
//  MARVELAPP
//
//  Created by jorge lengua on 27/7/22.
//

import Foundation
import Alamofire
import CommonCrypto

typealias CharacterDataWrapperCompletionResult = ((Result<CharacterDataWrapper, NSError>) -> Void)
typealias CharacterDataWrapperResult = Result<CharacterDataWrapper, NSError>

private struct Strings {
    static let urlXML = "/v1/public/characters"
    static let urlCharacter = "/v1/public/characters"
    static let apiKey = "d46ab345a57f9c7919233b9f804a5fcc"
    static let privateApiKey = "955edfeb1d9a4275d4760fa3ab1dd27855b086df"
    static let baseURL = URL(string: "https://gateway.marvel.com:443")

    

}


open class RestManager {
    private static var Manager: Alamofire.Session = {
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.Session.default.sessionConfiguration.httpAdditionalHeaders
        configuration.timeoutIntervalForRequest = 45
        configuration.timeoutIntervalForResource = 45
        let manager = Alamofire.Session(
            configuration: configuration
        )
        
        return manager
    }()
    
    
    static func loadImage(from url: URL, success succeed: (@escaping( UIImage)-> Void)) {
        
        Manager.request(url)
            .validate().response { response in
                if let responseURL: HTTPURLResponse = response.response {
                    if let error = response.error {
                        return
                    }

                    guard let data = response.data else {
                        return
                    }
        guard let downloadedImage = UIImage(data: data) else {
            return
        }
                    succeed(downloadedImage)
                    return
                    
            }
            }

    }
    static func dorestCall (_ name: String?, page: Int,  success succeed: (@escaping( CharacterDataWrapper)-> Void)) {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(Strings.privateApiKey)\(Strings.apiKey)".md5
        
        guard let url = Strings.baseURL else {
            return
        }
        var components = URLComponents(url: url.appendingPathComponent(Strings.urlXML), resolvingAgainstBaseURL: true)
        var customQueryItems = [URLQueryItem]()

        if let name = name {
            //customQueryItems.append(URLQueryItem(name: "name", value: name))
        }

        if page > 0 {
             customQueryItems.append(URLQueryItem(name: "offset", value: "\(page * 20)"))
        }

        
        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: Strings.apiKey)
        ]

        components?.queryItems = commonQueryItems + customQueryItems
        guard let url = components?.url else {
            return
        }
        Manager.request(url)
            .validate().response { response in
                var characterDetails: [String] = []

                if let responseURL: HTTPURLResponse = response.response {
                    if let error = response.error {
                        NSLog("error: \(error.localizedDescription)")

                        return
                    }

                    guard let data = response.data else {
                        NSLog("could not parse data")

                        return
                    }

                    guard let characterData = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data) else {
                        NSLog("could not parse data")

                        return
                    }
                    succeed(characterData)
                    return
                }
                
                

        }
    }
    static func getCharacterData(_ id: Int?,  success succeed: (@escaping( CharacterDataWrapper)-> Void)) {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(Strings.privateApiKey)\(Strings.apiKey)".md5
        
        guard let url = Strings.baseURL else {
            return
        }
        guard let id = id else {
            return
        }
        var components = URLComponents(url: url.appendingPathComponent("v1/public/characters/\(id)"), resolvingAgainstBaseURL: true)
        var customQueryItems = [URLQueryItem]()



        
        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: Strings.apiKey)
        ]

        components?.queryItems = commonQueryItems + customQueryItems
        guard let url = components?.url else {
            return
        }
        Manager.request(url)
            .validate().response { response in
                var characterDetails: [String] = []

                if let responseURL: HTTPURLResponse = response.response {
                    if let error = response.error {
                        NSLog(error.localizedDescription)

                        return
                    }

                    guard let data = response.data else {
                        NSLog("error receiving data")

                        return
                    }

                    guard let characterData = try? JSONDecoder().decode(CharacterDataWrapper.self, from: data) else {
                        NSLog("could not parse data")


                        return
                    }
                    succeed(characterData)
                    return
                }
                
                

        }
    }
    
}
extension String {
    var md5: String {
        let data = Data(self.utf8)
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
