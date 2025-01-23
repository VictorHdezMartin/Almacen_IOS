//
//  MainViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 15/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PhotosUI

class CreateCountViewController: UIViewController, PHPickerViewControllerDelegate {
    
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
    
// Crear usuario  --------------------------------------------------------------------------
    
    @IBAction func CreateAccount(_ sender: Any) {
        
        let username = userEmail.text!
        let password = userPassword.text!
        
        if (ValidarDatos()) {
            Auth.auth().createUser(withEmail: userEmail.text!, password: userPassword.text!) { authResult, error in
                if let error = error {
                    // Hubo un error
                    let alertController = UIAlertController(title: "Crear usuario", message: error.localizedDescription, preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                 // Todo correcto
                    self.crearCuenta()
                }
            }
        }
    }
    
    func crearCuenta() {
        let userID = Auth.auth().currentUser!.uid
        let username = userEmail.text!
        //let password = userPassword.text!
        let firstName = soloNombre.text!
        let lastName = soloApellidos.text!
        let birthday = fechaNacimiento.date
        let gender = switch userTrato.selectedSegmentIndex {
                        case 0: Gender.male
                        case 1: Gender.female
                        default: Gender.other
                     }
        
        let user = User(id: userID, username: username, firstName: firstName, lastName: lastName, gender: gender, birthday: birthday, provider: .basic, profileImageUrl: nil)
        
        let db = Firestore.firestore()
        do {
            try db.collection("Usuarios").document(userID).setData(from: user)
            
            let alertController = UIAlertController(title: "Crear cuenta", message: "Cuenta creada correctamente.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.performSegue(withIdentifier: "goToVerificarCuenta", sender: self)
            }))
            
            self.present(alertController, animated: true, completion: nil)
        } catch let error {
            print("Error escribiendo en FireStore: \(error)")
        }
    }
    
// Acciones sobre la contraseña
    
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
        
        if soloNombre.text!.isEmpty { return false }
        if soloApellidos.text!.isEmpty { return false }
        if userEmail.text!.isEmpty { return false }
        if userPasswordRepetir.text!.isEmpty { return false }
        if userPassword.text != userPasswordRepetir.text { return false }
        if telefono.text!.isEmpty { return false }

        return true
    }

// cargar imagen de perfil  -----------------------------------------------------------
    
    @IBAction func LoadImagenPerfil(_ sender: Any) {
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedItem = results.first else { return }
        
     // Obtener el asset de la imagen seleccionada
        selectedItem.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
            if let image = object as? UIImage {
             // Aquí tienes la imagen cargada
                DispatchQueue.main.async {
                 // Usar la imagen en el UIImageView o hacer lo que necesites
                    self.imagenPerfil.image = image
                }
            } else {
                print("Error: No se puede obtener ni cargar la imagen")
            }
        }
    }
}

    

