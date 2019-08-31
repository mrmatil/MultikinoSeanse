//
//  GetDatesList.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 31/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwiftyJSON

class GetDatesList{
    
    private var completionHandler:([DatesArray])->Void
    private var datesArray = [DatesArray]()
    
    init(completionHandler:@escaping ([DatesArray])->Void) {
        self.completionHandler=completionHandler
    }
    
    func getList(){
        getJsonFromURL.init(url: AllUrls.datesList, completionHandler: parseJson).downloadStandardData()
    }
    
    private func parseJson(json:String){
        guard let dataFromString = json.data(using: .utf8, allowLossyConversion: false) else {return}
        let jsonFromString = try! JSON(data: dataFromString)
        
        let array = jsonFromString["days"].array!
        
        for temp in array{
            guard let weekName = temp["name"].string else {continue}
            guard let date = temp["code"].string else {continue}
            
            datesArray.append(DatesArray(date: date, weekName: weekName))
        }
        completionHandler(datesArray)

    }
}
