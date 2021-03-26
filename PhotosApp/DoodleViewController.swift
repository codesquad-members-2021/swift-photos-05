//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/25.
//

import UIKit

private let reuseIdentifier = "doodleCell"
class DoodleViewController: UICollectionViewController {
    
    var doodles = [DoodleVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.navigationItem.title = "Doodles"
        self.collectionView.backgroundColor = .darkGray
        
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        DispatchQueue.global().async {
            self.loadJson()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        DispatchQueue.main.async {
            cell.photoImage.image = self.getImage(index: indexPath.row)
        }
        return cell
    }
}

extension DoodleViewController {
    func getImage(index : Int) -> UIImage {
        let doodle = doodles[index]
        
        if let savedImage = doodle.image {
            return savedImage
        }
        let image = ImageManager.getImage(url: doodle.imageURL)
        doodle.image = image
        return image
    }
    func loadJson() {
        let list = ImageManager.loadJsonFile(forResource: "doodle", withExension: "json")
        doodles = ImageManager.jsonToDoodles(to: list!)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("clicked")
    }
}

