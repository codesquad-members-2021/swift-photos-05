//
//  PhotoCell.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/23.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    public var photoImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    func configure(){
        self.addSubview(photoImage)
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.contentMode = .scaleAspectFill
        photoImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
}
