//
//  ListViewModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import UIKit


protocol ListViewModelDelegete {
    func pushNextView(view:UIViewController)
    func sendAlertView(view: UIAlertController)
    func reloadTableView()
    func updateUI(data: MovieAndSerieRequeestModel, totalResult: Int)
}


class ListViewModel{
    var list = [MovieAndSerieResponseModel]()
    var params : MovieAndSerieRequeestModel?
    var totalResult = 0
    var delegete: ListViewModelDelegete?
    var fetchingMore = false
    var indexForSlider = true
    var indexForSegment = true
}


extension ListViewModel{
    func pushDetailView(index: Int){
        let vc = StoryBoards.Main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.viewModel.id = list[index].imdbID!
        delegete?.pushNextView(view: vc)
    }
    
    func selectObject(button: UIButton, objectSlider: UISlider, objectSegment: UISegmentedControl){
        if button.tag == 1{
            controlIsHidden(object: objectSlider, objectBool: &indexForSlider)
            if button.titleLabel?.text != "Year"{
                button.setTitle("Year", for: .normal)
            }
        }else{
            controlIsHidden(object: objectSegment, objectBool: &indexForSegment)
            button.setTitle("Type", for: .normal)
        }
    }
    
    func controlIsHidden<T: UIView>(object: T, objectBool: inout Bool){
        objectBool = objectBool ? false : true
        object.isHidden = objectBool
    }
    
    func controlTypeButton(button: UIButton, segment: UISegmentedControl){
        if segment.selectedSegmentIndex == 0 {
            button.setTitle("Movie", for: .normal)
        }else{
            button.setTitle("Series", for: .normal)
        }
    }
    
    func setUI(){
        delegete?.updateUI(data: params!, totalResult: totalResult)
    }
    
    func searcAgain(param: MovieAndSerieRequeestModel){
        self.list.removeAll()
        delegete?.reloadTableView()
        switch params!.type {
        case "Type":
            getSearchWithoutType(param: params!)
        default:
            getSearchWithType(param: params!)
        }
    }
    
    
    func readyForFetch(offSetY: CGFloat, contentHeight: CGFloat, scrollViewHeight: CGFloat){
        if offSetY > contentHeight - scrollViewHeight/2{
            if !fetchingMore && list.count <= totalResult-1{
                beginFetch()
            }
        }
    }
    
    func beginFetch(){
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.params?.page! += 1
            switch self.params!.type {
            case "Type":
                self.getSearchWithoutType(param: self.params!)
            default:
                self.getSearchWithType(param: self.params!)
            }
            self.fetchingMore = false
        }
    }
    
    func reload(result: String){
        self.totalResult = Int(result)!
        self.setUI()
        self.delegete?.reloadTableView()
    }
    
}


//MARK: Network Functions
extension ListViewModel{
    func getSearchWithType(param: MovieAndSerieRequeestModel){
        service.request(.getSearch(title: param.title!, year: param.year!, type: param.type!, page: String(param.page!))) { (result) in
            switch result{
            case .success(let response):
                if let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]{
                    if let names = json["Response"] as? String{
                        if names == "True"{
                            let data = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                            for item in data.Search!{
                                self.list.append(item)
                            }
                            self.reload(result: data.totalResults!)
                        }else{
                            let error = json["Error"] as? String
                            let alert = GlobalFuncs.shared.showErrorAlert(with: "We don't find!", with: error!)
                            self.delegete?.sendAlertView(view: alert)
                            logger.error("Error \(error!)")
                        }
                    }
                }
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
    
    func getSearchWithoutType(param: MovieAndSerieRequeestModel){
        service.request(.getSearchWithoutType(title: param.title!, year: param.year!, page: String(param.page!))) { (result) in
            switch result{
            case .success(let response):
                if let json = try! JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any]{
                    if let names = json["Response"] as? String{
                        if names == "True"{
                            let data = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                            for item in data.Search!{
                                self.list.append(item)
                            }
                            self.reload(result: data.totalResults!)
                        }else{
                            let error = json["Error"] as? String
                            let alert = GlobalFuncs.shared.showErrorAlert(with: "We don't find!", with: error!)
                            self.delegete?.sendAlertView(view: alert)
                            logger.error("Error \(error!)")
                        }
                    }
                }
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
}
    

