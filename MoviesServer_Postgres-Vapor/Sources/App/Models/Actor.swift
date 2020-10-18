//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 18/10/20.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class Actor: Model, Content {
    static let schema = "actors" // Table name
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    // Belongs to - Actors belongs to movies
    @Siblings(through: MovieActor.self, from: \.$actor, to: \.$movie)
    var movies: [Movie]
    
    init() {
    }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
