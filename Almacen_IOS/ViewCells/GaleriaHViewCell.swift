//
//  GaleriaHViewCell.swift
//  Almacen_IOS
//
//  Created by Tardes on 22/1/25.
//

import UIKit

class GaleriaHViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagen: UIImageView!
    
    func render (imagen: String){
        self.imagen.loadFrom(url: imagen)
    }
    
}
