//
//  GetMoviesList.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 31/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetMoviesList{
    
    var date:String
    var cinemaId:String
    var completionHandler:([MoviesArray])->Void
    
    init(date:String,cinemaId:String,completionHandler:@escaping ([MoviesArray])->Void) {
        self.date=date
        self.completionHandler=completionHandler
        self.cinemaId=cinemaId
    }
    
    func getList(){
        getJsonFromURL(url: AllUrls.moviesList1+cinemaId+AllUrls.moviesList2+date+AllUrls.moviesList3, completionHandler: parseJson).downloadStandardData()
    }
    
    private func parseJson(json:String){
        guard let dataFromString = json.data(using: .utf8, allowLossyConversion: false) else {return}
        let jsonFromString = try! JSON(data: dataFromString)
        
        let array = jsonFromString["WhatsOnAlphabeticFilms"].array!
        var moviesArray = [MoviesArray]()
        
        
        for temp in array{
            guard let movieTitle = temp["Title"].string else {continue}
            guard let rank = temp["RankValue"].string else {continue}
            var poster = ""
            if temp["Poster"].string != nil{
                poster = temp["Poster"].string!
            }
            var trailerUrl = ""
            if temp["TrailerUrl"].string != nil{
                trailerUrl = temp["TrailerUrl"].string!
            }
            guard let filmUrl = temp["FilmUrl"].string else {continue}
            
            guard let tempWhatsOnAlphabeticCinemas = temp["WhatsOnAlphabeticCinemas"].array else {continue}

            var ticketLinks = [String]()
            var times = [String]()
            var varsions = [String]()
            
            for temp2 in tempWhatsOnAlphabeticCinemas{
                guard let tempWhatsOnAlphabeticCinemas2 = temp2["WhatsOnAlphabeticCinemas"].array else {continue}
                for temp3 in tempWhatsOnAlphabeticCinemas2{
                    guard let tempWhatsOnAlphabeticShedules = temp3["WhatsOnAlphabeticShedules"].array else {continue}
                    for temp4 in tempWhatsOnAlphabeticShedules{
                        guard let ticket = temp4["BookingLink"].string else {continue}
                        ticketLinks.append(ticket)
                        guard let time = temp4["Time"].string else {continue}
                        times.append(time)
                        guard let version = temp4["VersionTitle"].string else {continue}
                        varsions.append(version)
                    }

                }
            }
//
//            print(ticketLinks)
//            print(times)
//            print(varsions)
            
            moviesArray.append(MoviesArray(name: movieTitle, time: times, buyTicketWebsite: ticketLinks, version: varsions, rank: rank, poster: poster, trailerUrl: trailerUrl, movieUrl: filmUrl))
        }
        
        completionHandler(moviesArray)
    }
}
