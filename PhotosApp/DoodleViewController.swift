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
        loadJsonFile()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Colse", style: .plain, target: self, action: #selector(dismissView))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        let object = doodles[indexPath.row]
        
        DispatchQueue.main.async {
            if let data: NSData = try? NSData.init(contentsOf: object.image){
                let doodleView = UIImageView()
                doodleView.image = UIImage.init(data: data as Data)
                cell.photoImage = doodleView
            }
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
    }
}
