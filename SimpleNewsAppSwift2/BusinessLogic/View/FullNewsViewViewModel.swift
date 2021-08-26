//
//  FullNewsViewViewModel.swift
//  SimpleNewsAppSwift
//
//  Created by Ilya Doroshkevitch on 18.08.2021.
//

import UIKit

protocol FullNewsViewViewModelType: AnyObject {
    var news: String { get set }
    var urlToImage: String { get set }
}

class FullNewsViewViewModel: FullNewsViewViewModelType {

    internal var item: Response.News {
        didSet {
            news = item.description ?? ""
            urlToImage = item.urlToImage ?? ""
        }
    }

    var news: String {
        get { return item.description ?? "" }
        set {
            NotificationCenter.default.post(name: Notification.Name("NewsUpdated"), object: nil) }
    }

    var urlToImage: String {
        get { return item.urlToImage ?? "" }
        set { NotificationCenter.default.post(name: Notification.Name("ImageUpdated"), object: nil) }
    }

    init(item: Response.News) {
        self.item = item
    }

}
