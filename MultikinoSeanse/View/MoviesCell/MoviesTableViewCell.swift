//
//  MoviesTableViewCell.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 02/09/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var movieText: UILabel!
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
