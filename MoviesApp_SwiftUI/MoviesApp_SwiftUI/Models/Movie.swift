//
//  Movie.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 24/10/20.
//

import Foundation
struct Movie: Codable {
    var id: UUID?
    var title: String
    var poster: String
    
    private enum MovieKeys: String, CodingKey {
        case id
        case title
        case poster
    }
}

extension Movie {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.id = try container.decode(UUID.self, forKey: .id)
    }
}
