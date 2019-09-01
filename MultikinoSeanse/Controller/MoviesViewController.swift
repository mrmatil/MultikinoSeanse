//
//  MoviesViewController.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 30/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    //variables:
    var datesArray = [DatesArray]()
    var currentDate:String?
    
    var currentCinemaName:String?
    var currentCinemaId:String?
    
    //IBOutlets:
    @IBOutlet weak var pickDateTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDatesList.init(completionHandler: { (datesArrayTemp) in
            self.datesArray.append(contentsOf: datesArrayTemp)
            self.currentDate = datesArrayTemp[0].date
            self.enablePickerView()
            self.getMoviesList()
        }).getList()
    }
    
    private func getMoviesList(){
        GetMoviesList(date: currentDate!, cinemaId: currentCinemaId!) { (moviesArray) in
            print(moviesArray)
            print("KONIEC")
        }.getList()
    }
    
    
    
}

extension MoviesViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func enablePickerView(){
        DispatchQueue.main.async {
            let datePickerView = UIPickerView()
            datePickerView.delegate = self
            datePickerView.dataSource = self
            datePickerView.backgroundColor = .black
            self.pickDateTextField.inputView=datePickerView
            self.enableToolbar()
        }
    }
    
    func enableToolbar(){
        let toolbar = UIToolbar()
        toolbar.barTintColor = .black
        
        let okButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: nil)
        okButton.tintColor = .white
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cofnij", style: .done, target: self, action: nil)
        cancelButton.tintColor = .white
        
        toolbar.sizeToFit()
        toolbar.setItems([cancelButton,space,okButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        pickDateTextField.inputAccessoryView = toolbar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return datesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let tempDate = datesArray[row].date
        let tempWeekDate = datesArray[row].weekName
        return NSAttributedString(string: "\(tempDate) (\(tempWeekDate))", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                                                        NSAttributedString.Key.backgroundColor:UIColor.black])
    }
    
}

//extension MoviesViewController:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}
