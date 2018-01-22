//
//  ViewController.swift
//  Flix
//
//  Created by Kyle Ohanian on 1/14/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import AlamofireImage

class CustomMovieView: UITableViewCell {
   
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var movieDesc: UITextView!
    var arrID: Int!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     var movies: [[String: Any]] = []
    
    @IBOutlet weak var movieView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieView") as! CustomMovieView
        let movie = movies[indexPath.row]
        let mTitle = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.title.text = mTitle
        cell.movieDesc.text = overview
        cell.arrID = indexPath.row
        if let pic = movie["poster_path"] as?
            String {
            let strURL = "http://image.tmdb.org/t/p/original/" + pic
            print(strURL)
            let url = URL(string: strURL)
            cell.movieImage.af_setImage(withURL: url!)

        }
        else {
            print("This image does not exist")
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movieView.dataSource = self
        movieView.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        movieView.insertSubview(refreshControl, at: 0)

        movieView.rowHeight = 250
        doStuff()
        
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        self.pleaseWait()
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                
                self.movieView.reloadData()
                refreshControl.endRefreshing()
                self.clearAllNotice()
                
            }
        }
        task.resume()
    }
    
    func doStuff() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                self.movieView.reloadData()
                
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! MovieDetailsController
        let cellSender = sender as! CustomMovieView
        let movie = movies[cellSender.arrID]
        let mTitle = movie["title"] as! String
        let overview = movie["overview"] as! String
        let date = movie["release_date"] as! String
        let backdrop = movie["backdrop_path"] as! String
        let posterpath = movie["poster_path"] as! String
        destinationViewController.dateString = date
        destinationViewController.descriptionString = overview
        destinationViewController.titleString = mTitle
        destinationViewController.backdropString = backdrop
        destinationViewController.posterString = posterpath
    }


}

