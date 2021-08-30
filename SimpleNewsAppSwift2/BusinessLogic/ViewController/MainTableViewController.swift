//
//  MainTableViewController.swift
//  
//
//  Created by Ilya Doroshkevitch on 04.03.2021.
//

import UIKit

extension CGFloat {
    static let kFullNewsViewTopOffset: CGFloat = -2
    static let kFullNewsViewHeightOffset: CGFloat = 0.75
    static let kRowHeight: CGFloat = 100
    static let kCellTextLabelOffset: CGFloat = 10
}

class MainTableViewController: UITableViewController, CloseFullViewDelegate {

    var fullNewsView: FullNewsView?
    var viewModel: MainTableViewViewModelType?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor = NewsFetchingService()
        viewModel = MainTableViewViewModel(interactor: interactor)
        fullNewsView = FullNewsView()

        self.tableView.separatorColor = UIColor.clear
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = .kRowHeight
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        
        fullNewsView?.delegate = self

        //Get news via viewModel
        viewModel?.loadData(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(forSection: section) ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell

        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }

        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let fullNewsView = fullNewsView else { return }

        viewModel.selectRow(atIndexPath: indexPath)
        fullNewsView.viewModel = viewModel.viewModelForSelectedRow()

        fullNewsView.newsTextLabel.text = fullNewsView.viewModel?.news
        fullNewsView.showImage(from: fullNewsView.viewModel?.urlToImage ?? "")

        setupFullViewConstraints()
    }

    // MARK: - Full News View Delegate method
    func closeFullViewButtonClicked(sender: UIButton) {
        fullNewsView?.removeFromSuperview()
    }

    func setupFullViewConstraints(){
        guard let fullNewsView = fullNewsView else { return }

        view.addSubview(fullNewsView)
        fullNewsView.translatesAutoresizingMaskIntoConstraints = false

        fullNewsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .kFullNewsViewTopOffset).isActive = true
        fullNewsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        fullNewsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: .kFullNewsViewHeightOffset).isActive = true
   }
    
}
