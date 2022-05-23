//
//  Twitter.swift
//  TwitterSearches
//
//  Created by LABORATORIOS on 23/5/22.
//

import UIKit

class Twitter: NSObject {
    var twiter: String = ""
    var name: String = ""
    
    var lista: [Twitter] = []

    func almacenarTwitter(nuevoTwitter: Twitter) {
        lista.append(nuevoTwitter)
    }
}
