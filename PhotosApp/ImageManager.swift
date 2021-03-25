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
}
