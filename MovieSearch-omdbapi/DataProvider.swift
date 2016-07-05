//
//  MovieAPI.swift
//  MovieSearch
//
//  Created by Raj on  .
//  Copyright (c) 2016 Raj. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

private let _sharedInstance = DataProvider()

class DataProvider {
    
    typealias MovieResponse = (NSError?, [MovieInfo]?) -> Void
   
    //😉 Just an Experiment and It can be done in many ways

    struct Results {
        static var movieInfo: [MovieInfo]?
    }
    
    // Singleton for accesing the instance
    class func sharedInstance() -> DataProvider {
        return _sharedInstance
    }
    
    
    
   class func fetchMovieInfoForSearchText(searchText: String, onCompletion: MovieResponse) -> Void {
        
        let escapedSearchText: String = searchText.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        let urlString: String = "https://www.omdbapi.com/?t=\(escapedSearchText)&y=&plot=short&r=json"
        let url: NSURL = NSURL(string: urlString)!

        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { response in
                if response.result.value != nil {
                    Results.movieInfo = []
                    let jsonData = JSON(data: response.data!)
                    let activityList: MovieInfo = MovieInfo(data: jsonData)
                    Results.movieInfo?.append(activityList)
                    onCompletion(nil, Results.movieInfo)
                } else {
                    onCompletion(response.result.error, nil)
                }
               
        }
        
    
    }

}