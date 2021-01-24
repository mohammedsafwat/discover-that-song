//
//  DataError.swift
//  DiscoverThatSong
//
//  Created by Mohammed Abdullatif on 2021-01-02.
//

struct DataError: Error {
    let statusCode: Int?
    let message: String

    init(statusCode: Int?, message: String) {
        self.statusCode = statusCode
        self.message = message
    }

    init(type: DataErrorType) {
        self.init(statusCode: nil, message: type.errorMessage)
    }
}
