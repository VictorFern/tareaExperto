//
//  ViewController.swift
//  TwitterSeaches
//
//  Created by LABORATORIOS on 24/5/22.
//

import UIKit
import WebKit
import SafariServices
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tweets:[Twitter]?
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTwitters()
        
    }
 
    @IBAction func addTweets(_ sender: Any){
        let alert = UIAlertController(title: "Add Search",message: "",preferredStyle: UIAlertController.Style.alert)
        alert.addTextField{ (textField) in
            textField.placeholder = "Enter Twitter search query"
        }
        alert.addTextField{ (textField) in
            textField.placeholder = "Tag your query"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
        
            let newtwitter = Twitter(context: self.context)
            newtwitter.name = alert.textFields![1].text
            newtwitter.twitter = alert.textFields![0].text
            
            do{
                try self.context.save()
            }
            catch{
                
            }
            self.getTwitters()
        }))
        present(alert, animated: true)
    }
    
    func getTwitters(){
        do{
            self.tweets = try context.fetch(Twitter.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tweetsAux = self.tweets![indexPath.row]
        cell.textLabel?.text = tweetsAux.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectTweets = self.tweets![indexPath.row]
        
        let link = "https://mobile.twitter.com/search/?q="
        let tweetsUrl = selectTweets.twitter!
        let salida = link + tweetsUrl
        
        let vc = SFSafariViewController(url: URL(string: salida)!)
        
        present(vc, animated: true)
    }
    @IBAction func openEditViewController(){
        let vc = storyboard?.instantiateViewController(identifier: "edit_vc") as! EditViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}

