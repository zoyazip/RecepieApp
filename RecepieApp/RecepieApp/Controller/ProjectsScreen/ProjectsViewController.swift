//
//  ProjectsViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 25/05/2023.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var projects: [String : String] = [:]
    
    @IBOutlet weak var projectTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectTable.delegate = self
        projectTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectCellTableViewCell
        
        let keys = Array(projects.keys)
        
        cell.projectName.text = keys[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "githubSegue" {
            guard let destinationVC = segue.destination as? WEBViewController, let row = projectTable.indexPathForSelectedRow?.row else { return
            }
            let projectURL = Array(projects.values)
            
            destinationVC.url = projectURL[row]
            
        }
        
    }
    
}
