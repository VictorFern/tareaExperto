//
//  SaveViewController.swift
//  TwitterSearches
//
//  Created by LABORATORIOS on 23/5/22.
//

import UIKit

class SaveViewController: UIViewController {

    @IBOutlet weak var query: UITextField!
    
    @IBOutlet weak var tweets: UITextField!
    
    var twitter = Twitter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func save(){
        twitter.twiter = query.text!
        twitter.name = tweets.text!
        print(twitter.twiter)
        twitter.almacenarTwitter(nuevoTwitter: twitter)
        print(twitter.lista[0].name)
    }
    
    @IBAction func backViewController(){
        dismiss(animated: true, completion: nil)
    }
}
