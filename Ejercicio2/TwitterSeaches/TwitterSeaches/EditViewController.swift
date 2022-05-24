//
//  EditViewController.swift
//  TwitterSeaches
//
//  Created by LABORATORIOS on 24/5/22.
//

import UIKit

class EditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tweets:[Twitter]?
    
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
   
   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
       return .delete
   }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectTweets = self.tweets![indexPath.row]
        
        let alertOption = UIAlertController(title: "Options",message: "Edit or Share your search",preferredStyle: UIAlertController.Style.alert)
        alertOption.addTextField{ (textField) in
            textField.text = selectTweets.twitter
        }
        alertOption.addTextField{ (textField) in
            textField.text = selectTweets.name
            textField.isUserInteractionEnabled = false
        }
        alertOption.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            let textTweets = alertOption.textFields![0]
            selectTweets.twitter = textTweets.text
            
            do{
                try self.context.save()
            }
            catch{
                
            }
            self.getTwitters()
        }))
        alertOption.addAction(UIAlertAction(title: "Share", style: .default, handler: { _ in
            let selectTweets = self.tweets![indexPath.row]
            let textTweets = alertOption.textFields![0]
            selectTweets.twitter = textTweets.text
            let link = "https://mobile.twitter.com/search/?q=" + selectTweets.twitter!
            let share = UIActivityViewController(activityItems: [link], applicationActivities: nil)
            share.popoverPresentationController?.sourceView = self.view
            let excludedActivities = [UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.print, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToFlickr, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.postToTencentWeibo,]
            
            share.excludedActivityTypes = excludedActivities
            self.present(share, animated: true, completion: nil)
        }))
        
        alertOption.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alertOption, animated: true, completion: nil)
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
       let deleteTweets = self.tweets![indexPath.row]
       self.context.delete(deleteTweets)
       do{
           try self.context.save()
       }
       catch{
           
       }
       self.getTwitters()
   }
    
    @IBAction func backViewController(){
        dismiss(animated: true, completion: nil)
       
    }

}
