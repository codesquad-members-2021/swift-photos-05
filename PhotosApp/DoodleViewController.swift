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
