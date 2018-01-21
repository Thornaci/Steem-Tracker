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
    var username = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserAcoountInfo()
        
        let leftBarButton = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(backTapped))
        leftBarButton.tintColor = UIColor.barTintColor()
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        rightBarButton.tintColor = UIColor.barTintColor()
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func backTapped() {
        let nm = NetworkManager.init()
        nm.cancelAllSessions()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addTapped() {
        if username == "" {
            return
        }
        
        if canUserAdd() {
            addUserToFavorites()
        } else {
            let pm = PopupManager.init()
            pm.showDefaultPopup(viewController: self, actions: [UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)], message: "This account is already in favorite list!", title: "Error")
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
        nm.getSteemitAccount(user: username, success: {[unowned self] user in
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
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.usdPrice, .dolar)
            break
        case 1:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.euroPrice, .euro)
            break
        case 2:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.tryPrice, .turkishLiras)
            break
        case 3:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.krwPrice, .koreanWon)
            break
        case 4:
            self.equivalentCurrencyLabel.text = calculateMoneyInSpecifiedCurrency(coin.rublePrice, .ruble)
            break
        default:
            break
        }
    }
    
    private func calculateMoneyInSpecifiedCurrency(_ price: String?, _ currencyType: CurrencyTypes) -> String {
        if var userMoney = UserGlobals.sharedInstance.userMoney, let coinPrice = price {
            
            userMoney = userMoney.replacingOccurrences(of: "[A-Z]|[a-z]", with: "", options: [.regularExpression]).replacingOccurrences(of: " ", with: "", options: [.regularExpression])
            
            let totalMoney = money(userMoney)! * money(coinPrice)!
            let tc = TextChanger.init()
            return tc.changeCurrencyWithSymbol(currency: totalMoney.description, currencyType: currencyType)
        }
        return "an error appeared while calculating!"
    }
    
    private func canUserAdd() -> Bool {
        if let userArray = UserDefaults.standard.array(forKey: "username") {
            for user in userArray {
                let accountname = user as! String
                if username == accountname {
                    return false
                }
            }
        }
        return true
    }
    
    private func addUserToFavorites() {
        let helper = Helpers.init()
        if let userArray = UserDefaults.standard.array(forKey: "username") {
            var newArray = userArray
            newArray.append(username)
            helper.setLocalDataVariables(newArray)
            
        } else {
            var userArray = [String]()
            userArray.append(username)
            helper.setLocalDataVariables(userArray)
        }
    }
}
