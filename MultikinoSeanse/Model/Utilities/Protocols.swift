//
//  Protocols.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 08/09/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation

//from Cinema Pick to Movies View
protocol cityIdChangedDelegate {
    func getCityId(cinemaID:String,cinemaName:String)
}
