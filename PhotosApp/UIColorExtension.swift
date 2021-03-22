//
//  UIColorExtension.swift
//  PhotosApp
//
//  Created by 김지선 on 2021/03/22.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
