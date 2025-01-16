//
//  ProductosViewCell.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import UIKit

class ProductosViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProducto: UILabel!
    @IBOutlet weak var imgProducto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func render (producto: ProductoClass){
        lblProducto.text = producto.title
        imgProducto.loadFrom(url: producto.thumbnail)
    }

}

