//
//  SingleTone.swift
//  TSEVA
//
//  Created by Marina Roshchupkina on 16.01.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import Foundation

class App {
    private init() {}
    
    static var shared = App()
    
    var data = [String]()
}
