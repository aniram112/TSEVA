//
//  Table.swift
//  SuperColorPicker
//
//  Created by Sonia Kucheryavaya on 02/07/2019.
//  Copyright © 2019 Sonia Kucheryavaya. All rights reserved.
//

import UIKit

class Table: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
tableView.dataSource = self
tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
  
}
extension Table : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.shared.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
        cell.backgroundColor = hexStringToUIColor(hex: App.shared.data[indexPath.row])
        cell.textLabel?.text = App.shared.data[indexPath.row]
        return cell
    }
   
}
extension Table: UITableViewDelegate {
//функция для свайпа delete - хз, работает ли
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        App.shared.data.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
   /* } else if editingStyle == .insert {
       */
    }
}
}
