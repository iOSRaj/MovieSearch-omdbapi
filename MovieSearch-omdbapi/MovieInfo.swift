//
//  SearchResult.swift
//  MovieSearch
//
//  Created by Raj  .
//  Copyright (c) 2016 Raj. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct MovieInfo {

    let title: String?
    let year: String?
    let poster: NSURL?
    let rated: String?
    let genre: String?

    init(data: JSON) {
        self.title = data["Title"].stringValue
        self.year = data["Year"].stringValue
        self.poster = data["Poster"].URL
        self.rated = data["Rated"].stringValue
        self.genre = data["Genre"].stringValue
    }

}
