//
//  RecipyDetailViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 21/05/2023.
//

import UIKit

class RecipyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var hit: Hit?
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (recipy?.hits.first?.recipe.ingredients.count)!
        return (hit!.recipe.ingredients.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientCell", for: indexPath)
        
        cell.textLabel?.text = hit!.recipe.ingredients[indexPath.row].food.capitalized
        cell.detailTextLabel!.text = (hit!.recipe.ingredients[indexPath.row].quantity == 0.0 ? "" : String(hit!.recipe.ingredients[indexPath.row].quantity)) + " " + (hit!.recipe.ingredients[indexPath.row].measure == "<unit>" ? " pieces" : (hit!.recipe.ingredients[indexPath.row].measure ?? ""))
        return cell
    }
    

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var recipyTitle: UILabel!
    @IBOutlet weak var recipyImage: UIImageView!
    
    @IBOutlet weak var recipyDietType: UILabel!
    
    @IBOutlet weak var recipyTime: UILabel!
    
    @IBOutlet weak var recipyCalories: UILabel!
    
    
    @IBOutlet weak var recipyIngridients: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipyIngridients.delegate = self
        recipyIngridients.dataSource = self
        initData()
        sendButton.backgroundColor = UIColor.systemPink
        
        // Do any additional setup after loading the view.
    }
    
    private func initData(){
        let recipyData = hit?.recipe
        recipyTitle.text = recipyData?.label
        recipyImage.sd_setImage(with: URL(string: recipyData!.image))
        recipyDietType.text = recipyData!.dietLabels.first
        recipyCalories.text = String(recipyData!.calories.rounded())
        recipyTime.text = String(recipyData!.totalTime == 0 ? 100 : recipyData!.totalTime) + " min"
    }
    
    @IBAction func recipyOpenInBrowser(_ sender: Any) {
        
    }
    
    @IBAction func saveRacipyBtn(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeb" {
            if let destinationVC = segue.destination as? WEBViewController{
                destinationVC.url = hit?.recipe.url
            }
        }
    }
    

}
