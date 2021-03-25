//
//  DoodleViewController.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/25.
//

import UIKit

private let reuseIdentifier = "Cell"

class DoodleViewController: UICollectionViewController {

    var doodles = [DoodleJson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doodles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let object = doodles[indexPath.item]
        
        DispatchQueue.main.async {
            if let data: NSData = try? NSData.init(contentsOf: object.image){
                cell.photoImage.image = UIImage.init(data: data as Data)
            }
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

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
