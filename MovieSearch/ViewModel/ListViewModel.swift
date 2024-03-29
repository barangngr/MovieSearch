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
    func updateUI(data: MovieAndSerieRequeestModel, totalResult: Int)
}


class ListViewModel{
    var list = [MovieAndSerieResponseModel]()
    var totalResult = 0
    var indexForScroll = 1 //Look for new search or just pagination
    var newSearchIndex = 0 //To understand that a new search has been made
    var delegete: ListViewModelDelegete?
    var indexForSlider = true
    var indexForSegment = true
    var view: UIView?
    var tableView: UITableView?
    var params: MovieAndSerieRequeestModel?
}

//MARK: Functions
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
    
    //The part that will run when it searches for a new result
    func searcAgain(param: MovieAndSerieRequeestModel){
        newSearchIndex += 1
        GlobalFuncs.shared.showActivityIndicatory(uiView: view!)
        view?.endEditing(true)
        self.params = param
        self.list.removeAll()
        getSearch(typeOrNo: (params?.type!)!)
        logger.info("Searching Word Info ==> Title: \(param.title!) Year: \(param.year!) Type: \(param.type!) Page: \(param.page!) ")
    }
    
    //Check before pagination process
    func checkBeginFetch(tableView: UITableView, indexPath: IndexPath){
        let lastSectionIndex = tableView.numberOfSections-1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex)-1
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && list.count < totalResult-1{
            beginFetch()
        }
    }
    
    //Call to request method
    func beginFetch(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.params?.page! += 1
            self.getSearch(typeOrNo: (self.params?.type!)!)
        }
    }
    
    func getSearch(typeOrNo: String){
        switch params!.type {
        case "Type":
            let str = String()
            params!.type = str
            getSearchWithType(param: params!)
        default:
            getSearchWithType(param: params!)
        }
    }
    
    func setUI(totalResult: String){
        self.totalResult = Int(totalResult)!
        delegete?.updateUI(data: params!, totalResult: self.totalResult)
    }
    
    //Jump to first row when we search new request
    func scrollToFirstRow(searchIndex: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            if searchIndex == self.indexForScroll{
                let indexPath = NSIndexPath(row: 0, section: 0)
                self.tableView!.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                self.indexForScroll += 1
            }
        }
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
                            self.setUI(totalResult: data.totalResults!)
                            self.scrollToFirstRow(searchIndex: self.newSearchIndex)
                        }else{
                            let error = json["Error"] as? String
                            self.setUI(totalResult: "0")
                            let alert = GlobalFuncs.shared.showErrorAlert(with: "We don't find!", with: error!)
                            self.delegete?.sendAlertView(view: alert)
                            logger.error("ErrorText: \(error!) Params ==> Title: \(param.title!) Year: \(param.year!) Type: \(param.type!) Page: \(param.page!)")
                        }
                    }
                }
                GlobalFuncs.shared.closeActivityIndicatory(uiView: self.view!)
            case .failure(let error):
                logger.error("Error: \(error) => Request Fail.")
            }
        }
    }
}


