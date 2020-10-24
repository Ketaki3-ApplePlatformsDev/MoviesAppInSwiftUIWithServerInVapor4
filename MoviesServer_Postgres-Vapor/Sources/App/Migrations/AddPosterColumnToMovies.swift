//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 23/10/20.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct AddPosterColumnToMovies: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies") // Table name
            .field("poster", .string) // Column name
            .update()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .deleteField("poster")
            .delete()
    }
}
