//
//  HTTPReviewClient.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 25/10/20.
//

import Foundation

class HTTPReviewClient: ObservableObject {
    @Published var reviews: [Review]? = [Review]()
    
    func getReviewsByMovie(movie: Movie) {
        guard let uuid = movie.id, let url = URL(string: "http://localhost:8080/movies/\(uuid.uuidString)/reviews") else {
            fatalError("URL is not defined.")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
           
            guard let data = data, error == nil else {
                return
            }
            
            if let decodedReviews = try? JSONDecoder().decode([Review].self, from: data) {
                DispatchQueue.main.async {
                    self.reviews = decodedReviews
                }
            }
        }.resume()
    }
    
    func saveReview(review: Review, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/reviews") else {
            fatalError("URL is not defined.")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(review)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
}
