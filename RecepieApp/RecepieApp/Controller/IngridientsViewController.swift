//
//  IngridientsViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 21/05/2023.
//

import UIKit

class IngridientsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingridients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientsCell", for: indexPath)
        cell.textLabel?.text = ingridients[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            // Remove item from the array
            self?.ingridients.remove(at: indexPath.row)
            
            // Delete the cell from the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    var ingridients: [String] = []
    
    @IBOutlet weak var ingridientsTextInput: UITextField!
    
    @IBOutlet weak var ingridientTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingridientTable.dataSource = self
        ingridientTable.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addIngridientButton(_ sender: Any) {
        guard let text = ingridientsTextInput.text, !text.isEmpty else {
            return
        }
        
        ingridients.append(text)
        ingridientTable.reloadData()
        
        ingridientsTextInput.text = nil
        view.endEditing(true)
    }
}





/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


