//
//  GaleriaViewCell.swift
//  Almacen_IOS
//
//  Created by Tardes on 22/1/25.
//

import UIKit

class GaleriaViewCell: UITableViewCell {
    
    @IBOutlet weak var imgArticulo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func render (imagen: String){
        imgArticulo.loadFrom(url: imagen)
    }

}
