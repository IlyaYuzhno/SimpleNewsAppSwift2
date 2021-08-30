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
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let newsTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupContentView()
        setupViewsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContentView() {
        contentView.layer.shadowColor = .init(gray: 100, alpha: 1)
        contentView.layer.shadowOffset = .init(width: 1, height: 1)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 1
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .white
        backgroundColor = .black
        textLabel?.numberOfLines = 0
    }

    func setupViewsConstraints() {
        addSubview(newsImage)
        addSubview(newsTextLabel)

        NSLayoutConstraint .activate([
            newsImage.leftAnchor.constraint(equalTo: newsTextLabel.rightAnchor),
            newsImage.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor),
            newsImage.widthAnchor.constraint(equalTo: contentView.heightAnchor),
            newsImage.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            newsTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .kCellTextLabelOffset),
            newsTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -.kRowHeight),
            newsTextLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }

}
