//
//  ViewController.swift
//  Butterflyyy
//
//  Created by David Guo on 1/8/21.
//
import UIKit
import Foundation

class ViewController: UIViewController {
//outlets
    @IBOutlet var bluefly: UIImageView!
    @IBOutlet var leaffly: UIImageView!
    @IBOutlet var monarchfly: UIImageView!
    @IBOutlet var Butt: UITextField!
    @IBOutlet var TextQuote: UITextView!
    
    
    //request for Rest API
    private func getData(from url: String){
       let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
   
        guard let data = data, error == nil else{
            print("something went wrong")
            return
        }
             
            var result: Welcome?
            do{
                result = try JSONDecoder().decode(Welcome.self, from: data)
            }
            catch{
                print("failed to convert \(error.localizedDescription)")
            }
            guard let json = result else{
                return
            }
        DispatchQueue.main.async {self.TextQuote.text = json.contents.quotes[0].quote}
        
  
        })
       task.resume()
        
    }
 
 //rounding for images
    override func viewDidLoad() {
        super.viewDidLoad()
        

        leaffly.layer.cornerRadius = 25
        leaffly.clipsToBounds = true
        
        bluefly.layer.cornerRadius = 25
        bluefly.clipsToBounds = true
        
        
        monarchfly.layer.cornerRadius = 25
        monarchfly.clipsToBounds = true
        
        
      //  URL variable
        
      let url = "http://quotes.rest/qod.json"
        
       getData(from: url)

    }
  
   
}



    
// Structs for the JSON file
struct Welcome: Decodable {
    let success: Success
    let contents: Contents
    let baseurl: String
    let copyright: Copyright
}


struct Contents: Decodable {
    let quotes: [Quote]
}


struct Quote: Decodable {
    let quote, length, author: String
    let tags: [String]
    let category, language, date: String
    let permalink: String
    let id: String
    let background: String
    let title: String
}

struct Copyright: Decodable {
    let year: Int
    let url: String
}


struct Success: Decodable {
    let total: Int
}


