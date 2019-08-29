//
//  ViewController.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 28/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class CinemaPickViewController: UIViewController {

    
    //variables
    var cinema:String = ""
    var cinemaID:String = ""
    var cinemasArray = [CinemaListArray]()
    
    //IBOutlets:
    @IBOutlet weak var cinemasPickerView: UIPickerView!
    
    //IBActions:
    @IBAction func okButtonPressed(_ sender: UIButton) {
        //stuff
    }
    
    //functions:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetCinemasList.init(completionHandler: { (cinemasList) in
            self.cinemasArray.append(contentsOf: cinemasList)
                
            print(self.cinemasArray)
            self.enablePickerView()
        }).getList()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //stuff
    }
}

extension CinemaPickViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func enablePickerView(){
        
        DispatchQueue.main.async {
            self.cinemasPickerView.delegate = self
            self.cinemasPickerView.dataSource = self
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cinemasArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: cinemasArray[row].name, attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
    }
    
    
}

