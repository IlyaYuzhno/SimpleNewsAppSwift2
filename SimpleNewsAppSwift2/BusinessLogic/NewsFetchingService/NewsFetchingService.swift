//
//  Interactor.swift
//  TwitterLenta
//
//  Created by Ilya Doroshkevitch on 04.03.2021.
//

import Foundation

protocol Fetchable: AnyObject {
    func getLentaFromApi(completion: @escaping ([Response.News]) -> Void)
}

class NewsFetchingService: Fetchable {
    
    // MARK: - Public
    var errorMessage = ""
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
        
    
    // MARK: - Class funcs
    func getLentaFromApi(completion: @escaping ([Response.News]) -> Void) {
        
        let session = URLSession(configuration: .default)
        let url = AppDelegate.baseUrl
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            guard let jsonData = data else { return }
            do {
                let news = try JSONDecoder().decode(Response.self, from: jsonData)

                    completion(news.articles)
                
            } catch {
                print(error)
            }
        })
    task.resume()
   }
}



