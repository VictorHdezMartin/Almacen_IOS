//
//  MainViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 15/1/25.
//

import UIKit
import FirebaseAuth

class CreateCountViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var nClaveUsuario: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { authResult, error in
            if let error = error {
                // Hubo un error
                
                let alertController = UIAlertController(title: "Crear usuario", message: error.localizedDescription, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                // Todo correcto
                
                let alertController = UIAlertController(title: "Crear usuario", message: "Usuario creado correctamente", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    // volver al primer controlador de vista en la pila de navegación (la raíz)
                       self.navigationController?.popToRootViewController(animated: true) // volvemos a la vista raíz
                    
                    //  ir al controlador de vista actual está dentro de un UINavigationController
                    //  self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    @IBAction func nClaveUsuario(_ sender: Any) {
        if (userPassword.text!.count) <= 6 {
            nClaveUsuario.text = "\(userPassword.text?.count ?? 0)/6"
        } else {
            nClaveUsuario.text = "\(userPassword.text?.count ?? 0)/\(userPassword.text?.count ?? 0)"
        }
    }
    
    @IBAction func SeePassword(_ sender: Any) {
        userPassword.isSecureTextEntry = !userPassword.isSecureTextEntry
    }
}
