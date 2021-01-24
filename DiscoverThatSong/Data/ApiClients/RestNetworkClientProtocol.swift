//
//  RestNetworkClientProtocol.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

import Combine
import Foundation

protocol RestNetworkClientProtocol {
    var headers: [String: String] { get set }
    
    func performRequest<T: Decodable>(
        url: URL,
        type: RequestType,
        parameters: [String : Any]
    ) -> AnyPublisher<T, Error>
}
