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
    var view: UIView?
}

//MARK: Functions
extension SearchViewModel{
    func controlParameters(title: String?, segmentIndex: Int, year: String?){
        guard title != "" else {
            let alert = GlobalFuncs.shared.showErrorAlert(with: "Upps!", with: "Title is Empty.")
            self.delegete?.sendAlertView(view: alert)
            return
        }
        let segment = checktype(segmentIndex: segmentIndex)
        let year = checkyear(year: year!)
        GlobalFuncs.shared.showActivityIndicatory(uiView: view!)
        logger.info("Searching Word Info ==> Title: \(title!) Year: \(year) Type: \(segment)")
        getSearch(title: title!, year: year, type: segment, page: "1")
    }
    
    func checktype(segmentIndex: Int)->String{
        switch segmentIndex {
        case 1:
            return "Series"
        case 0:
            return "Movie"
        default:
            return ""
        }
    }
    
    func checkyear(year: String)->String{
        if year != ""{
            return year
        }
        return "Year"
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
    func getSearch(title: String, year: String, type: String, page: String){
        service.request(.getSearch(title: title, year: year, type: type, page: page)) { (result) in
            switch result{
            case .success(let response):
                GlobalFuncs.shared.closeActivityIndicatory(uiView: self.view!)
                if let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]{
                    if let names = json["Response"] as? String{
                        if names == "True"{
                            let data = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                            let vc = StoryBoards.Main.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
                            vc.viewModel.list = data.Search!
                            let param = MovieAndSerieRequeestModel(title: title, year: year, type: type, page: 2)
                            vc.viewModel.params = param
                            vc.viewModel.totalResult = Int(data.totalResults!)!
                            self.delegete?.pushNextView(view: vc)
                        }else{
                            let error = json["Error"] as? String
                            let alert = GlobalFuncs.shared.showErrorAlert(with: "Upps!", with: error!)
                            self.delegete?.sendAlertView(view: alert)
                            logger.error("ErrorText: \(error!) /nParams=> Title: \(title) Year: \(year) Type: \(type) Page: \(page)")
                        }
                    }
                }
            case .failure(let error):
                logger.error("Error: \(error) /nRequest Fail.")
            }
        }
    }
}
