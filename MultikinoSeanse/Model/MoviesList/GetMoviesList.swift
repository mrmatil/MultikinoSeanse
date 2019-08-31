//
//  GetMoviesList.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 31/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation

class GetMoviesList{
    
    var date:String
    var completionHandler:([MoviesArray])->Void
    
    init(date:String,completionHandler:@escaping ([MoviesArray])->Void) {
        self.date=date
        self.completionHandler=completionHandler
    }
    
    func getList(){
        getJsonFromURL(url: AllUrls.moviesList1+date+AllUrls.moviesList2, completionHandler: parseJson).downloadStandardData()
    }
    
    private func parseJson(json:String){
        
    }
}
