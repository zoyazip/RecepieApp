//
//  RecipyDetailViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 21/05/2023.
//

import UIKit

class RecipyDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var recipy: Recipe?
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipy?.hits.first?.recipe.ingredients.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientCell", for: indexPath)
        
        cell.textLabel?.text = recipy?.hits.first?.recipe.ingredients[indexPath.row].food
        cell.detailTextLabel!.text = (recipy!.hits.first!.recipe.ingredients[indexPath.row].quantity == 0.0 ? "" : String(recipy!.hits.first!.recipe.ingredients[indexPath.row].quantity)) + " " + (recipy!.hits.first!.recipe.ingredients[indexPath.row].measure == "<unit>" ? " pieces" : (recipy!.hits.first!.recipe.ingredients[indexPath.row].measure ?? ""))
        return cell
    }
    

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
        // Do any additional setup after loading the view.
    }
    
    private func initData(){
        let recipyData = recipy?.hits.first?.recipe
        recipyTitle.text = recipyData?.label
        recipyImage.sd_setImage(with: URL(string: recipyData!.image))
        recipyDietType.text = recipyData?.dietLabels.first
        recipyCalories.text = String(recipyData!.calories.rounded())
        recipyTime.text = String(recipyData!.totalTime) + " min"
    }
    
    @IBAction func recipyOpenInBrowser(_ sender: Any) {
    }
    
    @IBAction func saveRacipyBtn(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
