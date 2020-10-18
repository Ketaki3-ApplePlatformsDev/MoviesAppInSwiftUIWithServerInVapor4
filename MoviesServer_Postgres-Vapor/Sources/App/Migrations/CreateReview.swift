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

struct CreateReview: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews") // Table name
            .id()
            .field("title", .string) // Column name
            .field("body", .string)
            .field("movie_id", .uuid, .references("movies", "id"))
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("reviews")
            .delete() // Drop table
    }
}
