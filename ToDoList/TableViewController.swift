//
//  TableViewController.swift
//  ToDoList
//
//  Created by olli on 26.04.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground
    }
    
    @IBAction func pushAddAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Create new task", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "New task"
        }
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in }
        let alertAction2 = UIAlertAction(title: "Create", style: .default) { (alert) in
            
            // добавить новую запись
            let newItem = alertController.textFields![0].text
            if newItem != "" {
                addItem(nameItem: newItem!)
                self.tableView.reloadData()
            }
        }

        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = toDoItems[indexPath.row]
        cell.textLabel?.text = currentItem["Name"] as? String
        
        if (currentItem["isCompleted"] as? Bool) == true {
            cell.imageView?.image = UIImage(named: "done")
        } else {
            cell.imageView?.image = UIImage(named: "doneno")
        }
        return cell
    }

    // Вкл/выкл редактирование
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Редактирование
    // Удаление
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // обрабатываем нажатие
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // снимаем выделение
        tableView.deselectRow(at: indexPath, animated: true)
        
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage.init(named: "done")
        } else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage.init(named: "doneno")
        }
    }
    
    // Вызывается когда ячейки меняем местами
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
