//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 23/10/20.
//

import Foundation
import Vapor

final class MoviesController {
    func create(_ request: Request) throws -> EventLoopFuture<Movie> {
        let movie = try request.content.decode(Movie.self)
        return movie.create(on: request.db).map {
            movie
        }
    }
    
    func all(_ request: Request) throws -> EventLoopFuture<[Movie]> {
        Movie.query(on: request.db).all()
    }
    
    func delete(_ request: Request) throws -> EventLoopFuture<HTTPStatus> {
        Movie.find(request.parameters.get("movieId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: request.db)
            }.transform(to: .ok)
    }
}
