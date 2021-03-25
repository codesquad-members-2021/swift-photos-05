//
//  ImageManager.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/25.
//

import UIKit

class ImageManager {
    
    // Json 파일을 읽어오는 함수
    static func loadJsonFile(forResource name : String?, withExension ext : String?) -> [Any]?{
        if let file = Bundle.main.url(forResource: name, withExtension: ext) {
            let data = try? Data(contentsOf: file)
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
            return json!
        }
        return nil
    }
    
    // 읽어 온 Json 파일을 DoodleVo의 배열로 파싱하는 함수
    static func jsonToDoodles(to list : [Any]) -> [DoodleVO] {
        var doodles = [DoodleVO]()
        
        list.forEach{ doodle in
            let object = jsonToDoodle(from: doodle)!
            doodles.append(object)
        }
        return doodles
    }
    
    static private func jsonToDoodle(from object: Any) -> DoodleVO? {
        guard let parse = object as? [String: Any] else { return nil }
        guard let title = parse["title"] as? String,
              let imageURLString = parse["image"] as? String,
              let dateString = parse["date"] as? String
        else { return nil }
        
        let imageURL = URL(string: imageURLString)!
        let date = dateString.toDate()
        
        let doodle = DoodleVO(title: title, imageURL: imageURL, date: date!)
        return doodle
    }
    
    static func getImage(url : URL) -> UIImage {
        var image : UIImage?
        do {
            let data : Data = try Data.init(contentsOf: url)
            image = UIImage.init(data: data as Data)
        }catch {
            NSLog("getImage Error")
        }
        return image ?? UIImage()
    }
}
