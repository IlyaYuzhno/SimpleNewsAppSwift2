//
//  UIView+Helpers.swift
//  SimpleNewsAppSwift
//
//  Created by Ilya Doroshkevitch on 18.08.2021.
//

import UIKit

public extension UIView {
    func getImage(from imageUrl: String, to imageView: UIImageView) {
        guard let url = URL(string: imageUrl ) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
  }
