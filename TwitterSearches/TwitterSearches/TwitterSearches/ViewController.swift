//
//  ViewController.swift
//  TwitterSearches
//
//  Created by LABORATORIOS on 23/5/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var twitter = Twitter()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return twitter.lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = twitter.lista[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }
    
    @IBAction func openSaveViewController(){
        let vc = storyboard?.instantiateViewController(identifier: "save_vc") as! SaveViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func openEditViewController(){
        let vc = storyboard?.instantiateViewController(identifier: "edit_vc") as! EditViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}

