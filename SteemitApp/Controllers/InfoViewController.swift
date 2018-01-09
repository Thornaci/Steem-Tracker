//
//  InfoViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import SDWebImage

class InfoViewController: BaseViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var steemBalanceLabel: UILabel!
    @IBOutlet weak var sbdBalanceLabel: UILabel!
    @IBOutlet weak var equivalentCurrencyLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var currenciesSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserAcoountInfo()
    }
    
    @IBAction func changeCurrency(_ sender: Any) {
        getEquivalentCurrencyPrice()
    }
    
    private func getEquivalentCurrencyPrice() {
        let converter = TextChanger.init()
        let currencyText = converter.changeCurrency(currency: self.currenciesSegmentControl.titleForSegment(at: self.currenciesSegmentControl.selectedSegmentIndex)!)
        
        let nm = NetworkManager.init()
        nm.getSteemitPrice(currency: currencyText.rawValue, success: { (coin) in
            self.showMoneyInSpecifiedCurrency(coin)
            
        }) { (error) in
            let pm = PopupManager.init()
            let cancelAction = UIAlertAction.init(title: "Kapat", style: .cancel, handler: nil)
            pm.showDefaultPopup(viewController: self, actions: [cancelAction], message: error, title: "Error")
        }
    }
    
    private func getUserAcoountInfo() {
        let nm = NetworkManager.init()
        nm.getSteemitAccount(user: UserGlobals.sharedInstance.username, success: { (user) in
            self.usernameLabel.text = user.username
            self.aboutLabel.text = user.aboutUser
            self.steemBalanceLabel.text = user.steemBalance
            self.sbdBalanceLabel.text = user.sbdBalance
            UserGlobals.sharedInstance.userMoney = user.sbdBalance
            if let profileUrl = user.profileUrl {
                self.profileImageView.sd_setImage(with: URL.init(string: profileUrl), placeholderImage: UIImage.init(named: "freeProfile"))
            }
            
            self.getEquivalentCurrencyPrice()
        }) { (error) in
            let pm = PopupManager.init()
            let cancelAction = UIAlertAction.init(title: "Kapat", style: .cancel, handler: nil)
            pm.showDefaultPopup(viewController: self, actions: [cancelAction], message: error, title: "Error")
        }
    }
    
    private func showMoneyInSpecifiedCurrency(_ coin: CoinModel) {
        switch self.currenciesSegmentControl.selectedSegmentIndex {
        case 0:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.usdPrice)
            break
        case 1:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.euroPrice)
            break
        case 2:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.tryPrice)
            break
        default:
            break
        }
    }
    
    private func calculateMoneyInSpecifiedCurrency(_ price: String?) -> String {
        if var userMoney = UserGlobals.sharedInstance.userMoney, let coinPrice = price {
            
            userMoney = userMoney.replacingOccurrences(of: "[A-Z]|[a-z]", with: "", options: [.regularExpression]).replacingOccurrences(of: " ", with: "", options: [.regularExpression])
            
            let totalMoney = money(userMoney)! * money(coinPrice)!
            return totalMoney.description
        }
        return "an error appeared while calculating!"
    }
}
