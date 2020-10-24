//
//  ContentView.swift
//  MoviesApp_SwiftUI
//
//  Created by Ketaki Mahaveer Kurade on 24/10/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @Environment(\.presentationMode) var presentationMode
    let screenSize = UIScreen.main.bounds
    @ObservedObject var httpMovieClient = HTTPMovieClient()

    var body: some View {
        
        NavigationView {
            List(self.httpMovieClient.movies, id: \.id) { movie in
                
                VStack {
                    Image(movie.poster)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(movie.title)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .font(.system(size: 25))
                        .cornerRadius(10)
                }
                
            }
                
                
        .navigationBarTitle("Movies")
            .navigationBarItems(trailing: Button(action: {
                self.isPresented = true
            }){
                Image(systemName: "plus")
            })
            
            .onAppear {
                self.httpMovieClient.getAllMovies()
            }
        }.sheet(isPresented: $isPresented, onDismiss: {
            self.httpMovieClient.getAllMovies()
        }, content: {
            AddMovieView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
