//
//  TracksDataSource.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-23.
//

import Combine

protocol TracksDataSource {
    var authorizationDataSource: AuthorizationDataSource { get }
    func tracks(ids: String) -> AnyPublisher<Tracks, Error>
}
