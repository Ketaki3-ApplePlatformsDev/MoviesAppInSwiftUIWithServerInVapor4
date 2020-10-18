//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 18/10/20.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovieActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movie_actors") // Table name
            .id()
            .field("movie_id", .uuid, .references("movies", "id"))
            .field("actor_id", .uuid, .references("actors", "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movie_actors")
            .delete() // Drop table
    }
}
