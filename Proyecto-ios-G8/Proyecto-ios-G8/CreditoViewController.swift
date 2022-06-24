//
//  CreditoViewController.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 17/6/22.
//

import UIKit

class CreditoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var provinciaText: UITextField!
    var select: String?
    var lista = ["San Jose","Alajuela","Cartago","Heredia","Guanacaste","Puntarenas","Limon"]
    @IBOutlet var imageOne: UIImageView!
    
    @IBOutlet weak var imageTwo: UIImageView!
    
    @IBOutlet weak var imagethree: UIImageView!
    
    
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
        imageOne.layer.masksToBounds = false
        imageOne.layer.cornerRadius = imageOne.frame.height/2
        imageOne.clipsToBounds = true
        
        imageTwo.layer.masksToBounds = false
        imageTwo.layer.cornerRadius = imageOne.frame.height/2
        imageTwo.clipsToBounds = true
        
        imagethree.layer.masksToBounds = false
        imagethree.layer.cornerRadius = imageOne.frame.height/2
        imagethree.clipsToBounds = true
        
        menu.delegate = self
        menu.dataSource = self
        menu.backgroundColor = .clear
        home = containerView.transform
        menuHide.isEnabled = false
        menuHide.title = ""
        menuHide.image = UIImage(systemName: "")
        self.createPicker()
        self.dismissAndClosePicker()
        // Do any additional setup after loading the view.
    }
    @IBAction func getSitios(_ sender: Any){
        
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

extension CreditoViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
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
