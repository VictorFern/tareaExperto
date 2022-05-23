//
//  EditViewController.swift
//  TwitterSearches
//
//  Created by LABORATORIOS on 23/5/22.
//

import UIKit

class EditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var names = ["Jonh Smith", "Dan Smith", "Jasson Smith", "Mary Smith"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       cell.textLabel?.text = names[indexPath.row]
       return cell
   }
   
   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
       return .delete
   }
   
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
       if editingStyle == .delete{
           tableView.beginUpdates()
           names.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
           tableView.endUpdates()
       }
   }
    
    @IBAction func openEditSecondViewController(){
        let vc = storyboard?.instantiateViewController(identifier: "editsecond_vc") as! EditSecondViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func sharePressed(sender: Any){
        let share = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
        share.popoverPresentationController?.sourceView = self.view
        self.present(share, animated: true, completion: nil)
    }
    
    @IBAction func backViewController(){
        dismiss(animated: true, completion: nil)
    }
}
