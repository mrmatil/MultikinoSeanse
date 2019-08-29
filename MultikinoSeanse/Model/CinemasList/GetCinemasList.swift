//
//  GetCinemasList.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 29/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetCinemasList{
    
    //variables:
    private var completionHandler: ([CinemaListArray])->Void
    private var cinemasArray = [CinemaListArray]()
    
    init(completionHandler:@escaping ([CinemaListArray])->Void) {
        self.completionHandler=completionHandler
    }
    
    func getList(){
        getJsonFromURL.init(url: AllUrls.cinemasList, completionHandler: parseJson).downloadStandardData()
    }
    
    private func parseJson(json:String){
        guard let dataFromString = json.data(using: .utf8, allowLossyConversion: false) else {return}
        let jsonFromString = try! JSON(data: dataFromString)
        
        let array = jsonFromString["cinemas"]["whatsOnCinemas"].array!
        
        for temp in array{
            guard let cinemaName = temp["CinemaName"].string else {return}
            guard let cinemaID = temp["CinemaId"].string else {return}
            
            cinemasArray.append(CinemaListArray(name: cinemaName, id: cinemaID))
        }
        completionHandler(cinemasArray)
    }
}
