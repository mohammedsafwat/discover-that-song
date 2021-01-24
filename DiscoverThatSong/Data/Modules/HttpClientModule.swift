//
//  HttpClientModule.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Foundation

struct HttpClientModule {

    // MARK: - Properties

    static let shared = HttpClientModule()

    // MARK: - Initializer

    private init () {}

    var httpClient: RestNetworkClientProtocol {
        return RestNetworkClient()
    }
}
