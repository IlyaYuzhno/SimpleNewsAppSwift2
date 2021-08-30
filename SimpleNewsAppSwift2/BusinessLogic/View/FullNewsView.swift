//
//  FullNewsView.swift
//  
//
//  Created by Ilya Doroshkevitch on 09.03.2021.
//

import UIKit


// MARK: - Delegate protocol
protocol CloseFullViewDelegate: AnyObject {
    func closeFullViewButtonClicked(sender: UIButton)
}

class FullNewsView: UIView {

    // MARK: - Public
    weak var delegate: CloseFullViewDelegate?
    var viewModel: FullNewsViewViewModelType?
    
    public lazy var newsTextLabel: UILabel = {
     let label = UILabel()
     label.textColor = .black
     label.textAlignment = .natural
     label.contentMode = .scaleToFill
     label.translatesAutoresizingMaskIntoConstraints = false
     label.numberOfLines = 0
     label.isUserInteractionEnabled = true
     return label
     }()

    // MARK: - Private
    private lazy var newsImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleToFill
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
    }()

    private let closeButton: UIButton = {
     let button = UIButton()
     button.setTitle("Close", for: .normal)
     button.translatesAutoresizingMaskIntoConstraints = false
     button.backgroundColor = .red
     button.addTarget(self, action: #selector(closeFullViewButtonClicked(sender:)), for: .touchUpInside)
     return button
     }()
    
   
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private methods
    private func setupView() {
        layer.masksToBounds = false
        backgroundColor = UIColor().hexStringToUIColor(hex: "#F5F7F6")
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        layer.shadowOpacity = 1
        layer.borderWidth = 2
        layer.borderColor = UIColor.black.cgColor

        addSubview(newsImage)
        addSubview(newsTextLabel)
        self.newsTextLabel.addSubview(closeButton)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        NSLayoutConstraint .activate([
            newsImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            newsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            newsImage.topAnchor.constraint(equalTo: self.topAnchor),
            newsImage.bottomAnchor.constraint(equalTo: newsTextLabel.topAnchor),
            newsImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            newsTextLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor),
            newsTextLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            newsTextLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            newsTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            newsTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            closeButton.bottomAnchor.constraint(equalTo: newsTextLabel.bottomAnchor),
            closeButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
        ])


        NotificationCenter.default.addObserver(self, selector: #selector(setNewsText), name: NSNotification.Name(rawValue: "NewsUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setNewImage), name: NSNotification.Name(rawValue: "ImageUpdated"), object: nil)

    }

    // MARK: - Public methods
   func showImage(from url: String) {
        getImage(from: url, to: newsImage)
    }

    @objc func setNewsText() {
        newsTextLabel.text = viewModel?.news
    }

    @objc func setNewImage() {
        showImage(from: viewModel?.urlToImage ?? "")
    }
    

    // MARK: - Delegate method
    @objc func closeFullViewButtonClicked(sender: UIButton) {
        newsTextLabel.text = ""
        newsImage.image = nil
        delegate?.closeFullViewButtonClicked(sender: sender)
    }

}
