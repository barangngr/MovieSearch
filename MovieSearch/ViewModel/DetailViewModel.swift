//
//  DetailViewModel.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegete {
    func updateView(data: DetailResponseModel)
}


class DetailViewModel{
    var id: String = ""
    var delegete : DetailViewModelDelegete?
}


extension DetailViewModel{
    func changeData(data: DetailResponseModel){
        let newData = DetailResponseModel(Title: data.Title!, Released: "Released: \(data.Released!)", Runtime: "Runtime: \(data.Runtime!)", Genre: "Genre: \(data.Genre!)", Director: "Director: \(data.Director!)", Writer: "Writer: \(data.Writer!)", Actors: "Actors: \(data.Actors!)", Plot: "Plot: \(data.Plot!)", Country: "Country: \(data.Country!)", Poster: data.Poster!, imdbRating: "Imdb: \(data.imdbRating!)")
        self.delegete?.updateView(data: newData)
    }
}

//MARK: Network Functions
extension DetailViewModel{
    func getDetails(){
        service.request(.getDetail(id: id)) { (result) in
            switch result{
            case .success(let response):
                let data = try! JSONDecoder().decode(DetailResponseModel.self, from: response.data)
                self.changeData(data: data)
            case .failure(let error):
                logger.error("Error \(error)")
            }
        }
    }
}