//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    //var businesses: [NSDictionary]?
    lazy var searchBar = UISearchBar()
   // var businessSearch = Business(dictionary: filteredData)
    var searchTerm = appDelegate.searchWord
    var filteredDict = NSDictionary()
    var filteredData: [Business]!
    var otherBusiness: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = self.tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        /*Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )*/
        
         //Example of Yelp search with more search options specified
        Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
         self.businesses = businesses
         self.otherBusiness = businesses
         self.tableView.reloadData()
            if let businesses = businesses {
         for business in businesses {
         print(business.name!)
         print(business.address!)
                }
            }
        }
        )
    
        
        
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.otherBusiness = businesses
                self.tableView.reloadData()
            })
            searchBar.endEditing(false)
        } else {
            
            searchReload()
            self.tableView.reloadData()
        }
    }
           // let filter = Business(dictionary: filteredDict)
       /*     self.filteredData = self.businesses!.filter{ (data: Business) -> Bool in
                if let businesses = businesses {
                    for business in businesses {
                        let name = business.name
                        let range = name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)
                        if range == nil {
                            // no match
                            return false
                        } else if name?.distance(from: (name?.startIndex)!, to: range!.lowerBound) == 0 {
                            // match is at beginning of movie title
                            return true
                        } else {
                            // match is elsewhere within the movie title
                            return false
                    }
                }
                
        }
                self.tableView.reloadData()
                return true
    }
        }
    }*/
    func searchReload(){
        
        appDelegate.searchWord = searchTerm
        searchTerm = searchBar.text!

            
        
        Business.searchWithTerm(term: searchTerm, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
            for business in businesses {
            print(business.name!)
            print(business.address!)
            }
        }
        }
        )
        
    self.businesses = otherBusiness
    self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }

        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row];
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
