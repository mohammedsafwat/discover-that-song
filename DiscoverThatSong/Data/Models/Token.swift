//
//  Token.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-24.
//

struct Token: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Double

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }

    var bearerToken: String {
        return "\(tokenType.capitalized) \(accessToken)"
    }
}
