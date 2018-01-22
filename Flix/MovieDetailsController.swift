//
//  MovieDetailsController.swift
//  Flix
//
//  Created by Kyle Ohanian on 1/18/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    
    @IBOutlet weak var backdropImage: UIImageView!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    var backdropString: String!
    var posterString: String!
    var titleString: String!
    var dateString: String!
    var descriptionString: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString
        dateLabel.text = dateString
        descriptionText.text = descriptionString
        
        if (posterString != nil) {
            let strURL = "http://image.tmdb.org/t/p/original/" + posterString
            print(strURL)
            let url = URL(string: strURL)
            mainImage.af_setImage(withURL: url!)
        }
        
        if (backdropString != nil) {
            let strURL = "http://image.tmdb.org/t/p/original/" + backdropString
            print(strURL)
            let url = URL(string: strURL)
            backdropImage.af_setImage(withURL: url!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
