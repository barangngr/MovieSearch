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
    func reloadTableView()
}


class ListViewModel{
    var list = [MovieAndSerieModel]()
    var title = ""
    var year = ""
    var type = ""
    var page = 2
    var totalResult = 0
    var delegete: ListViewModelDelegete?
    var indexForSlider = true
    var indexForSegment = true
}


extension ListViewModel{
    func pushDetailView(index: Int){
        let vc = StoryBoards.Main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.viewModel.id = list[index].imdbID!
        delegete?.pushNextView(view: vc)
    }
    
    func getPagination(row: Int){
        let lastItem = list.count-1
        if row == lastItem && lastItem <= totalResult-2 {
            getNextPage(page: page)
            page += 1
        }
    }
    
    func selectObject(button: UIButton, objectSlider: UISlider, objectSegment: UISegmentedControl){
        if button.tag == 1{
            controlIsHidden(object: objectSlider, objectBool: &indexForSlider)
            button.setTitle("Year", for: .normal)
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
    
    
    
}


//MARK: Network Functions
extension ListViewModel{
    func getNextPage(page: Int){
        service.request(.getSearch(title: title, year: year, type: type, page: String(page))) { (result) in
            switch result{
            case .success(let response):
                let data = try! JSONDecoder().decode(SearchResponseModel.self, from: response.data)
                for item in data.Search!{
                    self.list.append(item)
                }
                self.delegete?.reloadTableView()
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
}
