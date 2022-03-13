//
//  colorCell.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 13.03.2022.
//  Copyright © 2022 Sonia Kucheryavaya. All rights reserved.
//

import UIKit

class paletteCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paletteTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        App.shared.palettes[paletteTitle.text!]!.count
        //1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! colorCell
        
        //cell.colorSquare.backgroundColor = .blue
          //  = hexStringToUIColor(hex: App.shared.data[indexPath.row])
        //cell.colorHex.text = "blue"
            //= App.shared.data[indexPath.row]
        
        
        //let colors = App.shared.palettes[paletteTitle.text!]!
        
        cell.colorSquare.backgroundColor = hexStringToUIColor(hex: App.shared.palettes[paletteTitle.text!]![indexPath.row])
        cell.colorHex.text = App.shared.palettes[paletteTitle.text!]![indexPath.row]
        
        //cell.colorHex.text = String(App.shared.palettes[paletteTitle.text!]!.count)
        cell.colorHex.textColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:120,height:130)
    }
}


