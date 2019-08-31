//
//  changeDateLayout.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 31/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation

class changeDateLayout{
    
    static func changeFromYearFirstToYearLast(date:String)->String{
        let dateTempArray = date.split(separator: "-")
        return "\(dateTempArray[2])-\(dateTempArray[1])-\(dateTempArray[0])"
    }
}
