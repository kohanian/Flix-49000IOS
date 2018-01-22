//
//  PostersController.swift
//  Flix
//
//  Created by Kyle Ohanian on 1/18/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class PostersCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCell: UIImageView!
}

class PostersController: UIViewController,
UICollectionViewDataSource, UICollectionViewDelegate {
    
    var movies: [[String: Any]] = []
    @IBOutlet weak var collectView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "PostersCell", for: indexPath) as! PostersCell
        let movie = movies[indexPath.row]
        if let pic = movie["poster_path"] as?
            String {
            let strURL = "http://image.tmdb.org/t/p/original/" + pic
            print(strURL)
            let url = URL(string: strURL)
            cell.imageViewCell.af_setImage(withURL: url!)
            
        }
        else {
            print("This image does not exist")
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectView.dataSource = self
        collectView.delegate = self
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String: Any]]
                
                self.collectView.reloadData()
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
