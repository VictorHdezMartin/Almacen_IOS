//
//  CatalogoTableViewCell.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import UIKit

class CatalogoViewCell: UITableViewCell {
    
    @IBOutlet weak var imgCategoria: UIImageView!
    @IBOutlet weak var lblCategoria: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func render (categoria: CategoriaClass){
        lblCategoria.text = categoria.nCategoria
        imgCategoria.loadFrom(url: categoria.nImagen)
    }
}
