//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import UIKit


class SearchViewModel{
    var index = true //For 'Select Year' button to hide slider and label.
}


extension SearchViewModel{
    func controlParameters(title: String?, segmentIndex: Int, year: String?){
        logger.info(title)
        logger.info(segmentIndex)
        logger.info(year)
    }
    
    func controlSlider(slider: UISlider, sliderText: UILabel){
        index = index ? false : true
        if index{
            slider.isHidden = true
            sliderText.isHidden = true
        }else{
            slider.isHidden = false
            sliderText.isHidden = false
        }
    }
}


//MARK: Network Functions
extension SearchViewModel{
    func getSearch(){
        service.request(.getSearch(title: "kkii")) { (result) in
            switch result{
            case .success(let response):
                if let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]{
                    if let names = json["Response"] as? String{
                        if names == "True"{
                            let data = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                            print(data.totalResults!)
                        }else{
                            let error = json["Error"] as? String
                            print(error!)
                        }
                    }
                }
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
}
