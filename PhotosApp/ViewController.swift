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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadJsonFile()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let object = doodles[indexPath.item]
        if let data: NSData = try? NSData.init(contentsOf: object.image){
            cell.photoImage.image = UIImage.init(data: data as Data)
        }

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
    func loadJsonFile() {
        if let file = Bundle.main.url(forResource: "doodle", withExtension: "json") {
            let data = try? Data(contentsOf: file)
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
            json?.forEach{ doodleObject in
                let parse = doodleObject as! [String: Any]
                let title = parse["title"] as! String
                let image = parse["image"] as! String
                let date = parse["date"] as! String
         
                let doodle = DoodleJson(title: title, image: DoodleJson.toURL(string: image)!, date: DoodleJson.toDate(string: date)!)
                doodles.append(doodle)
            }
        }
    }
}
