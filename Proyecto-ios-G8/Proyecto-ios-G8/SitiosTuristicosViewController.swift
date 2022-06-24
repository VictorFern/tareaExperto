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
    var count2 = 0
    var sitios: [SitiosTuristicos] = []
    var indexAux = 0
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
   
    @IBOutlet weak var provinciaText: UITextField!
    var select: String?
    var lista = ["San Jose","Alajuela","Cartago","Heredia","Guanacaste","Puntarenas","Limon"]
    
    @IBOutlet var idlabel: UILabel!
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
        self.createPicker()
        self.dismissAndClosePicker()
        getSitios(index:0)

    }
    
    @IBAction func getSitiosL(_ sender: Any){
        
        let vc = storyboard?.instantiateViewController(identifier: "localidad_vc") as! LocalidadViewController
        vc.modalPresentationStyle = .fullScreen
        let localidad = self.provinciaText.text
        print(localidad!)
        vc.localidad = localidad!
        
        present(vc, animated: true)
        
    }
    
    func dismissAndClosePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAction))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        self.provinciaText.inputAccessoryView = toolBar
    }
    
    @objc func dismissAction(){
        self.view.endEditing(true)
    }
    
    func createPicker(){
        let pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        self.provinciaText.inputView = pickerview
    }

    func getSitios(index: Int){
        let url = URL(string: "http://apiexpertos-001-site1.itempurl.com/api/Tarea/Lista")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var lista: [SitiosTuristicos] = []
        let session = URLSession.shared
        session.dataTask(with: request){(data, response, error) in
            do{
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]]{
                    json.forEach({ elment in
                        let imagen = elment["imagen"]?.components(separatedBy: "/")
                        lista.append(SitiosTuristicos(titulo: elment["titulo"] as! String, descripcion: elment["descripcion"] as! String, id: elment["id"] as! Int,precio: elment["precio"] as! Int, imagen: (imagen?.last)!))
                        
                    })
                }
                
            }
            DispatchQueue.main.sync {
                self.idlabel.text = String(lista[index].getId())
                self.titulolbl.text = lista[index].getTitulo()
                self.precioText.text = String(lista[index].getPreio())+"₡"
                self.imagenView.image = UIImage(named: lista[index].getImagen())
                self.count2 = lista.count
                
            }
        }.resume()
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

        if(count < count2){
            getSitios(index: count)
        }else{
            getSitios(index: 0)
            count = 0
        }
        
    }
    
    
    @IBAction func back(_ sender: Any) {

        if(count == 0){
            count = count2-1
            getSitios(index: count)
        }else if(count2 > count){
            count -= 1
            getSitios(index: count)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        menu.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: options[row].segue, sender: self)

    }
    
    @IBAction func verRuta(_ sender: Any){
        let url = URL(string: "http://apiexpertos-001-site1.itempurl.com/api/Tarea/Ruta?id="+self.idlabel.text!)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var lista: [SitiosTuristicos] = []
        let session = URLSession.shared
        session.dataTask(with: request){(data, response, error) in
            do{
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]]{
                    json.forEach({ elment in
                        let imagen = elment["imagen"]?.components(separatedBy: "/")
                        lista.append(SitiosTuristicos(titulo: elment["titulo"] as! String, descripcion: elment["descripcion"] as! String, id: elment["id"] as! Int,precio: elment["precio"] as! Int, imagen: (imagen?.last)!))
                        
                    })
                }
            }
            DispatchQueue.main.sync {
                let subtitulo = "\n Sobre la ruta\n\n" as NSString
                let descripcion = lista[self.indexAux].getDescripcion() + "\n\n" as NSString
                let msg = (subtitulo as String) + (descripcion as String)
                let alert = UIAlertController(title: "Ruta", message: msg, preferredStyle: .alert)
                let imageView = UIImageView(frame: CGRect(x: 10, y: 450, width: 250, height: 230))
                imageView.image = UIImage(named: lista[self.indexAux].getImagen())
                let height = NSLayoutConstraint(item: alert.view!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 880)
                let width = NSLayoutConstraint(item: alert.view!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 250)
                alert.view.addConstraint(height)
                alert.view.addConstraint(width)
                alert.view.addSubview(imageView)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }.resume()
        
    }

}

extension SitiosTuristicosViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.lista.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return self.lista[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)  {
        self.select = self.lista[row]
        self.provinciaText.text = self.select
    }
}
