//
//  WEBViewController.swift
//  RecepieApp
//
//  Created by d.chernov on 24/05/2023.
//

import UIKit
import WebKit

class WEBViewController: UIViewController {
    var url: String?
    
    @IBOutlet weak var web: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        web.load(URLRequest(url: URL(string: url!)!))
        
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
