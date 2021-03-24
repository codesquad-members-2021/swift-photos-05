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
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var allOfPhotos : PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    var doodles = [DoodleJson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "Photos"
        allOfPhotos = PHAsset.fetchAssets(with: nil)
        
        PHPhotoLibrary.shared().register(self)
        loadJsonFile()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allOfPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        imageManager.requestImage(for: allOfPhotos.object(at: indexPath.item), targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: { uiimage, _  in
            cell.photoImage.image = uiimage
        })
        return cell
    }
}

extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        if let changed = changeInstance.changeDetails(for: allOfPhotos){
            allOfPhotos = changed.fetchResultAfterChanges
            
            DispatchQueue.main.sync {
                self.photoCollectionView.reloadData()
            }
        }
    }

}

extension ViewController {
    func loadJsonFile() -> [DoodleJson] {
        if let file = Bundle.main.url(forResource: "doodle", withExtension: "json") {
            let data = try? Data(contentsOf: file)
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
            
        }
    }
}
