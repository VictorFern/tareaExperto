//
//  Oferta.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 17/6/22.
//

import UIKit
import Foundation
class Oferta: NSObject {

    private var idOferta: Int
    private var precioOferta: Int
    private var sitio: SitiosTuristicos
    
    
    init(idOferta: Int, precioOferta: Int, sitio: SitiosTuristicos) {
        self.idOferta = idOferta
        self.precioOferta = precioOferta
        self.sitio = sitio
    }
    
    func getIdOferta()-> Int{
        return self.idOferta
    }
    func getPrecioOferta()-> Int{
        return self.precioOferta
    }
    func getSitio()-> SitiosTuristicos{
        return self.sitio
    }
}
