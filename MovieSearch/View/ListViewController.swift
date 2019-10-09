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
    
    lazy var viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "ListCell")
        tableView.separatorStyle = .none
        viewModel.delegete = self
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
    
}


extension ListViewController: ListViewModelDelegete{
    func pushNextView(view: UIViewController) {
        navigationController?.pushViewController(view, animated: true)
    }
}
