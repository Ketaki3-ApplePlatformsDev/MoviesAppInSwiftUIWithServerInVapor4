//
//  MovieDetailsView.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 25/10/20.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let movie: Movie
    
    
    @State private var reviewTitle: String = ""
    @State private var reviewBody: String = ""
    
    @ObservedObject private var httpReviewClient = HTTPReviewClient()
    
    @Environment(\.presentationMode) private var presentationMode
    
    private func deleteMovie() {
        HTTPMovieClient().deleteMovie(movie: movie)  { success in
            DispatchQueue.main.async {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func saveReview() {
        let review = Review(title: self.reviewTitle, body: self.reviewBody, movie: self.movie)
        HTTPReviewClient().saveReview(review: review) { success in
            if success {
                self.httpReviewClient.getReviewsByMovie(movie: self.movie)
            }
        }
        self.reviewTitle = ""
        self.reviewBody = ""
    }
    
    var body: some View {
        
        Form {
            
            Image(movie.poster)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Section(header: Text("ADD A REVIEW").fontWeight(.bold)) {
                VStack(alignment: .center, spacing: 10) {
                    TextField("Enter Title",text: $reviewTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Body",text: $reviewBody) .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Save") {
                        self.saveReview()
                    }
                }
                
            }
            
            Section(header: Text("REVIEWS").fontWeight(.bold)) {
                ForEach(self.httpReviewClient.reviews ?? [Review](), id: \.id) { review in
                    Text(review.title)
                }
            }
        }
        
        .onAppear(perform: {
            self.httpReviewClient.getReviewsByMovie(movie: self.movie)
        })
        
        .navigationBarTitle(movie.title)
            
        .navigationBarItems(trailing: Button(action: {
            self.deleteMovie()
        }) {
            Image(systemName: "trash.fill")
        })
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(title: "Birds of Prey", poster: "birds"))
    }
}
