//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 18/10/20.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors") // Table name
            .id()
            .field("name", .string) // Column name
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("actors")
            .delete() // Drop table
    }
}

