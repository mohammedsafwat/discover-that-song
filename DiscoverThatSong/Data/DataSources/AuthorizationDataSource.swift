//
//  AuthorizationDataSource.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-24.
//

import Combine

protocol AuthorizationDataSource {
    func accessToken() -> AnyPublisher<Token, Error>
}
