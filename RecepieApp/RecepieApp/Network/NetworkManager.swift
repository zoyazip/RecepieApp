//
//  NetworkManager.swift
//  RecepieApp
//
//  Created by d.chernov on 16/05/2023.
//

import Foundation

class NetworkManager{
    static func fetchData(title: String, completition: @escaping (Recipe?, Error?) -> () ){
        
        guard let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&q=\(title == "" ? "chicken" : title)&app_id=276b6a64&app_key=bc73e9788e6893884c56e4c98854ddb8") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                print("Error+++", error!)
                return
            }
            
            print("Response", response as Any)
            
            guard let data = data else {return}
            do{
                let jsonData = try JSONDecoder().decode(Recipe.self, from: data)
                completition(jsonData, nil)
            }
            catch{
                completition(nil, error)
                print("Error+++ ", error)
            }
            
        }.resume()
    }
    
}
