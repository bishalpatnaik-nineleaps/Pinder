////
////  SwipeViewController.swift
////  pinder
////
////  Created by Nineleaps on 11/02/19.
////  Copyright © 2019 Nineleaps. All rights reserved.
////
//
import UIKit
import Pods_pinder
import Poi
import Alamofire
import SwiftKeychainWrapper

var token = KeychainWrapper.standard.string(forKey: "retrivedToken")!

class SwipeViewController: UIViewController, PoiViewDelegate, PoiViewDataSource {
    //var PetResponse: PetResponse?
    var petlist = [Pets]()
    var sampleCards = [Card]()
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let userSessionKeyRemoved: Bool = KeychainWrapper.standard.removeObject(forKey: "retrivedToken")
        apiCallWrapper.sharedInstance.requestForLoginDataWith("logout", parameters: nil, headers: nil) { (response) -> (Void) in
                if userSessionKeyRemoved {
                    if response.response?.statusCode == 200 {
                        self.performSegue(withIdentifier: "Logout_segue", sender: self)
                    }
                }
        }
    }
    @IBOutlet weak var poiView: PoiView!
    override func viewDidLoad() {
        super.viewDidLoad()
        infoRetrival()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func infoRetrival() {
        let headers: HTTPHeaders = ["Authorization": token]

        apiCallWrapper.sharedInstance.requestForPetDataWith("retriveAllPets", "pets", parameters: nil, headers: headers) { (response) -> (Void) in
                print(response)
            if response!.response?.statusCode == 200 {
                if let petResponse = response!.result.value {
                        self.petlist = (petResponse.petResponseClass?.petData?.pets)!
                        self.createViews()
                        self.poiView.delegate = self
                        self.poiView.dataSource = self
                    }
                }
        }
    }
    private func createViews() {
        for arrayIndex in (0..<self.petlist.count) {
            // swiftlint:disable force_cast
            let card = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! Card
            // swiftlint:enable force_cast
            card.prepareUI(text: petlist[arrayIndex].name!, img: petlist[arrayIndex].image!, des: petlist[arrayIndex].description!)
            sampleCards.append(card)
        }
    }
    // MARK: PoiViewDataSource
    func numberOfCards(_ poi: PoiView) -> Int {
        if (self.petlist.count != nil) && (self.petlist.count>0) {
            return self.petlist.count
        } else {
            return 0
        }
    }
    func poi(_ poi: PoiView, viewForCardAt index: Int) -> UIView {
        return sampleCards[index]
    }
    func poi(_ poi: PoiView, viewForCardOverlayFor direction: SwipeDirection) -> UIImageView? {
        switch direction {
        case .right:
            let good = UIImageView(image: #imageLiteral(resourceName: "good"))
            good.tintColor = UIColor.green
            return good
        case .left:
            let bad = UIImageView(image: #imageLiteral(resourceName: "bad"))
            bad.tintColor = UIColor.red
            return bad
        }
    }
    // MARK: PoiViewDelegate
    func poi(_ poi: PoiView, didSwipeCardAt: Int, in direction: SwipeDirection) {
        let urlString = "pets/likes/" + petlist[didSwipeCardAt-1].id!
        let headers: HTTPHeaders = ["Authorization": token]
        let falseParameters: [String: Bool] = [ "liked" : false ]
        let trueParameters: [String: Bool] = [ "liked" : true ]
        switch direction {
        case .left:
            apiCallWrapper.sharedInstance.requestForPetDataWith("updateLikedPets", urlString, parameters: falseParameters, headers: headers) { (response) -> (Void) in}
        case .right:
            apiCallWrapper.sharedInstance.requestForPetDataWith("updateLikedPets", urlString, parameters: trueParameters, headers: headers) { (response) -> (Void) in}

        }
    }
    func poi(_ poi: PoiView, runOutOfCardAt: Int, in direction: SwipeDirection) {
        print("last")
    }
    // MARK: IBAction
    @IBAction func OKAction(_ sender: UIButton) {
        poiView.swipeCurrentCard(to: .right)
    }
    @IBAction func cancelAction(_ sender: UIButton) {
        poiView.swipeCurrentCard(to: .left)
    }
    @IBAction func undo(_ sender: UIButton) {
        poiView.undo()
    }
}
