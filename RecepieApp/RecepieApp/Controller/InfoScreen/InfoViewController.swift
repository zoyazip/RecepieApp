//
//  InfoViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 25/05/2023.
//

import UIKit

class InfoViewController: UIViewController {
    let info = Info()
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var jobTitle: UILabel!
    
    @IBOutlet weak var appName: UILabel!
    
    @IBOutlet weak var appVersion: UILabel!
    
    @IBOutlet weak var appDate: UILabel!
    
    @IBOutlet weak var appDescription: UILabel!
    
    @IBOutlet weak var otherProjectsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.image = UIImage(named: info.picture)
        authorName.text = info.author
        jobTitle.text = info.job
        appName.text = info.appName
        appVersion.text = info.appVersion
        appDate.text = info.appReleaseDate
        appDescription.text = info.appDescription
        
        profilePic.layer.cornerRadius = profilePic.bounds.width / 2
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projectSegue" {
            let destinationVC = segue.destination as? ProjectsViewController
            
            destinationVC!.projects = info.githubLinks
            
        }
    }
    
    
}
