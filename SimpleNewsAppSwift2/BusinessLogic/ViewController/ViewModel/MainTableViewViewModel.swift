//
//  MainTableViewViewModel.swift
//  SimpleNewsAppSwift
//
//  Created by Ilya Doroshkevitch on 18.08.2021.
//

import UIKit


protocol MainTableViewViewModelType {
    var items: [Response.News] { get set }
    var interactor: Interactor? { get set  }
    func numberOfRowsInSection(forSection section: Int) -> Int
    func selectRow(atIndexPath indexPath: IndexPath)
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType?
    func loadData(completion: @escaping (() -> ()?))
    func viewModelForSelectedRow() -> FullNewsViewViewModelType?
}


class MainTableViewViewModel: MainTableViewViewModelType {

    var items: [Response.News] = []
    var interactor: Interactor?
    private var selectedIndexPath: IndexPath?

    init(interactor: Interactor?) {
        self.interactor = interactor
    }

    func numberOfRowsInSection(forSection section: Int) -> Int {
        return items.count
    }

    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }

    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsCellViewModelType? {

        let item = items[indexPath.row]

        return NewsCellViewModel(item: item)
    }

    func loadData(completion: @escaping (() -> ()?)) {
        guard let interactor = interactor else { return }

        interactor.getLentaFromApi() { [weak self] response in
            self?.items = response
            completion()
        }
    }

    func viewModelForSelectedRow() -> FullNewsViewViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil}

        let item = items[selectedIndexPath.row]

        return FullNewsViewViewModel(item: item)
    }

}
