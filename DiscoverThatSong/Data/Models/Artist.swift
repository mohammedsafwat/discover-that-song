//
//  Artist.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

struct Artist: Codable, Equatable {
    let externalUrls: [String: String]
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case externalUrls = "external_urls"
    }
}
