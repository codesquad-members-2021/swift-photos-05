//
//  ImageManager.swift
//  PhotosApp
//
//  Created by 박혜원 on 2021/03/25.
//

import Foundation

class ImageManager {
    static func loadJsonFile(forResource name : String?, withExension ext : String?) -> [Any]?{
        if let file = Bundle.main.url(forResource: name, withExtension: ext) {
            let data = try? Data(contentsOf: file)
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [Any]
            return json!
        }
        return nil
    }
    
    static func jsonToDoodles(to list : [Any]) -> [DoodleJson] {
        var doodles = [DoodleJson]()
        
        list.forEach{ doodle in
            let object = jsonToDoodle(from: doodle)!
            doodles.append(object)
        }
        return doodles
    }
    
    static func jsonToDoodle(from object: Any) -> DoodleJson? {
        guard let parse = object as? [String: Any] else { return nil }
        guard let title = parse["title"] as? String,
              let image = parse["image"] as? String,
              let date = parse["date"] as? String
        else { return nil }
        
        let doodle = DoodleJson(title: title, image: DoodleJson.toURL(string: image)!, date: DoodleJson.toDate(string: date)!)
        return doodle
    }
}
