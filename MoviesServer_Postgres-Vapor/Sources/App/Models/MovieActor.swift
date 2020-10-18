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

final class MovieActor: Model {
    static let schema = "movie_actors" // Table name
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "movie_id") // Foreign key
    var movie: Movie
    
    @Parent(key: "actor_id") // Foreign key
    var actor: Actor
    
    init() {
    }
    
    init(movieId: UUID, actorId: UUID) {
        self.$movie.id = movieId
        self.actor.id = actorId
    }
}

