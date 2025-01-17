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
    
 // datos personales
   
    @IBOutlet weak var userPasswordRepetir: UITextField!
    @IBOutlet weak var nClaveUsuarioRepetir: UILabel!
    @IBOutlet weak var userTrato: UISegmentedControl!
    @IBOutlet weak var soloNombre: UITextField!
    @IBOutlet weak var soloApellidos: UITextField!
    @IBOutlet weak var fechaNacimiento: UIDatePicker!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var imagenPerfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mayorEdad = Date() - (18*365*24*60*60) as Date?
        fechaNacimiento.maximumDate = mayorEdad
    }
    
    @IBAction func CreateAccount(_ sender: Any) {
        if (ValidarDatos()) {
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { authResult, error in
                if let error = error {
                    // Hubo un error
                    
                    let alertController = UIAlertController(title: "Crear usuario", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Todo correcto
                    
                    self.CrearCuenta()
                    
                    let alertController = UIAlertController(title: "Crear usuario", message: "Usuario creado correctamente", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                     // volver al primer controlador de vista en la pila de navegación (la raíz)
                        self.navigationController?.popToRootViewController(animated: true)
                        
                    //  ir al controlador de vista actual está dentro de un UINavigationController
                    //  self.navigationController?.popViewController(animated: true)
                    }))
                    
                    
            
                    self.present(alertController, animated: true, completion: nil)
                
                }
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
    
// validar datos introducidos -------------------------------------------------------------------------
    
    func ValidarDatos() -> Bool {
        
        if userEmail.text!.isEmpty { return false }
        if userPassword.text!.isEmpty { return false }
        if userPasswordRepetir.text!.isEmpty { return false }
        if userPassword != userPasswordRepetir { return false }
        if soloNombre.text!.isEmpty { return false}
        if telefono.text!.isEmpty { return false }
        
            
    
        
        
        
        
        
        return true
    }
    
 // Crear cuenta  -------------------------------------------------------------------------------------
    
    func CrearCuenta () {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
}
