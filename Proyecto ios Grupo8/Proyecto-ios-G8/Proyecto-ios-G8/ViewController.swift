//
//  ViewController.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 7/6/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet var menuHide: UIBarButtonItem!
    
    @IBOutlet var menuShow: UIBarButtonItem!
    @IBOutlet var menu: UITableView!
    
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    var menuOption = false
    let screen = UIScreen.main.bounds
    var home = CGAffineTransform()
    var options: [option] = [
        option(title: "Inicio", segue:"InicioSegue"),
        option(title: "Mapa", segue:"MapaSegue"),
        option(title: "Sitios Turisticos", segue:"SitiosTuristicosSegue"),
        option(title: "Ofertas", segue:"OfertasSegue"),
        option(title: "Videos", segue:"VideosSegue"),
        option(title: "Creditos", segue:"CreditosSegue"),
        option(title: "Galeria", segue:"GaleriaSegue"),
        option(title: "Login", segue:"LoginSegue"),
        option(title: "Carrito", segue:"CarritoSegue")
        
    
    ]
    struct option{
        var title = String()
        var segue = String()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        menu.delegate = self
        menu.dataSource = self
        menu.backgroundColor = .clear
        home = containerView.transform
        menuHide.isEnabled = false
        menuHide.title = ""
        // Do any additional setup after loading the view.
    }
    
    func showMenu() {
        self.containerView.layer.cornerRadius = 40
        let x = screen.width * -0.8
        let originalTransform = self.containerView.transform
        let scaledTransform = originalTransform.scaledBy(x: 0.8, y: 0.8)
        let scaledAndTranslatedTransform = scaledTransform.translatedBy(x: x, y: 0)
        UIView.animate(withDuration: 0.7, animations: {
            self.containerView.transform = scaledAndTranslatedTransform
        })
    }
        
    @IBAction func hidemenus(_ sender: Any) {
        if menuOption == true {
            print("user is hiding menu")
            hideMenu()
            menuOption = false
            menuHide.isEnabled = false
            menuHide.title = ""
            menuShow.isEnabled = true
            menuShow.title = "☰"
        }
    }
    @IBAction func showMenus(_ sender: Any) {
        print("menu interaction")
        if menuOption == false && swipeGesture.direction == .right {
            print("user is showing menu")
            showMenu()
            menuOption = true
            menuHide.isEnabled = true
            menuHide.title = "☰"
            menuShow.isEnabled = false
            menuShow.title = ""
        }
    }

    func hideMenu() {
        UIView.animate(withDuration: 0.7, animations: {
            self.containerView.transform = self.home
            self.containerView.layer.cornerRadius = 0
        })
    }
    
    @IBAction func showMenu(_ sender: UISwipeGestureRecognizer) {
        print("menu interaction")
        if menuOption == false && swipeGesture.direction == .right {
            print("user is showing menu")
            showMenu()
            menuOption = true
                    
        }
    }
    @IBAction func hideMenu(_ sender: Any) {
        if menuOption == true {
            print("user is hiding menu")
            hideMenu()
            menuOption = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let menuAux = self.options[indexPath.row]
        cell.textLabel?.text = menuAux.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        menu.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: options[row].segue, sender: self)

    }

}


