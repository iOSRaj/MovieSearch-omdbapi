//
//  SearchResultCell.swift
//  MovieSearch
//
//  Created by Raj  .
//  Copyright (c) 2016 Raj. All rights reserved.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!

    func setupWithPhoto(moviePhoto: MovieInfo) {
        resultTitleLabel.text = moviePhoto.title

        if let imagePoster = moviePhoto.poster
        where moviePhoto.poster?.absoluteString != "N/A" {
            resultImageView.downloadImage(imagePoster)
        }
    }

}

extension UIImageView {
    func imageFromUrl(url: NSURL?, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            completion(data: NSData(data: data!))
        }.resume()
    }

    func downloadImage(url: NSURL?) {
        imageFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode = UIViewContentMode.ScaleAspectFit
                self.image = UIImage(data: data!)
            }
        }

    }
}
