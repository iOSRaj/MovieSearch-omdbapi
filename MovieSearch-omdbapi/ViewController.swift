//
//  ViewController.swift
//  MovieSearch-omdbapi
//
//  Created by Raj .
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    var info: [MovieInfo] = []
    
    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchResultCellIdentifier = "SearchResultCell"
        let cell = self.tableView.dequeueReusableCellWithIdentifier(searchResultCellIdentifier, forIndexPath: indexPath) as? SearchResultCell
        cell!.setupWithPhoto(info[indexPath.row])
        return cell!
    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("movieDetail", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - UISearchBarDelegate

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearchWithText(searchBar.text!)
        self.info.removeAll()
    }

    // MARK - Segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "movieDetail" {
            let movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            movieDetailViewController.movieInfo = info[selectedIndexPath!.row]
        }
    }

    // MARK: - Private

    private func performSearchWithText(searchText: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        DataProvider.fetchMovieInfoForSearchText(searchText, onCompletion: { (error: NSError?, movieInfos: [MovieInfo]?) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if error == nil {
                self.info = movieInfos!
            } else {
                self.info = []
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showErrorAlert()
                    })
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.title = searchText
                self.tableView.reloadData()
            })
        })
    }

    private func showErrorAlert() {
        let alertController = UIAlertController(title: "Search Error", message: "Internal Error", preferredStyle: .Alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .Default) { (action) in

        }
        alertController.addAction(dismissAction)
        self.presentViewController(alertController, animated: true) {

        }
    }

}

