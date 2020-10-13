//
//  requests.swift
//  networking101
//
//  Created by Ron Machoka on 10/12/20.
//

import SwiftUI
import Foundation
import Alamofire


class Movies: ObservableObject, Identifiable{
    var id: Int
    @Published var title: String
    @Published var openingCrawl: String
    @Published var director: String
    
    init(id: Int, title: String, openingCrawl: String, director: String){
        self.id = id
        self.title = title
        self.openingCrawl = openingCrawl
        self.director = director
        
    }
}

class dataPassing: ObservableObject {
    @Published var moviesArray = [Film]()
}


struct requests: View {
    @ObservedObject var dataPassingInstance = dataPassing()
    
    //Function For requesting the moview the movies
    func fetchFilms() {
        AF.request("https://swapi.dev/api/films")
            .validate()
            .responseDecodable(of: Films.self) { (response) in
                guard let films = response.value else { return }
                
                
                for i in 0..<films.all.count{
                    var FilmInstance = Film(id: films.all[i].id,
                                            title: films.all[i].title,
                                            openingCrawl: films.all[i].openingCrawl,
                                            director: films.all[i].director,
                                            producer: films.all[i].producer,
                                            releaseDate: films.all[i].releaseDate,
                                            starships: films.all[i].starships)
                    
                    dataPassingInstance.moviesArray.append(FilmInstance)
                    print("Added to Array")
                }
            }
        
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
            ForEach(dataPassingInstance.moviesArray) { movie in
                    VStack(alignment: .leading){
                        Text("Title : \(movie.title)")
                        Text("Director : \(movie.director)")
                        Text("Producer : \(movie.producer)")
                        Divider()
                    }.padding()
                
            }
            
            
            }
            
            
        }.onAppear(perform: {
            fetchFilms()
        })
    }
}



struct requests_Previews: PreviewProvider {
    @ObservedObject var myMovies : Movies
    static var previews: some View {
        requests()
    }
}
