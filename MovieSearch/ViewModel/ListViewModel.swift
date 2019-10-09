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
}


class ListViewModel{
    var list = [MovieAndSerieModel]()
    var delegete: ListViewModelDelegete?
}


extension ListViewModel{
    func pushDetailView(index: Int){
        let vc = StoryBoards.Main.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.viewModel.id = list[index].imdbID!
        delegete?.pushNextView(view: vc)
    }
}


//MARK: Network Functions
extension ListViewModel{
    
}
