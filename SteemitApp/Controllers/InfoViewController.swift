//
//  InfoViewController.swift
//  SteemitApp
//
//  Created by Burak Tayfun on 1/8/18.
//  Copyright © 2018 Burak Tayfun. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class InfoViewController: BaseViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var steemBalanceLabel: UILabel!
    @IBOutlet weak var sbdBalanceLabel: UILabel!
    @IBOutlet weak var equivalentCurrencyLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var currenciesSegmentControl: UISegmentedControl!
    
    var hud: MBProgressHUD?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.viewWithTag(300)?.applyGradient(colours: [UIColor.init(white: 0.5, alpha: 1), UIColor.init(white: 1, alpha: 1)])
        getUserAcoountInfo()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        for view in (navigationController?.navigationBar.subviews[0].subviews)! {
            view.alpha = 0
            for subview in view.subviews {
                subview.alpha = 0
            }
        }
    }
    
    @IBAction func changeCurrency(_ sender: Any) {
        getEquivalentCurrencyPrice()
    }
    
    private func getEquivalentCurrencyPrice() {
        let converter = TextChanger.init()
        let currencyText = converter.changeCurrency(currency: self.currenciesSegmentControl.titleForSegment(at: self.currenciesSegmentControl.selectedSegmentIndex)!)
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Your money is calculating.."
        let nm = NetworkManager.init()
        nm.getSteemitPrice(currency: currencyText.rawValue, success: {[unowned self] coin in
            self.showMoneyInSpecifiedCurrency(coin)
            self.hud?.hide(animated: true)
        }) { (error) in
            self.hud?.hide(animated: true)
            let pm = PopupManager.init()
            let cancelAction = UIAlertAction.init(title: "Kapat", style: .cancel, handler: nil)
            pm.showDefaultPopup(viewController: self, actions: [cancelAction], message: error, title: "Error")
        }
    }
    
    private func getUserAcoountInfo() {
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.detailsLabel.text = "Your account informations loading.."
        let nm = NetworkManager.init()
        nm.getSteemitAccount(user: UserGlobals.sharedInstance.username, success: {[unowned self] user in
            self.hud?.hide(animated: true)
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
            self.hud?.hide(animated: true)
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
        case 3:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.krwPrice)
            break
        case 4:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.rublePrice)
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
