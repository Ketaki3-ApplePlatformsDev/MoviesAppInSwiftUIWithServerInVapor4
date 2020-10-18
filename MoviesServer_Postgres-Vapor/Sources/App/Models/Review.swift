//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 18/10/20.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class Review: Model, Content {
    static let schema = "reviews"
    
    @ID(key: .id) // PRimary key
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    // hasMany - Movie has many reviews
    @Parent(key: "movie_id") // Foreign key
    var movie: Movie
    
    init() {
    }
    
    init(id: UUID? = nil, title: String, body: String, movieId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movieId
    }
}
