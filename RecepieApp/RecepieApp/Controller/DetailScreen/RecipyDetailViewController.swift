//
//  RecipyDetailViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 21/05/2023.
//

import UIKit
import CoreData

class RecipyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hit: Hit?
    var data: [NSManagedObject] = []
    
    
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    @IBOutlet weak var recipyTitle: UILabel!
    @IBOutlet weak var recipyImage: UIImageView!
    
    @IBOutlet weak var recipyDietType: UILabel!
    
    @IBOutlet weak var recipyTime: UILabel!
    
    @IBOutlet weak var recipyCalories: UILabel!
    
    @IBOutlet weak var recipyIngridients: UITableView!
    
    @IBOutlet weak var cookButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipyIngridients.delegate = self
        recipyIngridients.dataSource = self
        initData()
        fetchCoreData()
        isSaved() ? saveButtonOutlet.setTitle("Saved", for: .normal) : saveButtonOutlet.setTitle("Save", for: .normal)
        print(hit?.recipe.url)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (hit!.recipe.ingredients.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientCell", for: indexPath)
        
        cell.textLabel?.text = hit!.recipe.ingredients[indexPath.row].food.capitalized
        cell.detailTextLabel!.text = (hit!.recipe.ingredients[indexPath.row].quantity == 0.0 ? "" : String(hit!.recipe.ingredients[indexPath.row].quantity)) + " " + (hit!.recipe.ingredients[indexPath.row].measure == "<unit>" ? " pieces" : (hit!.recipe.ingredients[indexPath.row].measure ?? ""))
        return cell
    }
    
    
    private func initData(){
        let recipyData = hit?.recipe
        recipyTitle.text = recipyData?.label
        recipyImage.sd_setImage(with: URL(string: recipyData!.image))
        recipyDietType.text = recipyData!.dietLabels.first
        recipyCalories.text = String(recipyData!.calories.rounded())
        recipyTime.text = String(recipyData!.totalTime == 0 ? 100 : recipyData!.totalTime) + " min"
    }
    
    
    @IBAction func saveRecipeButton(_ sender: Any) {
        saveDataToCoreData()
        saveButtonOutlet.setTitle("Saved", for: .normal)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeb" {
            if let destinationVC = segue.destination as? WEBViewController{
                destinationVC.url = hit?.recipe.url
            }
        }
    }
    
    func saveDataToCoreData(){
        
        let rawData = hit?.recipe
        let recipeTitle = rawData!.label
        let recipeImage = rawData!.image
        let recipeUrl = rawData!.url
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entityName = "SavedRecipes"
        
        // Check if the string already exists in Core Data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "title = %@", recipeTitle)
        fetchRequest.predicate = NSPredicate(format: "image = %@", recipeImage)
        fetchRequest.predicate = NSPredicate(format: "url = %@", recipeUrl)
        
        do {
            let fetchResults = try managedContext.fetch(fetchRequest)
            if fetchResults.isEmpty {
                // The string doesn't exist, create a new object and save it
                guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else {
                    return
                }
                
                let object = NSManagedObject(entity: entity, insertInto: managedContext)
                object.setValue(recipeTitle, forKey: "title")
                object.setValue(recipeImage, forKey: "image")
                object.setValue(recipeUrl, forKey: "url")
                
                do {
                    try managedContext.save()
                    
                    print("String data saved to Core Data successfully.")
                } catch {
                    print("Error saving string data to Core Data: \(error.localizedDescription)")
                }
            } else {
                print("String data already exists in Core Data.")
            }
        } catch {
            print("Error fetching data from Core Data: \(error.localizedDescription)")
        }
    }
    
    func fetchCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedRecipes")
        
        do {
            data = try managedContext.fetch(fetchRequest)
        } catch {
            print("Error fetching data from Core Data: \(error.localizedDescription)")
        }
    }
    
    func isSaved() -> Bool{
        for i in data{
            let savedTitle = (i.value(forKey: "title") as? String) ?? ""
            if hit?.recipe.label == savedTitle{
                return true
            }
        }
        return false
    }
    
}
