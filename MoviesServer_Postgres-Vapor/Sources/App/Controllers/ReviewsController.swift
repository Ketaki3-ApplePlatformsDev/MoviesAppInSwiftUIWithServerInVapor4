//
//  File.swift
//  
//
//  Created by Ketaki Mahaveer Kurade on 25/10/20.
//

import Foundation
import  Vapor
import Fluent

final class ReviewsController {
    func create(_ request: Request) throws -> EventLoopFuture<Review> {
        let review = try request.content.decode(Review.self)
        return review.save(on: request.db).map {
            review
        }
    }
    
    func getByMovieID(_ request: Request) throws -> EventLoopFuture<[Review]> {
        guard let movieId = request.parameters.get("movieId", as: UUID.self) else {
            throw Abort(.notFound)
        }
        
        return Review.query(on: request.db).filter(\.$movie.$id, .equal, movieId)
            .with(\.$movie)
            .all()
    }
}
