import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // /movies
    app.get("movies") { request in
        Movie.query(on: request.db).with(\.$reviews).all()
    }
    
    // /movies/id
    app.get("movies",":movieId") { request -> EventLoopFuture<Movie> in
        Movie.find(request.parameters.get("movieId"), on: request.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // /movies PUT
    app.put("movies") { request -> EventLoopFuture<HTTPStatus> in
        let movie = try request.content.decode(Movie.self)
        
        return Movie.find(movie.id, on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = movie.title
                return $0.update(on: request.db).transform(to: .ok)
            }
    }
    
    // /movies/id DELETE
    app.delete("movies", ":movieId") { request -> EventLoopFuture<HTTPStatus> in
        Movie.find(request.parameters.get("movieId"), on: request.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: request.db)
            }
            .transform(to: .ok)
    }
    
    // /movies POST
    app.post("movies") { request -> EventLoopFuture<Movie> in
        let movie = try request.content.decode(Movie.self) // Content = body of http request
         return movie.create(on: request.db).map { movie }
    }
    
    // /reviews POST
    app.post("reviews") { request -> EventLoopFuture<Review> in
        let review = try request.content.decode(Review.self) // Content = body of http request
        return review.create(on: request.db).map { review }
    }
}
