//
//  Localidad.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 24/6/22.
//

import UIKit
import Foundation
class Localidad: NSObject {
    private var id: Int
    private var provincia: String
    
     init(provincia: String) {
        self.provincia = provincia

    }
    
    func getId()-> Int{
        return self.id
    }
    func getProvincia()-> String{
        return self.provincia
    }
    
}
