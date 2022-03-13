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
            tableView.deleteRows(at: [indexPath], with: .fade)
            /* } else if editingStyle == .insert {
             */
        }
    }
}
