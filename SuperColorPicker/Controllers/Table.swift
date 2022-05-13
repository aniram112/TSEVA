//
//  Table.swift
//  TSEVA
//
//  Created by Marina Roshchupkina on 16.01.2022.
//  Copyright © 2022 Marina Roshchupkina. All rights reserved.
//

import UIKit

class Table: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addPaletteButton(_ sender: Any) {
        var newPaletteName = "new palette"
        
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [self, unowned ac] _ in
            newPaletteName = ac.textFields?[0].text ?? "new palette"
            if (newPaletteName.isEmpty){
                newPaletteName = "new palette"
            }
            if (!App.shared.paletteNames.contains(newPaletteName)){
                App.shared.paletteNames.append(newPaletteName)
                //App.shared.palettes.updateValue([], forKey: newPaletteName)
                App.shared.palettes[newPaletteName] = []
                saveData()

                self.tableView.reloadData()
                
            }
        }
        
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
}

extension Table : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.shared.paletteNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paletteCell", for: indexPath) as! paletteCell
        cell.backgroundColor = .white
        cell.paletteTitle.text = App.shared.paletteNames[indexPath.row]
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension Table: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, bool) in
            App.shared.palettes.removeValue(forKey: App.shared.paletteNames[indexPath.row])
            App.shared.paletteNames.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = UIColor.red
        deleteAction.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func savePalette(indexPath: IndexPath) {
        let count = App.shared.palettes[App.shared.paletteNames[indexPath.row]]!.count
        if (count>0){
            let height = count > 10 ? 50 : 100
            var hex = App.shared.palettes[App.shared.paletteNames[indexPath.row]]![0]
            var image = hexStringToUIColor(hex: hex).image(CGSize(width: 400, height: height))
            for i in 1..<count{
                hex = App.shared.palettes[App.shared.paletteNames[indexPath.row]]![i]
                let image2 = hexStringToUIColor(hex: hex).image(CGSize(width: 400, height: height))
                let newImage = image.mergedSideBySide(with: image2)
                image = newImage
            }
            image.writeToPhotoAlbum(image: image)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let shareAction = UIContextualAction(style: .normal, title: nil) { (action, view, bool) in
            print("shared")
            self.savePalette(indexPath: indexPath)
        }
        shareAction.backgroundColor = UIColor.blue
        shareAction.image = UIImage(systemName: "arrow.down")
        
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
    
}



