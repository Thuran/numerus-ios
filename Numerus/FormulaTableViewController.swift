//
//  FormulaTableViewController.swift
//  Numerus
//
//  Created by Thuran on 16/05/17.
//  Copyright © 2017 Webtouch. All rights reserved.
//

import UIKit
import RealmSwift

class FormulaTableViewController: UITableViewController, UISearchResultsUpdating {

    let realm = try! Realm()
    var list: [FormulaRead] = [FormulaRead]()
    var filteredList: [FormulaRead] = [FormulaRead]()
    var resultSearchController: UISearchController!
    var searchString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        resultSearchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = resultSearchController.searchBar
        FormulaRead.list() { (formulaListResponse, err) in
            if(err == nil){
                
                self.list = formulaListResponse
                self.tableView.delegate = self
                self.tableView.reloadData()
            }
        }
        
        
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func handleRefresh() {
        
        FormulaRead.list() { (formulaListResponse, err) in
            if(err == nil){
                self.list = formulaListResponse
                self.tableView.delegate = self
                self.tableView.reloadData()
            }
        }
        
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController){
        if (searchController.searchBar.text?.characters.count)! > 0 {
            
            self.searchString = (searchController.searchBar.text)!
           /* filteredList = list.map { (formula) -> Formula in
                if(formula.name?.contains(searchString))!{
                    filteredList.append(formula)
                    return formula
                }
            }*/
            filteredList = list.filter{ ($0.name?.contains(searchString))! }
            self.tableView.delegate = self
            self.tableView.reloadData()
            

            
        }
        else {
            
            self.filteredList = self.list
            
            self.tableView.reloadData()
            
        }
    }
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (resultSearchController.isActive) {
            return self.filteredList.count
        }else{
            return list.count
        }
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formulaCell", for: indexPath) as! FormulaTableViewCell
        
        var formula = list[indexPath.row]
        if (resultSearchController.isActive) {
            formula = self.filteredList[indexPath.row]
        }else{
            formula =  self.list[indexPath.row]
        }
        
        
        if let url = URL(string: formula.author!.photo) {
            if let data = NSData.init(contentsOf: url) {
                cell.authorImage.image = UIImage(data: data as Data)
            }        
        }
        cell.authorImage.layer.cornerRadius = 0.5 * cell.authorImage.bounds.size.width
        cell.authorImage.clipsToBounds = true
        cell.authorNameLabel.text = formula.author?.name
        cell.formulaNameLabel.text = formula.name
        cell.ratingLabel.text = formula.rating
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usingFormula = self.storyboard?.instantiateViewController(withIdentifier: "usingFormulaViewController") as! UsingFormulaViewController
        let row = indexPath.row
        let formula: FormulaRead?
        if (resultSearchController.isActive) {
            formula = self.filteredList[row]
        }else{
            formula =  self.list[row]
        }
        
        usingFormula.authorImageString = (formula?.author?.photo)!
        usingFormula.authorNameString = (formula?.author?.name)!
        usingFormula.expressionString = (formula?.context)!
        usingFormula.formulaNameString = (formula?.name)!
        usingFormula.ratingString = (formula?.rating)!
        
        self.navigationController?.pushViewController(usingFormula, animated: true)
        
        
    }

}
