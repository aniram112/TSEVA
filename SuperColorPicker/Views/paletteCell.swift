//
//  colorCell.swift
//  SuperColorPicker
//
//  Created by Marina Roshchupkina on 13.03.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import UIKit

class paletteCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var paletteTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.reloadData()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! colorCell
        
        cell.colorSquare.layer.masksToBounds = true
        cell.colorSquare.layer.cornerRadius = 10
        cell.colorSquare.backgroundColor = hexStringToUIColor(hex: App.shared.palettes[paletteTitle.text!]![indexPath.row])
        cell.colorHex.text = App.shared.palettes[paletteTitle.text!]![indexPath.row]
        cell.colorHex.textColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:120,height:130)
    }
}


