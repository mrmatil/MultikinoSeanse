//
//  getJsonFromURL.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 29/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation

class getJsonFromURL{
    
    private var url:String
    private var completionHandler: (String)->Void
    
    init(url:String, completionHandler:@escaping (String)->Void) {
        self.url=url
        self.completionHandler=completionHandler
    }
    
    func downloadStandardData(){
        guard let jsonUrl = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: jsonUrl) { (data, response, error) in
            guard let data = data else {return}
            guard let dataString = String(data: data, encoding: String.Encoding.utf8) else {return}
            self.completionHandler(dataString)
        }
        task.resume()
    }
}
