//
//  Review.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 25/10/20.
//

import Foundation


struct Review: Codable {
    var id: UUID?
    var title: String
    var body: String
    var movie: Movie
    
    
}
