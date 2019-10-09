//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewModelDelegete {
    func sendAlertView(view: UIAlertController)
    func pushNextView(view:UIViewController)
}


class SearchViewModel{
    var index = true //For 'Select Year' button to hide slider and label.
    var delegete: SearchViewModelDelegete?
}


extension SearchViewModel{
    func controlParameters(title: String?, segmentIndex: Int, year: String?){
        checkNetworkConnection()
        guard title != "" else {
            let alert = GlobalFuncs.shared.showErrorAlert(with: "Upps!", with: "Title is Empty.")
            self.delegete?.sendAlertView(view: alert)
            return
        }
        var segment = "movie"
        if segmentIndex == 1 {
            segment = "series"
        }
        getSearch(title: title!, year: year!, type: segment)
    }
    
    func controlSlider(slider: UISlider, sliderText: UILabel){
        index = index ? false : true
        if index{
            slider.isHidden = true
            sliderText.isHidden = true
            sliderText.text = ""
        }else{
            slider.isHidden = false
            sliderText.isHidden = false
        }
    }
    
    func checkNetworkConnection(){
        guard let alert = GlobalFuncs.shared.checkNetworkConnection() else {return}
        self.delegete?.sendAlertView(view: alert)
    }
}


//MARK: Network Functions
extension SearchViewModel{
    func getSearch(title: String, year: String, type: String){
        service.request(.getSearch(title: title, year: year, type: type)) { (result) in
            switch result{
            case .success(let response):
                if let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]{
                    if let names = json["Response"] as? String{
                        if names == "True"{
                            let data = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                            print(data.totalResults!)
                            let vc = StoryBoards.Main.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
                            vc.viewModel.list = data.Search!
                            self.delegete?.pushNextView(view: vc)
                        }else{
                            let error = json["Error"] as? String
                            let alert = GlobalFuncs.shared.showErrorAlert(with: "Upps!", with: error!)
                            self.delegete?.sendAlertView(view: alert)
                        }
                    }
                }
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
}
