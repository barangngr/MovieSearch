//
//  GlobalFuncs.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import UIKit

class GlobalFuncs{
    
    static let shared = GlobalFuncs()
    var reachability: Reachability?
    
    
    func checkNetworkConnection()-> UIAlertController?{
        self.reachability = Reachability.init()
        if (self.reachability!.connection == .none) {
            let alertAction = UIAlertAction(title: "Okey", style: .default) { (action) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    exit(0)
                }
            }
            let alert = GlobalFuncs.shared.showErrorAlertWithAction(with: "No Connection", with: "Please check your internet connection.", action: alertAction)
            return alert
        }else{
            return nil
        }
    }
    
    private func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
    func showErrorAlertWithAction(with title: String?,with message: String?, action: UIAlertAction)->UIAlertController {
        let alert = showAlert(with: title, message: message, actions: [action])
        return alert
    }
    
    func showErrorAlert(with title: String?,with message: String?)->UIAlertController {
        let okAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        let alert = showAlert(with: title, message: message, actions: [okAction])
        return alert
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction])->UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        return alert
    }
}
