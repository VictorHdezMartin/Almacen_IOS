//
//  PerfilUsuarioViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 23/1/25.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import PhotosUI

class PerfilUsuarioViewController: UIViewController, PHPickerViewControllerDelegate {
    
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
    
    var user: User!
    let mayorEdad = Date() - (18*365*24*60*60) as Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fechaNacimiento.maximumDate = mayorEdad
        
     // Uncomment the following line to preserve selection between presentations
     // self.clearsSelectionOnViewWillAppear = false

     // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     // self.navigationItem.rightBarButtonItem = self.editButtonItem
                
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser!.uid
        let docRef = db.collection("Usuarios").document(userID)

        Task {
            do {
                user = try await docRef.getDocument(as: User.self)
                DispatchQueue.main.async {
                    self.loadData()
                }
            } catch {
                print("Error decoding user: \(error)")
            }
        }
    }
    
// Cargamos los datos del usuario desde FireStore  ----------------------------------
    
    func loadData() {
        soloNombre.text = user.firstName
        soloApellidos.text = user.lastName
        userEmail.text = user.username
    
        switch user.gender {
            case .male: userTrato.selectedSegmentIndex = 0
            case .female: userTrato.selectedSegmentIndex = 1
            default: userTrato.selectedSegmentIndex = 2
        }
        
        fechaNacimiento.date = user.birthday ?? mayorEdad!
            
        if let imageUrl = user.profileImageUrl {
            imagenPerfil.loadFrom(url: imageUrl)
        }
        
        if let phoneNumber = user.phone, !phoneNumber.isEmpty {
            telefono.text = phoneNumber
        }
        
    }
    
// Actualizamos el perfil del usuario  --------------------------------------------------
    
    @IBAction func userPerfilUpdate(_ sender: Any) {
        if ValidarDatos(){
            saveUser()
        }
    }
    
    func saveUser() {
        let userID = Auth.auth().currentUser!.uid
        
        user?.firstName = soloNombre.text!
        user?.lastName = soloApellidos.text!
        user?.birthday = fechaNacimiento.date
        user?.gender = switch userTrato.selectedSegmentIndex {
                          case 0: Gender.male
                          case 1: Gender.female
                          default: Gender.other
                        }
        user?.phone = telefono.text!
        
        let db = Firestore.firestore()
        
        do {
            try db.collection("Usuarios").document(userID).setData(from: user)
            
            let alertController = UIAlertController(title: "Actualizar perfil", message: "Perfil actualizado correctamente.", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        } catch let error {
            print("Error escribiendo en FireStore: \(error)")
        }
    }
    
// validar datos introducidos -------------------------------------------------------------------------
        
    func ValidarDatos() -> Bool {
            
        if soloNombre.text!.isEmpty { return false }
        if soloApellidos.text!.isEmpty { return false }
        //if userEmail.text!.isEmpty { return false }
        //if userPasswordRepetir.text!.isEmpty { return false }
        //if userPassword.text != userPasswordRepetir.text { return false }
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
        
// Salir de la aplicacion (Log out)  ----------------------------------------------------
    @IBAction func LogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
              
        self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
        
}
