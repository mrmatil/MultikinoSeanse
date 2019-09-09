//
//  moreMoviesInfo.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 07/09/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit
import SafariServices

class moreMoviesInfo{
    
    let moviesArray:MoviesArray?
    let view:UIViewController
    let multikinoBaseUrl = "https://multikino.pl"
    
    init(moviesArray:MoviesArray, view:UIViewController) {
        self.moviesArray=moviesArray
        self.view=view
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Wybierz akcje:",
                                      message: "",
                                      preferredStyle: .actionSheet)
        
        //cancel button
        let cancelButton = UIAlertAction(title: "wróć", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        
        //movies trailer button
        if moviesArray?.trailerUrl != ""{
            let movieTrailerButton = UIAlertAction(title: "Zobacz Trailer", style: .default) { (UIAlertAction) in
                self.showWebsite(url: self.moviesArray!.trailerUrl)
            }
            alert.addAction(movieTrailerButton)
        }
        
        //movie url button
        if moviesArray?.movieUrl != ""{
            let movieUrlButton = UIAlertAction(title: "Zobacz stronę filmu", style: .default) { (UIAlertAction) in
                self.showWebsite(url: self.multikinoBaseUrl + self.moviesArray!.movieUrl)
            }
            alert.addAction(movieUrlButton)
        }
        
        if moviesArray?.time.count == moviesArray?.buyTicketWebsite.count{
            for temp in 0...moviesArray!.time.count-1{
                let movieButton = UIAlertAction(title: "Film:" + moviesArray!.time[temp], style: .default) { (UIAlertAction) in
                    self.showWebsite(url: self.multikinoBaseUrl + self.moviesArray!.buyTicketWebsite[temp])
                }
                alert.addAction(movieButton)
            }
        }
        
        view.present(alert,animated: true,completion: nil)
        
    }
    
    private func showWebsite(url:String){
        let svc = SFSafariViewController(url: URL(string: url) ?? URL(string: multikinoBaseUrl)!)
        view.present(svc, animated: true, completion: nil)
    }
}
