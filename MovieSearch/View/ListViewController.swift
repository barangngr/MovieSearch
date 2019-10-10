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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.getPagination(row: indexPath.row)
    }
    
}


extension ListViewController: ListViewModelDelegete{
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func pushNextView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
