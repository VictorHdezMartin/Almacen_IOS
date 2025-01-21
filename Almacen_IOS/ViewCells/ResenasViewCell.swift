//
//  ResenasViewCell.swift
//  Almacen_IOS
//
//  Created by Tardes on 21/1/25.
//

import UIKit

class ResenasViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Comentario: UITextView!
    @IBOutlet weak var txt_Email: UITextView!
    @IBOutlet weak var lbl_Fecha: UILabel!
    @IBOutlet weak var lbl_Valoracion: UILabel!
    @IBOutlet weak var lbl_Nombre: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func render (reviews: ArticuloClass.reviews){
        lbl_Comentario.text = 
        
        
        
       
    }

}


/*
 
 
 override func setSelected(_ selected: Bool, animated: Bool) {
     super.setSelected(selected, animated: animated)
 }
 
 func render (categoria: CategoriaClass){
     lblCategoria.text = categoria.nCategoria
     imgCategoria.loadFrom(url: categoria.nImagen)
 }
 
 
 
 */
