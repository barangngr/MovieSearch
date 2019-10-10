//
//  ListViewController.swift
//  MovieSearch
//
//  Created by Atlas Mac on 9.10.2019.
//  Copyright © 2019 AtlasYazilim. All rights reserved.
//

import UIKit
import Kingfisher

class ListViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var yearButtonOutlet: UIButton!
    @IBOutlet var typeButtonOutlet: UIButton!
    @IBOutlet var totalResultLabel: UILabel!
    @IBOutlet var yearSliderOutlet: UISlider!
    @IBOutlet var typeSegmentOutlet: UISegmentedControl!
    @IBOutlet var searchImage: UIImageView!
    
    lazy var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.separatorStyle = .none
        viewModel.delegete = self
        viewModel.setUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        searchImage.isUserInteractionEnabled = true
        searchImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func filterButtons(_ sender: UIButton) {
        viewModel.selectObject(button: sender, objectSlider: yearSliderOutlet, objectSegment: typeSegmentOutlet)
    
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        yearButtonOutlet.setTitle(String(Int(sender.value)), for: .normal)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        viewModel.controlTypeButton(button: typeButtonOutlet, segment: sender)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let param = MovieAndSerieRequeestModel(title: titleTextField.text, year: yearButtonOutlet.titleLabel?.text, type: typeButtonOutlet.titleLabel?.text, page: 1)
        viewModel.params = param
        viewModel.searcAgain(param: param)
        view.endEditing(true)
    }
}


extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let item = viewModel.list[indexPath.row]
        cell.posterDate.text = item.Year!
        cell.posterName.text = item.Title!
        cell.posterImage.kf.setImage(with: URL(string: item.Poster!))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.pushDetailView(index: indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        viewModel.readyForFetch(offSetY: offSetY, contentHeight: contentHeight, scrollViewHeight: scrollView.contentSize.height)
    }
    
}


extension ListViewController: ListViewModelDelegete{
    func sendAlertView(view: UIAlertController) {
        present(view, animated: true, completion: nil)
    }
    
    func updateUI(data: MovieAndSerieRequeestModel, totalResult: Int) {
        titleTextField.text = data.title!
        yearButtonOutlet.setTitle(data.year!, for: .normal)
        totalResultLabel.text = "Total Result: \(String(totalResult))"
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func pushNextView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
