import Fluent
import Vapor

func routes(_ app: Application) throws {
    let moviesContrller = MoviesController()
    let reviewsController = ReviewsController()
    
    // localhost:8080/movies POST
    app.post("movies", use: moviesContrller.create)
    
    // localhost:8080/movies GET
    app.get("movies", use: moviesContrller.all)
    
    // localhost:8080/movies/:movieId DELETE
    app.delete("movies", ":movieId", use: moviesContrller.delete)
     
    // localhost:8080/reviews POST
    app.post("reviews", use: reviewsController.create)
    
    // localhost:8080/movies/:movieId/reviews GET
    app.get("movies", ":movieId", "reviews", use: reviewsController.getByMovieID)
    /*
    // /movie/:movieId/actor/:actorId
    app.post("movie", ":movieId", "actor", ":actorId") { request -> EventLoopFuture<HTTPStatus> in
        // get the movie
        let movie = Movie.find(request.parameters.get("movieId"), on: request.db)
            .unwrap(or: Abort(.notFound))
        
        // get the actor
        let actor = Actor.find(request.parameters.get("actorId"), on: request.db)
            .unwrap(or: Abort(.notFound))
        
        return movie.and(actor).flatMap { (movie, actor) in
            movie.$actors.attach(actor, on: request.db)
        }.transform(to: .ok)
    }
    
    
    // /actors GET
    app.get("actors") { request in
        Actor.query(on: request.db).with(\.$movies).all()
    }
    
    // /actors POST
    app.post("actors") { request -> EventLoopFuture<Actor> in
        let actor = try request.content.decode(Actor.self) // Content = body of http request
        return actor.create(on: request.db).map { actor }
    }
    
    
    // /movies
    app.get("movies") { request in
        Movie.query(on: request.db).with(\.$reviews).with(\.$actors).all()
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
 */
}
