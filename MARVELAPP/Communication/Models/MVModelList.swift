//
//  MVModelList.swift
//  MARVELAPP
//
//  Created by jorge lengua on 28/7/22.
//

import Foundation
import UIKit

struct CharacterDataWrapper  {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    let data: CharacterDataContainer?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case data
        case etag
    }
}
extension CharacterDataWrapper: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.attributionText = try container.decodeIfPresent(String.self, forKey: .attributionText)
        self.attributionHTML = try container.decodeIfPresent(String.self, forKey: .attributionHTML)
        self.data = try container.decodeIfPresent(CharacterDataContainer.self, forKey: .data)
        self.etag = try container.decodeIfPresent(String.self, forKey: .etag)
    }
}


struct CharacterDataContainer {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Character]?
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}
extension CharacterDataContainer: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.results = try container.decodeIfPresent([Character].self, forKey: .results)
    }
}

extension CharacterDataContainer: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(offset, forKey: .offset)
        try container.encodeIfPresent(limit, forKey: .limit)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(count, forKey: .count)
        try container.encodeIfPresent(results, forKey: .results)
    }
}
