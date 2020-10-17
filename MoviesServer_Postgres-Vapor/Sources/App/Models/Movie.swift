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
    
    init() {
    }
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
