//
//  SitiosTuristicos.swift
//  Proyecto-ios-G8
//
//  Created by LABORATORIOS on 13/6/22.
//

import UIKit
import Foundation

class SitiosTuristicos: NSObject {
    private var titulo: String
    private var descripcion: String
    private var id: Int
    private var precio: Int
    private var imagen: String
    
    init(titulo: String, descripcion: String , id: Int, precio: Int, imagen: String) {
        self.titulo = titulo
        self.descripcion = descripcion
        self.id = id
        self.precio = precio
        self.imagen = imagen
    }
    
    func getTitulo()-> String{
        return self.titulo
    }
    
    func getDescripcion()-> String{
        return self.descripcion
    }
    
    func getId()-> Int{
        return self.id
    }
    
    func getPreio()-> Int{
        return self.precio
    }
    
    func getImagen()-> String{
        return self.imagen
    }
}
