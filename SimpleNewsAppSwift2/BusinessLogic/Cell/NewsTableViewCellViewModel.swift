//
//  NewsTableViewCellViewModel.swift
//  SimpleNewsAppSwift
//
//  Created by Ilya Doroshkevitch on 18.08.2021.
//

import Foundation

protocol NewsCellViewModelType: AnyObject {
    var news: Response.News { get }
}

class NewsCellViewModel: NewsCellViewModelType {

    private var item: Response.News

    var news: Response.News {
        return item
    }

    init(item: Response.News) {
        self.item = item
    }

}
