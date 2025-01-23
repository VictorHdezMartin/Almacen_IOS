//
//  VerificarCuentaViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 17/1/25.
//

import UIKit
import FirebaseAuth

class VerificarCuentaViewController: UIViewController {
    
    @IBOutlet weak var msgVerificarCuenta: UITextView!
    
    var usuario_login: String = "Víctor Manuel"
    var timer: Timer? = nil
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sendEmailButton(nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    func emailVerified () {
        let alert = UIAlertController(title: "Verificar cuenta", message: "Cuenta verificada correctamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Volver al Login", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    
// botón de renviar email  ---------------------------------------------------------
    
    @IBAction func sendEmailButton(_ sender: Any?) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        user.sendEmailVerification()
        
        if timer != nil {
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            user.reload()
            if (user.isEmailVerified) {
                timer.invalidate()
                self.emailVerified()
            }
        }
    }
    
}
