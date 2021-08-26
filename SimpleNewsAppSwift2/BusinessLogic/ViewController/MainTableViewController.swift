//
//  MainTableViewController.swift
//  
//
//  Created by Ilya Doroshkevitch on 04.03.2021.
//

import UIKit

class MainTableViewController: UITableViewController, CloseFullViewDelegate {

    let fullNewsView = FullNewsView(frame: CGRect(x: 0, y: -10, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 1.5))
    var viewModel: MainTableViewViewModelType?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor = Interactor()
        viewModel = MainTableViewViewModel(interactor: interactor)

        self.tableView.separatorColor = UIColor.clear
        self.clearsSelectionOnViewWillAppear = true
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 100
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        
        fullNewsView.delegate = self
        
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

        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        fullNewsView.viewModel = viewModel.viewModelForSelectedRow()

        fullNewsView.newsTextLabel.text = fullNewsView.viewModel?.news
        fullNewsView.showImage(from: fullNewsView.viewModel?.urlToImage ?? "")

        self.view.addSubview(fullNewsView)
    }


    // MARK: - Show Full View always on top when scrolled method
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newFrame = fullNewsView.frame
        newFrame.origin.x = 0
        newFrame.origin.y = self.tableView.contentOffset.y
        fullNewsView.frame = newFrame
    }

    // MARK: - Full News View Delegate method
    func closeFullViewButtonClicked(sender: UIButton) {
        
        fullNewsView.removeFromSuperview()
    }
    
}
