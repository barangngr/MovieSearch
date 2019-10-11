//
//  ViewController.swift
//  MovieSearch
//
//  Created by Atlas Mac on 8.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var yearSlider: UISlider!
    @IBOutlet var yearLabel: UILabel!
    
    //MARK: Veriables
    lazy var viewModel = SearchViewModel()
    var segmentIndex = -1 //Unselected segment control default value
    
    //MARK:
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setNavBarBackBtn()
        setViewModel()
    }
    
    //MARK: IBActions
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        segmentIndex = segmentControl.selectedSegmentIndex
    }
    
    @IBAction func selectYearButton(_ sender: UIButton) {
        viewModel.controlSlider(slider: yearSlider, sliderText: yearLabel)
    }
    
    @IBAction func yearSliderAction(_ sender: UISlider) {
        yearLabel.text = String(Int(yearSlider.value))
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        viewModel.controlParameters(title: searchTextField.text, segmentIndex: segmentIndex, year: yearLabel.text)
    }
    
    //MARK: Functions
    func setViewModel(){
        viewModel.delegete = self
        viewModel.view = view
        viewModel.checkNetworkConnection()
    }
}



extension SearchViewController: SearchViewModelDelegete{
    func pushNextView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
    
    func sendAlertView(view: UIAlertController) {
        present(view, animated: true, completion: nil)
    }
}
