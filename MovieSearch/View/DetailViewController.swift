//
//  DetailViewController.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController{
    
    //MARK: IBOutlets
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var posterTitle: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var releasedLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var imdbRaitingLabel: UILabel!
    @IBOutlet var plotLabel: UILabel!
    @IBOutlet var writerLabel: UILabel!
    @IBOutlet var actorsLabel: UILabel!
    
    //MARK: Veriables
    lazy var viewModel = DetailViewModel()
   
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setNavBarBackBtn()
        setViewModel()
    }
    
    //MARK: Functions
    func setViewModel(){
        viewModel.view = view
        viewModel.getDetails()
        viewModel.delegete = self
    }
}


extension DetailViewController: DetailViewModelDelegete{
    func updateView(data: DetailResponseModel) {
        posterImage.kf.setImage(with: URL(string: data.Poster!))
        posterTitle.text = data.Title
        genreLabel.text = data.Genre
        runtimeLabel.text = data.Runtime
        directorLabel.text = data.Director
        releasedLabel.text = data.Released
        countryLabel.text = data.Country
        imdbRaitingLabel.text = data.imdbRating
        plotLabel.text = data.Plot
        writerLabel.text = data.Writer
        actorsLabel.text = data.Actors
    }
}
