//
//  MainTableViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 21/05/2023.
//

import UIKit
import SDWebImage

class MainTableViewController: UITableViewController {
    private var recipes: [Recipe] = []
    
    
    
    private var hits: [Hit] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(title: "Chicken")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func getData(title: String) {
        
        NetworkManager.fetchData(title: title) { [weak self] recipe, error in
            DispatchQueue.main.async {
                if let _ = error {
                    self?.showErrorAlert(title: title)
                } else {
                    self?.recipes = [recipe!]
                    self?.recipes.forEach { recipe in
                        self?.hits = recipe.hits
                    }
                    
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return hits.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainRecipeCell", for: indexPath) as! MainRecipeCellTableViewCell
        
        
        cell.country.text = hits[indexPath.row].recipe.cuisineType.first?.capitalized
        cell.recipeName.text = hits[indexPath.row].recipe.label
        cell.recipeRating.text = hits[indexPath.row].recipe.yield.description
        cell.recipeImage.sd_setImage(with: URL(string: (hits[indexPath.row].recipe.image)))
        cell.recipeTime.text = String(hits[indexPath.row].recipe.totalTime == 0 ? 100 : hits[indexPath.row].recipe.totalTime) + " min"
        
        let caution = hits[indexPath.row].recipe.cautions.first
        
        if caution != nil {
            cell.recipeCaution.text = hits[indexPath.row].recipe.cautions.first
            cell.recipeCaution.backgroundColor = UIColor.systemPink
        }
        else{
            cell.recipeCaution.text = "Healthy"
            cell.recipeCaution.backgroundColor = UIColor.systemMint
        }
        cell.recipeCaution.textColor = UIColor.white
        cell.recipeCaution.layer.cornerRadius = 17
        cell.recipeCaution.clipsToBounds = true
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipyDetailSegue" {
            guard let destinationVC = segue.destination as? RecipyDetailViewController, let row = tableView.indexPathForSelectedRow?.row else { return
            }
            
            destinationVC.hit = hits[row]
            
        }
    }
    
    @IBAction func searchBarButton(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        
        let alertController = UIAlertController(title: "What are you going to eat?", message: "Please enter recipe name", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Recipe Name"
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { _ in
            if let recipeName = alertController.textFields?.first?.text {
                self.getData(title: recipeName)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(searchAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func showErrorAlert(title: String){
        let alertController = UIAlertController(title: "Something went wrong..", message: "Sorry, but we don't have any \(title) recipy..", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}


