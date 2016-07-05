//
//  MovieDetailViewController.swift
//  MovieSearch-omdbapi
//
//  Created by Raj .
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieInfo: MovieInfo?
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var moveiTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var genre: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieInfo?.title
        moveiTitle.text = movieInfo?.title
        movieYear.text = movieInfo?.year
        genre.text = movieInfo?.genre
        if let imagePoster = movieInfo?.poster
        where movieInfo?.poster?.absoluteString != "N/A" {
            posterImage.downloadImage(imagePoster)
        }
    }
}
