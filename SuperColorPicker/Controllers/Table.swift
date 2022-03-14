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
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
            newPaletteName = ac.textFields![0].text ?? "new palette"
            if (!App.shared.paletteNames.contains(newPaletteName)){
                App.shared.paletteNames.append(newPaletteName)
                App.shared.palettes.updateValue([], forKey: newPaletteName)
                self.tableView.reloadData()
                saveData()
                
            }
            // do something interesting with "answer" here
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
        //cell.backgroundColor = hexStringToUIColor(hex: App.shared.data[indexPath.row])
        //cell.textLabel?.text = App.shared.data[indexPath.row]
        //cell.paletteTitle.text = App.shared.data[indexPath.row]
        cell.paletteTitle.text = App.shared.paletteNames[indexPath.row]
        return cell
    }
    
}
extension Table: UITableViewDelegate {
    //функция для свайпа delete - хз, работает ли
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //App.shared.data.remove(at: indexPath.row)
            App.shared.palettes.removeValue(forKey: App.shared.paletteNames[indexPath.row])
            App.shared.paletteNames.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            /* } else if editingStyle == .insert {
             */
        }
    }
}
