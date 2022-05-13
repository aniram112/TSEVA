//
//  SingleTone.swift
//  TSEVA
//
//  Created by Marina Roshchupkina on 16.01.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import Foundation
import UIKit

class App {
    private init() {}
    
    static var shared = App()
    
    var imageColor = UIColor.red
    //var paletteNames = [String]()
    
    // для тестов и демонстрации
    var paletteNames = ["basic","pastel","dark"]
    var palettes = ["basic": ["#0088CE"],
                    "pastel": ["#D5FFCA","#CAFFDA","#FFFF9E"],
                    "dark": ["#007500", "#A7002C"]]
    
    //var palettes = [[String]]()
    //var palettes: [String: [String]] = [:]
    var data = [String]()
}

