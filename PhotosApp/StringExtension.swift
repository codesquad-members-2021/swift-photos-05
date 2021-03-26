//
//  StringExtension.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/25.
//

import Foundation
extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        return dateFormatter.date(from: self)
    }
}
