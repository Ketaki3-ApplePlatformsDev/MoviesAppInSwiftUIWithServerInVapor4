//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 17/10/20.
//

import Foundation
import Fluent
import Vapor

final class Movie: Model, Content {
    static let schema = "movies" // Table name
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "poster")
    var poster: String
    
    // Belongs to - Review belongs to a particular movie
    @Children(for: \.$movie)
    var reviews: [Review]
    
    // Belongs to - Actors belongs to movies
    @Siblings(through: MovieActor.self, from: \.$movie, to: \.$actor)
    var actors: [Actor]
    
    init() {
    }
    
    init(id: UUID? = nil, title: String, poster: String) {
        self.id = id
        self.title = title
        self.poster = poster
    }
}
