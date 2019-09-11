//
//  allURLs.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 29/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation

class AllUrls{
    
    //Cinemas List
    static let cinemasList:String = "https://multikino.pl/api/sitecore/data/GetCinemasAndLabels"
    
    //Dates List
    static let datesList:String = "https://multikino.pl/data/labels/"
    
    //Movies List
    static let moviesList1:String = "https://multikino.pl/api/sitecore/WhatsOn/WhatsOnV2Alphabetic?cinemaId="
    static let moviesList2:String = "&data="
    static let moviesList3:String = "&type=teraz-gramy"
    
    //News List
    static let newsList:String = "https://multikino.pl/api/sitecore/WhatsOn/NewsInCinema?cinemaId="
    
    //Info List
    static let infoList:String = "https://multikino.pl/api/sitecore/WhatsOn/WhatsOnV2CinemaInfo?cinemaId="
}
