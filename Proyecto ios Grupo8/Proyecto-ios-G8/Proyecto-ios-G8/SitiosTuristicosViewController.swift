//
//  SitiosTuristicosViewController.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 7/6/22.
//

import UIKit

class SitiosTuristicosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var card: UIView!
    var count = 0
    let sitios = [SitiosTuristicos(titulo:"Conocer el arte precolombino en el Museo del Jade",descripcion: "Es el único museo del mundo dedicado al jade, piedra a la que los antiguos habitantes de Costa Rica asociaban con sabiduría, serenidad y buena suerte.", id: 1,precio: 50000, imagen: "museo-del-jade-costa-rica"),SitiosTuristicos(titulo:"Traslado privado desde el Parque Nacional Manuel Antonio al aeropuerto SJO",descripcion: "El final de las vacaciones es bastante difícil, así que ahórrese el estrés de la partida con un traslado privado desde el Parque Nacional Manuel Antonio o Quepos hasta el Aeropuerto Internacional de San José.", id: 2,precio: 20000, imagen: "manuel-antonio")]
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
   
    
    @IBOutlet var imagenView: UIImageView!
    @IBOutlet var precioText: UITextField!
    @IBOutlet var descripcionText: UITextView!
    @IBOutlet var titulolbl: UILabel!
    @IBOutlet var menuHide: UIBarButtonItem!
    @IBOutlet var menuShow: UIBarButtonItem!
    @IBOutlet var menu: UITableView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var nextCarrusel: UIButton!
    @IBOutlet var backCarrusel: UIButton!
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
        menuHide.image = UIImage(systemName: "")
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.black.cgColor
        titulolbl.text = sitios[0].getTitulo()
        descripcionText.text = sitios[0].getDescripcion()
        precioText.text = String(sitios[0].getPreio())+"₡"
        imagenView.image = UIImage(named: sitios[0].getImagen())

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
    
    @IBAction func next(_ sender: Any) {
        count += 1
        if(count < sitios.count){
            titulolbl.text = sitios[count].getTitulo()
            descripcionText.text = sitios[count].getDescripcion()
            precioText.text = String(sitios[count].getPreio())+"₡"
            imagenView.image = UIImage(named: sitios[count].getImagen())
        }else{
            titulolbl.text = sitios[0].getTitulo()
            descripcionText.text = sitios[0].getDescripcion()
            precioText.text = String(sitios[0].getPreio())+"₡"
            imagenView.image = UIImage(named: sitios[0].getImagen())
            count = 0
        }
        
    }
    
    
    @IBAction func back(_ sender: Any) {

        if(count == 0){
            count = sitios.count-1
            titulolbl.text = sitios[count].getTitulo()
            descripcionText.text = sitios[count].getDescripcion()
            precioText.text = String(sitios[count].getPreio())+"₡"
            imagenView.image = UIImage(named: sitios[count].getImagen())
        }else if(sitios.count > count){
            count -= 1
            titulolbl.text = sitios[count].getTitulo()
            descripcionText.text = sitios[count].getDescripcion()
            precioText.text = String(sitios[count].getPreio())+"₡"
            imagenView.image = UIImage(named: sitios[count].getImagen())
        }
        
        
    }
    
    @IBAction func hidemenus(_ sender: Any) {
        if menuOption == true {
            print("user is hiding menu")
            hideMenu()
            menuOption = false
            menuHide.isEnabled = false
            menuHide.image = UIImage(systemName: "")
            menuShow.isEnabled = true
            menuShow.image = UIImage(systemName: "line.horizontal.3")
        }
    }
    @IBAction func showMenus(_ sender: Any) {
        print("menu interaction")
        if menuOption == false && swipeGesture.direction == .right {
            print("user is showing menu")
            showMenu()
            menuOption = true
            menuHide.isEnabled = true
            menuHide.image = UIImage(systemName: "xmark")
            menuShow.isEnabled = false
            menuShow.image = UIImage(systemName: "")
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

}
