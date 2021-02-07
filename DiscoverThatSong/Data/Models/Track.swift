//
//  Track.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

struct Track: Codable, Equatable {
    let album: Album
    let artists: [Artist]
    let id: String
    let name: String
}
