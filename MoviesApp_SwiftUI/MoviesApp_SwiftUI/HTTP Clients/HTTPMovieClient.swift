//
//  HTTPMovieClient.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 24/10/20.
//

import Foundation

class HTTPMovieClient: ObservableObject {
    @Published var movies: [Movie] = [Movie]()
    
    func getAllMovies() {
        guard let url = URL(string: "http://localhost:8080/movies") else {
            fatalError("URL is not defined.")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
           
            guard let data = data, error == nil else {
                return
            }
            
            let movies = try? JSONDecoder().decode([Movie].self, from: data)
            
            if let movies = movies {
                DispatchQueue.main.async {
                    self.movies = movies
                }
            }
        }.resume()
    }
    
    func saveMovie(name: String, poster: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/movies") else {
            fatalError("URL is not defined.")
        }
        
        let movie = Movie(title: name, poster: poster)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(movie)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
}
