//
//  ViewController.swift
//  Butterflyyy
//
//  Created by David Guo on 1/8/21.
//
import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var bluefly: UIImageView!
    @IBOutlet var leaffly: UIImageView!
    @IBOutlet var monarchfly: UIImageView!
    @IBOutlet var Butt: UITextField!
    @IBOutlet var TextQuote: UITextView!
    
    var x: String = ""
    
    
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
 
 //
    override func viewDidLoad() {
        super.viewDidLoad()
        

        leaffly.layer.cornerRadius = 25
        leaffly.clipsToBounds = true
        
        bluefly.layer.cornerRadius = 25
        bluefly.clipsToBounds = true
        
        
        monarchfly.layer.cornerRadius = 25
        monarchfly.clipsToBounds = true
        
        
      //  Do any additional setup after loading the view.
        
      let url = "http://quotes.rest/qod.json"
        
       getData(from: url)

    }
  
   
}



    
// MARK: - Welcome
struct Welcome: Decodable {
    let success: Success
    let contents: Contents
    let baseurl: String
    let copyright: Copyright
}

// MARK: - Contents
struct Contents: Decodable {
    let quotes: [Quote]
}

// MARK: - Quote
struct Quote: Decodable {
    let quote, length, author: String
    let tags: [String]
    let category, language, date: String
    let permalink: String
    let id: String
    let background: String
    let title: String
}

// MARK: - Copyright
struct Copyright: Decodable {
    let year: Int
    let url: String
}

// MARK: - Success
struct Success: Decodable {
    let total: Int
}


