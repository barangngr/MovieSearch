//
//  DetailViewModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewModelDelegete {
    func updateView(data: DetailResponseModel)
}


class DetailViewModel{
    var id: String = ""
    var delegete: DetailViewModelDelegete?
    var view: UIView?
}


//MARK: Functions
extension DetailViewModel{
    //The incoming data is rearranged to be displayed on the screen.
    func changeData(data: DetailResponseModel){
        let newData = DetailResponseModel(Title: data.Title!, Released: "Released: \(data.Released!)", Runtime: "Runtime: \(data.Runtime!)", Genre: "Genre: \(data.Genre!)", Director: "Director: \(data.Director!)", Writer: "Writer: \(data.Writer!)", Actors: "Actors: \(data.Actors!)", Plot: data.Plot!, Country: "Country: \(data.Country!)", Poster: data.Poster!, imdbRating: "Imdb: \(data.imdbRating!)")
        self.delegete?.updateView(data: newData)
    }
}


//MARK: Network Functions
extension DetailViewModel{
    func getDetails(){
        GlobalFuncs.shared.showActivityIndicatory(uiView: self.view!)
        service.request(.getDetail(id: id)) { (result) in
            switch result{
            case .success(let response):
                let data = try! JSONDecoder().decode(DetailResponseModel.self, from: response.data)
                self.changeData(data: data)
                GlobalFuncs.shared.closeActivityIndicatory(uiView: self.view!)
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
}
