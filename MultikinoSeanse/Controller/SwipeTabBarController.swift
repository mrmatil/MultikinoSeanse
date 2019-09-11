//
//  SwipeTabBarController.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 11/09/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwipeableTabBarController

class SwipeTabBarController: SwipeableTabBarController {
    override func viewDidLoad() {
        swipeAnimatedTransitioning?.animationType = SwipeAnimationType.sideBySide
        isSwipeEnabled = true
    }
}
