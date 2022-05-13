//
//  DataMethods.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 13.05.2022.
//  Copyright © 2022 Sonia Kucheryavaya. All rights reserved.
//

import Foundation
func saveData(){
    UserDefaults.standard.set(App.shared.palettes, forKey: "palettes")
    UserDefaults.standard.set(App.shared.paletteNames, forKey: "paletteNames")
    UserDefaults.standard.synchronize()
}

func loadData(){
    if let array = UserDefaults.standard.dictionary(forKey: "palettes") as? [String: [String]] {
        App.shared.palettes = array
    } else{
        
        App.shared.palettes = ["basic": ["#0088CE"],
                               "pastel": ["#D5FFCA","#CAFFDA","#FFFF9E"],
                               "dark": ["#007500", "#A7002C"]]
        //App.shared.palettes = [:] для прода
        
    }
    
    if let arrayNames = UserDefaults.standard.array(forKey: "paletteNames") as? [String] {
        App.shared.paletteNames = arrayNames
    } else{
        
        App.shared.paletteNames = ["basic","pastel","dark"]
        //App.shared.paletteNames = [String]() для прода
        
    }
}
