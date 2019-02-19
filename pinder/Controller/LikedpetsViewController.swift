//
//  LikedpetsViewController.swift
//  pinder
//
//  Created by Nineleaps on 13/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LikedpetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var petlist = [Pets]()
    var currentlikedpet = [Pets]()
    var searchactive = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var likedPetTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        likedpetinfoRetrival()
        setUpSearchBar()
    }
    // MARK: tableView implementation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchactive{
            return currentlikedpet.count
        }else{return petlist.count}
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LikedPetsTableCell") as! LikedPetsTableCell
        if searchactive {
            let likedpetlist = currentlikedpet[indexPath.row]
            cell.setLikedPetsTableCell(name: likedpetlist.name!, image: likedpetlist.image!, description: likedpetlist.description!)
            return cell
        } else {
            let likedpetlist = petlist[indexPath.row]
            cell.setLikedPetsTableCell(name: likedpetlist.name!, image: likedpetlist.image!, description: likedpetlist.description!)
            return cell
        }
    }
    // MARK: searchBar implemeantation
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchactive = false
        searchBar.text = ""
        likedPetTableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchactive = false
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchactive = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchactive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty
            else {
                self.searchactive = false
                likedPetTableView.reloadData()
                return }
        currentlikedpet = petlist.filter({likedpets -> Bool in
            likedpets.name!.contains(searchText) || likedpets.description!.contains(searchText)
        })
        self.searchactive = true
        likedPetTableView.reloadData()
    }
    
    // Mark: likedPets imformation from api
    func likedpetinfoRetrival() {
        apiCallWrapper.sharedInstance.requestForPetDataWith("likedPets", "pets/likes", parameters: nil, headers: nil) { (response) -> (Void) in
                print(response)
            if response!.response?.statusCode == 200 {
                if let petResponse = response!.result.value {
                        self.petlist = (petResponse.petResponseClass?.petData?.pets)!
                        self.currentlikedpet = self.petlist
                        self.likedPetTableView.delegate = self
                        self.likedPetTableView.dataSource = self
                        self.likedPetTableView.tableFooterView = UIView(frame: CGRect.zero)
                       // print(petResponse.petResponseClass?.petData?.pets!)
                    }
                }
        }
    }
}
