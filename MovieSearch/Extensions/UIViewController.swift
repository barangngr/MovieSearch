//
//  UIViewController.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func hideNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
//    func backButtonTitle(title: String){
//        let backItem = UIBarButtonItem()
//        backItem.title = title
//        navigationItem.backBarButtonItem = backItem
//    }
//    
    func setNavBarBackBtn(){
        self.navigationController?.view.tintColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
