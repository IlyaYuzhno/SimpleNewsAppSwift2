//
//  NewsTableViewCell.swift
//  TwitterLenta
//
//  Created by Ilya Doroshkevitch on 09.03.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    weak var viewModel: NewsCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            backgroundColor = .systemGray6
            newsTextLabel.text = viewModel.news.title

            //Get and set image
            getImage(from: viewModel.news.urlToImage ?? "https://images.unsplash.com/photo-1579273166152-d725a4e2b755?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=905&q=80", to: newsImage)
        }
    }


    // MARK: - Private
    private let newsImage : UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleToFill
    imgView.backgroundColor = .red
    imgView.clipsToBounds = true
    imgView.layer.cornerRadius = 10
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
    }()
    
    
    private let newsTextLabel: UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.font = UIFont.boldSystemFont(ofSize: 16)
     lbl.textAlignment = .left
     lbl.translatesAutoresizingMaskIntoConstraints = false
     lbl.numberOfLines = 0
     return lbl
     }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
     super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.layer.shadowColor = .init(gray: 100, alpha: 1)
        self.contentView.layer.shadowOffset = .init(width: 1, height: 1)
        self.contentView.layer.shadowRadius = 10.0;
        self.contentView.layer.shadowOpacity = 1.0;
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.backgroundColor = .white
        self.backgroundColor = .black
        self.textLabel?.numberOfLines = 0
        
        addSubview(newsImage)
        addSubview(newsTextLabel)
        
        
        NSLayoutConstraint .activate([
            newsImage.leftAnchor.constraint(equalTo: newsTextLabel.rightAnchor),
            newsImage.rightAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.rightAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 90),
            newsImage.heightAnchor.constraint(equalToConstant: 100),
            newsImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            newsTextLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            newsTextLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant:  -100),
            newsTextLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
// MARK: - Cell setup method
    func setup(item: [Response.News], indexPath: Int) {
        
        //Get and set news title
        let newsTitle = item[indexPath].title
        self.newsTextLabel.text = newsTitle
        
        
        //Get and set image
        getImage(from: item[indexPath].urlToImage ?? "https://images.unsplash.com/photo-1579273166152-d725a4e2b755?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=905&q=80", to: newsImage)

    }
}
