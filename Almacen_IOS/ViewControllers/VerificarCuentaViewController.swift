//
//  VerificarCuentaViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 17/1/25.
//

import UIKit

class VerificarCuentaViewController: UIViewController {
    
    
    @IBOutlet weak var msgVerificarCuenta: UITextView!
    
    var usuario_login: String = "Víctor Manuel"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mensaje =
        
        "¡Hola \(usuario_login)! \n\n" +
        "Para completa el registro y activar tu cuenta, por favor verifica tu dirección de correo electrónico haciendo clic en el enlace del correo que te hemos enviado.\n\n" +
        "Si no encuentras el correo en tu bandeja de entrada, revisa la carpeta de 'Spam' o 'Correo no deseado'.\n\n" +
        "Si tienes alguna duda o necesitas ayuda, no dudes en ponerte en contacto con nosotros.\n\n" +
        "Saludos,\n" +
        "El equipo de Gestión de almacén."
        
        msgVerificarCuenta.text = mensaje
    }
    

    
    @IBAction func btnVerificarCuenta(_ sender: Any) {
        
        
    }
    
}
