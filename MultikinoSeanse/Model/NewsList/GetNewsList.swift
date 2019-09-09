//
//  GetNewsList.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 09/09/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetNewsList{
    
    //variables:
    var cinemaId:String
    var completionHandler: ([NewsArray])->Void
    
    init(cinemaId:String,completionHandler: @escaping ([NewsArray])->Void ) {
        self.cinemaId=cinemaId
        self.completionHandler=completionHandler
    }
    
    func getList(){
        let url = AllUrls.newsList + cinemaId
        getJsonFromURL(url: url, completionHandler: parseJson).downloadStandardData()
    }
    
    private func parseJson (json:String){
        guard let dataFromString = json.data(using: .utf8, allowLossyConversion: false) else {return}
        let jsonFromString = try! JSON(data: dataFromString)
        
        let array = jsonFromString.array
        
        var newsArray = [NewsArray]()
        
        for temp in array!{
            let tempNews = NewsArray(title: temp["Title"].string!,
                                     content: temp["Description"].string!,
                                     imageUrl: temp["ImageURL"].string!,
                                     linkUrl: temp["Link"].string!)
            newsArray.append(tempNews)
        }
        
        completionHandler(newsArray)
    }
}
