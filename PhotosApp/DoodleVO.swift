//
//  DoodleJson.swift
//  PhotosApp
//
//  Created by Elly on 2021/03/24.
//

import UIKit

class DoodleVO {
    let title : String
    let imageURL : URL
    var image : UIImage?
    let date : Date
    
    init(title : String, imageURL : URL, date : Date){
        self.title = title
        self.imageURL = imageURL
        self.image = nil
        self.date = date
    }
}
