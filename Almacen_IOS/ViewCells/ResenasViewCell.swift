//
//  ResenasViewCell.swift
//  Almacen_IOS
//
//  Created by Tardes on 21/1/25.
//

import UIKit

class ResenasViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_Comentario: UITextView!
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
    
    func render (review: Review){
        lbl_Comentario.text = review.comment
        lbl_Email.text = review.reviewerEmail
        lbl_Fecha.text = review.date
        lbl_Valoracion.text = String(format: "%.1f", review.rating)
        lbl_Nombre.text = review.reviewerName
    }

}

