//
//  ViewController.swift
//  MovieSearch
//
//  Created by Atlas Mac on 8.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var yearSlider: UISlider!
    @IBOutlet var yearLabel: UILabel!
    
    lazy var viewModel = SearchViewModel()
    var segmentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setNavBarBackBtn()
        viewModel.delegete = self
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        segmentIndex = segmentControl.selectedSegmentIndex
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        viewModel.controlParameters(title: searchTextField.text, segmentIndex: segmentIndex, year: yearLabel.text)
    }
    
    @IBAction func selectYearButton(_ sender: UIButton) {
        viewModel.controlSlider(slider: yearSlider, sliderText: yearLabel)
    }
    
    @IBAction func yearSliderAction(_ sender: UISlider) {
        yearLabel.text = String(Int(yearSlider.value))
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
