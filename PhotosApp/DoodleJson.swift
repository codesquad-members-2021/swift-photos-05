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
}
