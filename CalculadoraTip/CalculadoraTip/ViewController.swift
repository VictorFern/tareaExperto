//
//  ViewController.swift
//  CalculadoraTip
//
//  Created by LABORATORIOS on 11/5/22.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var per: UILabel!
    @IBOutlet weak var per2: UILabel!
    @IBOutlet weak var billamount: UITextField!
    @IBOutlet weak var tipMin: UITextField!
    @IBOutlet weak var tipMax: UITextField!
    @IBOutlet weak var totalMin: UITextField!
    @IBOutlet weak var totalMax: UITextField!
    
    @IBOutlet weak var sliderTip: UISlider!
    
    @IBAction func slider(_ sender: UISlider) {
        per.text = String(Int(sender.value))+"%"
        per2.text = String(Int(sender.value))+"%"
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let mintip:Double = (Double(Double(billamount.text!)!*0.15))
        let slidervalue:Double = Double(sender.value)
        let maxtip:Double = (Double(Double(billamount.text!)! * (slidervalue/100)))
        let maxtipround = round(maxtip * multiplier) / multiplier
        let mintipround = round(mintip * multiplier) / multiplier
        let totalMinval = mintipround + Double(billamount.text!)!
        let totalMaxval = maxtipround + Double(billamount.text!)!
        let mintotaltipround = round(totalMinval * multiplier) / multiplier
        let maxtotaltipround = round(totalMaxval * multiplier) / multiplier
        
        
        
        tipMin.text = String(mintipround)+"$"
        tipMax.text = String(maxtipround)+"$"
        totalMin.text = String(mintotaltipround)+"$"
        totalMax.text = String(maxtotaltipround)+"$"
    }



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

