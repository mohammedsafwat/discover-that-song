//
//  Album.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

struct Album: Codable {
    let albumType: String
    let artists: [Artist]
    let availableMarkets: [String]
    let externalUrls: [String: String]
    let id: String
    let images: [Image]
    let name: String
    let releaseDate: String
    let uri: String

    enum CodingKeys: String, CodingKey {
        case artists, id, images, name, uri
        case albumType = "album_type"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case releaseDate = "release_date"
    }
}
