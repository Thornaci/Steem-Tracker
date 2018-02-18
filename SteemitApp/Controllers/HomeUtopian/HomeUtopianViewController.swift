//
//  HomeUtopianViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 2/18/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit

class HomeUtopianViewController: BaseViewController {

    let nm = NetworkManager()
    let helper = Helpers()
    
    @IBOutlet weak var percentView: ThoSlider!
    @IBOutlet weak var steemPowerPercentLabel: UILabel!
    @IBOutlet weak var lastVoteTimeLabel: ThoLabel!
    @IBOutlet weak var postNumberLabel: ThoLabel!
    @IBOutlet weak var moderatorNumberLabel: ThoLabel!
    
    var moderators = [UtopianModeratorModel]()
    
    override func viewDidLoad() {
        navigationItem.title = "Utopian"
        getUtopianInfo()
    }
    
    private func getUtopianInfo() {
        nm.getSteemitAccount(user: "utopian-io", success: { utopianData in
            self.updateUserInfo(utopianData)
        }) { (error) in
            print(error)
        }
        
        nm.getUtopianModeratorList(success: { (mods) in
            self.moderators = mods
        }) { (error) in
            print(error)
        }
    }
    
    private func updateUserInfo(_ user: UserModel) {
        percentView.updateBar(user.votingPower/10000)
        steemPowerPercentLabel.text = "%\(user.votingPower/100)"
        lastVoteTimeLabel.text = user.lastvoteTime?.replacingOccurrences(of: "T", with: " ")
    }
    
    @IBAction func showMods(_ sender: Any) {
        performSegue(withIdentifier: "showMods", sender: nil)
    }
   
    @IBAction func closeScreen(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMods" {
            let vc = segue.destination as! ModeratorListViewController
            vc.moderators = moderators
        }
    }
}
