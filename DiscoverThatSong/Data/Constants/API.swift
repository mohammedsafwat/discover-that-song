//
//  API.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Foundation

enum API {
    private static let ApiBaseURL = "https://api.spotify.com/v1/"
    private static let AccountsBaseURL = "https://accounts.spotify.com/api/"

    enum Tracks {
        static let EndpointURL = API.ApiBaseURL + "tracks"
    }

    enum Authorization {
        static let EndpointURL = API.AccountsBaseURL + "token"
        static let ClientID = "26970c29c8634f18a1a6d2e43b52b874"
        static let ClientSecret = "842fe12a2e694c4aa94ca56308ee6fa6"
        static let Parameters = ["grant_type": "client_credentials"]
        static let Header = [HeaderKey: HeaderValue]

        static let HeaderKey = "Authorization"
        private static let HeaderValue = "Basic \(encodedClientIDAndSecret)"
        private static var encodedClientIDAndSecret: String {
            "\(ClientID):\(ClientSecret)".base64Encoded.string ?? ""
        }
    }
}
