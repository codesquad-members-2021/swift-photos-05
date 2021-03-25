//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/25.
//

import UIKit

private let reuseIdentifier = "doodleCell"
class DoodleViewController: UICollectionViewController {
    
    var doodles = [DoodleJson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Doodles"
        self.collectionView.backgroundColor = .darkGray
        
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        DispatchQueue.global().async {
            self.loadJsonFile()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let doodle = doodles[indexPath.row]
        
        if let data: NSData = try? NSData.init(contentsOf: doodle.image){
            cell.photoImage.image = UIImage.init(data: data as Data)
        }
        return cell
    }
}

extension DoodleViewController {
    func loadJsonFile() {
        let anyList = ImageManager.loadJsonFile(forResource: "doodle", withExension: "json")
        doodles = ImageManager.jsonToDoodles(to: anyList!)
    
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension DoodleViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 50)
    }
}
