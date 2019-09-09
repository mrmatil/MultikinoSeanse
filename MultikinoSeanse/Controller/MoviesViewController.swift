//
//  MoviesViewController.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 30/08/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController{

    //variables:
    let ud = UserDefaults()
    var allDataArray:[MoviesArray]?
    
    var datesArray = [DatesArray]()
    var tempDate:String?
    var currentDate:String?
    
    var titles = [String]()
    var rank = [String]()
    var posterUrl = [String]()
    var times = [[String]]()
    
    //IBOutlets:
    @IBOutlet weak var pickDateTextField: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = "Miasto: " + ud.string(forKey: "cinemaName")!
        GetDatesList.init(completionHandler: { (datesArrayTemp) in
            self.datesArray.append(contentsOf: datesArrayTemp)
            self.currentDate = datesArrayTemp[0].date
            self.tempDate = datesArrayTemp[0].date
            self.enablePickerView()
            self.getMoviesList {
                self.enableMoviesTableView()
            }
        }).getList()
    }
    
    private func getMoviesList(completionHandler:@escaping ()->Void){
        GetMoviesList(date: currentDate!, cinemaId: ud.string(forKey: "cinemaID")!) { (moviesArray) in
            self.allDataArray=moviesArray
            self.titles = [String]()
            self.rank = [String]()
            self.posterUrl = [String]()
            self.times = [[String]]()
            
            var loop:Int = 0
            for x in moviesArray{
                self.titles.append(x.name)
                self.rank.append(x.rank)
                self.posterUrl.append(x.poster)
                self.times.append(x.time)
                
                loop += 1
                if loop == moviesArray.count-1{
                    completionHandler()
                }
            }
            
        }.getList()
    }
    
    func showDate(){
        pickDateTextField.text = "\(currentDate!)"
        pickDateTextField.textAlignment = .center
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
        
        let okButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(okButtonPressed))
        okButton.tintColor = .white
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cofnij", style: .done, target: self, action: #selector(hideKeyboard))
        cancelButton.tintColor = .white
        
        toolbar.sizeToFit()
        toolbar.setItems([cancelButton,space,okButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        pickDateTextField.inputAccessoryView = toolbar
    }
    
    @objc func okButtonPressed(){
        currentDate = tempDate
        
        getMoviesList {
            print(self.titles)
            DispatchQueue.main.async{
                print("Kurwa")
                self.moviesTableView.reloadData()
                self.enableMoviesTableView()
                self.hideKeyboard()
            }
        }

    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tempDate = datesArray[row].date
    }
    
}

extension MoviesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func enableMoviesTableView(){
        DispatchQueue.main.async{
            self.moviesTableView.delegate = self
            self.moviesTableView.dataSource = self
            self.moviesTableView.register(UINib(nibName: "MoviesTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomMoviesCell")
            self.moviesTableView.estimatedRowHeight = 190.0
            self.moviesTableView.rowHeight = UITableView.automaticDimension
            self.moviesTableView.separatorStyle = .none
            self.showDate()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMoviesCell", for: indexPath) as! MoviesTableViewCell
        cell.title.text = titles[indexPath.row]
        cell.score.text = rank[indexPath.row]
        cell.url = posterUrl[indexPath.row]
        
        var textk:String = ""
        
        for x in times[indexPath.row]{
            textk = textk + x + "\n"
        }
        
        cell.movieText.text = textk
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(allDataArray![indexPath.row])
        moreMoviesInfo.init(moviesArray: allDataArray![indexPath.row], view: self).showAlert()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
