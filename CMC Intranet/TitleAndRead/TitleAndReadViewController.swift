//
//  ArticleListViewController.swift
//  CMC Intranet
//
//  Created by Sage Conger on 9/8/19.
//  Copyright © 2019 sageconger. All rights reserved.
//

import UIKit

class TitleAndReadViewController: UIViewController {
    let globalStateSelector: (GlobalState) -> [TitleAndReadViewModel]
    
    var specificTitleAndReadViewModels: [TitleAndReadViewModel] {
        return globalStateSelector(globalState)
    }
    
    init(globalStateSelector: @escaping (GlobalState) -> [TitleAndReadViewModel]) {
        self.globalStateSelector = globalStateSelector
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        with(tableView) {
            $0.dataSource = self
            $0.delegate = self
            
            $0.register(TitleAndReadTableViewCell.self, forCellReuseIdentifier: "cellID")
            
            view.addSubview($0)
            
            $0.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension TitleAndReadViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificTitleAndReadViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TitleAndReadTableViewCell
        
        let viewModel = specificTitleAndReadViewModels[indexPath.row]
        
        cell.dotImageView.isHidden = viewModel.read
        cell.titleLabel.text = viewModel.title
        
        return cell
    }
}

extension TitleAndReadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let viewModel = specificTitleAndReadViewModels[indexPath.row]
        let isFavorite = globalState.favorites.keys.contains(viewModel)
        
        let action = UIContextualAction(style: .normal, title: isFavorite ? "Remove from Favorites" : "Add to Favorites", handler: { action, view, completionHandler in
            if isFavorite {
                globalState.favorites.removeValue(forKey: viewModel)
            }
            else {
                globalState.favorites[viewModel] = Date()
            }
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            completionHandler(true)
        })
        action.backgroundColor = UIColor(red: (204 / 255), green: 0, blue: (119 / 255), alpha: 1.0)
        action.image = UIImage(named: isFavorite ? "closedHeart" : "openHeart")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}
