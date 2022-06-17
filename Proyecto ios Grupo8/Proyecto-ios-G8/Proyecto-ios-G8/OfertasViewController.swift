//
//  OfertasViewController.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 16/6/22.
//

import UIKit

class OfertasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var card: UIView!
    var count = 0
    var count2 = 0
    @IBOutlet var menuHide: UIBarButtonItem!
    
    @IBOutlet var menuShow: UIBarButtonItem!
    @IBOutlet var menu: UITableView!
    
    @IBOutlet var imageHeader: UIImageView!
    @IBOutlet var containerView: UIView!
    
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var imagenView: UIImageView!
    @IBOutlet var precioText: UITextField!
    @IBOutlet var descripcionText: UITextView!
    @IBOutlet var titulolbl: UILabel!
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
        getOfertas(index: 0)
        // Do any additional setup after loading the view.
    }
    
    func getOfertas(index: Int){
        let url = URL(string: "http://apiexpertos-001-site1.itempurl.com/api/Tarea/Ofertas")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var lista: [Oferta] = []
        let session = URLSession.shared
        session.dataTask(with: request){(data, response, error) in
            do{
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]]{
                    json.forEach({ elment in
                        let imagen = elment["sitiosTuristicos"]?["imagen"]as! String
                        let imageAux = imagen.components(separatedBy: "/")
                        let sitio = SitiosTuristicos(titulo: elment["sitiosTuristicos"]?["titulo"] as! String, descripcion: elment["sitiosTuristicos"]?["descripcion"] as! String, id: elment["sitiosTuristicos"]?["id"] as! Int,precio: elment["sitiosTuristicos"]?["precio"] as! Int, imagen: (imageAux.last)!)
                        lista.append(Oferta(idOferta: elment["id"] as! Int, precioOferta: elment["precio"] as! Int ,sitio: sitio))
                        
                    })
                }
                
            }
            DispatchQueue.main.sync {
                self.titulolbl.text = lista[index].getSitio().getTitulo()
                self.descripcionText.text = lista[index].getSitio().getDescripcion()
                self.precioText.text = String(lista[index].getPrecioOferta())+"%"
                self.imagenView.image = UIImage(named: lista[index].getSitio().getImagen())
                self.count2 = lista.count
                
            }
        }.resume()
    }
    
    @IBAction func next(_ sender: Any) {
        count += 1

        if(count < count2){
            getOfertas(index: count)
        }else{
            getOfertas(index: 0)
            count = 0
        }
        
    }
    
    
    @IBAction func back(_ sender: Any) {

        if(count == 0){
            count = count2-1
            getOfertas(index: count)
        }else if(count2 > count){
            count -= 1
            getOfertas(index: count)
        }
        
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        menu.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: options[row].segue, sender: self)

    }
    

}
