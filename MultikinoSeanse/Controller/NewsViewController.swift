//
//  NewsViewController.swift
//  MultikinoSeanse
//
//  Created by Mateusz Łukasiński on 08/09/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    
    //IBoutlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    
    //variables
    var newsArray = [NewsArray]()
    let multikinoBaseUrl = "https://multikino.pl"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        // Do any additional setup after loading the view.
    }
    
    func getNews(){
        let ud = UserDefaults()
        GetNewsList(cinemaId: ud.string(forKey: "cinemaID")!) { (newsArray) in
            self.newsArray=newsArray
            self.enableTableView()
        }.getList()
    }
    
    
}



extension NewsViewController:UITableViewDelegate,UITableViewDataSource{
    
    func enableTableView(){
        DispatchQueue.main.async {
            self.newsTableView.delegate = self
            self.newsTableView.dataSource = self
            self.newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCustomCell")
            self.newsTableView.estimatedRowHeight = 240.0
            self.newsTableView.rowHeight = UITableView.automaticDimension
            self.newsTableView.separatorStyle = .none
            self.newsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCustomCell", for: indexPath) as! NewsTableViewCell
        cell.title.text = newsArray[indexPath.row].title
        cell.body.text = newsArray[indexPath.row].content
        cell.urlForImage = multikinoBaseUrl + newsArray[indexPath.row].imageUrl
        return cell
    }
    
    
}
