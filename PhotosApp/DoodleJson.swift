//
//  DoodleJson.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/24.
//

import Foundation

struct DoodleJson {
    let title : String
    let image : URL
    let date : Date
    
    static func toDate(string : String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        return dateFormatter.date(from: string)
    }
    static func toURL(string: String) -> URL?{
        return URL(string: string)
    }
    static func jsonToDoodleJson(to list : [Any]) -> [DoodleJson] {
        var doodles = [DoodleJson]()
        
        list.forEach{ doodle in
            guard let parse = doodle as? [String: Any] else { return }
            guard let title = parse["title"] as? String,
                  let image = parse["image"] as? String,
                  let date = parse["date"] as? String
            else { return }
            
            let object = DoodleJson(title: title, image: DoodleJson.toURL(string: image)!, date: DoodleJson.toDate(string: date)!)
            doodles.append(object)
        }
        return doodles
    }
}
