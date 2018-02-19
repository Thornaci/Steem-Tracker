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
    @IBOutlet weak var moderatorNumberButton: ThoButton!
    
    @IBOutlet weak var totalPendingPostsCount: UILabel!
    var moderators = [UtopianModeratorModel]()
    
    override func viewDidLoad() {
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
            self.moderatorNumberButton.setTitle("\(self.moderators.count)", for: .normal)

        }) { (error) in
            print(error)
        }
        
        nm.getUtopianTotalPostCount(success: { totalPostCount in
            self.postNumberLabel.text = "\(totalPostCount)"
        }) { (error) in
            print(error)
        }
        
        nm.getUtopianPendingPostCount(success: { (pendingPosts) in
            self.totalPendingPostsCount.text = "\(pendingPosts.total)"
        }) { (error) in
            print(error)
        }
    }
    
    private func updateUserInfo(_ user: UserModel) {
        if let voteTime = user.lastvoteTime {
            let totalVP = helper.calculateVotePower(voteTime, user.votingPower)
            percentView.updateBar(totalVP / 100)
            steemPowerPercentLabel.text = "% " + String(format: "%.2f", totalVP)
            
        }
        
        lastVoteTimeLabel.text = Date.UTCToLocal(date: (user.lastvoteTime?.replacingOccurrences(of: "T", with: " "))!)
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
