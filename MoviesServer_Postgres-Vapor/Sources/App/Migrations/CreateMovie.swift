//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 17/10/20.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateMovie: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies") // Table name
            .id()
            .field("title", .string) // Column name
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .delete() // Drop database
    }
}
