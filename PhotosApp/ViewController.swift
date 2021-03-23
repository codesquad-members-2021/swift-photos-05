//
//  ViewController.swift
//  PhotosApp
//
//  Created by 김지선 on 2021/03/22.
//

import UIKit
import Photos
import PhotosUI

class ViewController: UIViewController {

//    @IBOutlet weak var collectionView: UICollectionView!
    
    var allOfPhotos : PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView.dataSource = self
        
        allOfPhotos = PHFetchResult()
        allOfPhotos = PHAsset.fetchAssets(with: nil)
        
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allOfPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        
        imageManager.requestImage(for: allOfPhotos.object(at: indexPath.item), targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { uiimage, dict  in
            
        })
        
//        cell.contentView.backgroundColor = UIColor.random
        return cell
    }
}
