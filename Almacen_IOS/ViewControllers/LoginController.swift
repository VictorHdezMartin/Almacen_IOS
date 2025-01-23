//
//  ViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 13/1/25.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import FirebaseFirestore

class LoginViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var correoUsuario: UITextField!
    @IBOutlet weak var claveUsuario: UITextField!
    @IBOutlet weak var nClaveUsuario: UILabel!
    
    @IBOutlet weak var btn_Google: UIButton!
    @IBOutlet weak var btn_Microsoft: UIButton!
    @IBOutlet weak var btn_Apple: UIButton!
    @IBOutlet weak var btn_Facebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        claveUsuario.isSecureTextEntry = true
        nClaveUsuario.text = "\(claveUsuario.text!.count)/6"
    }
    
    @IBAction func cuenta_crear(_ sender: Any) {
        self.performSegue(withIdentifier: "goToCrearCuenta", sender: nil)
    }
    
// He olvidado la contraseña -----------------------------------------------------------------------
    
    @IBAction func RecuperarPassword(_ sender: Any) {
        let username = correoUsuario.text!
           Auth.auth().sendPasswordReset(withEmail: username) { error in
               if (error != nil) {
                   print(error!.localizedDescription)
               }
           }
           let alert = UIAlertController(title: "Recuperar contraseña", message: "Te hemos enviado un correo a \(username) para recuperar tu contraseña.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default))
           self.present(alert, animated: true)
    }
    
// Iniciar sesión [On_TouchUpInside ]
    
    @IBAction func usuario_login(_ sender: Any) {
        Auth.auth().signIn(withEmail: correoUsuario.text!, password: claveUsuario.text!) { [unowned self] authResult, error in
            //guard let strongSelf = self else { return }
            if let error = error {
             // Hubo un error
                let alertController = UIAlertController(title: "Iniciar sesión", message: error.localizedDescription, preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
             // Todo correcto
                if authResult!.user.isEmailVerified {
                    self.performSegue(withIdentifier: "goToNavigate", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "goToVerificarCuenta", sender: self)
                }
            }
        }
    }
    
// número de caracteres de la contraseña [ On_EditingChanged ] --------------------------------
    
    @IBAction func nClaveUsuario(_ sender: Any) {
        if (claveUsuario.text!.count) <= 6 {
            nClaveUsuario.text = "\(claveUsuario.text?.count ?? 0)/6"
        } else {
            nClaveUsuario.text = "\(claveUsuario.text?.count ?? 0)/\(claveUsuario.text?.count ?? 0)"
        }
    }
    
// vemos u ocultamos la contraseña [ On_TouchUpInside) ] --------------------------------------
    
    @IBAction func verClave(_ sender: Any) {
        claveUsuario.isSecureTextEntry = !claveUsuario.isSecureTextEntry
    }
    

// Login: GOOGLE  -----------------------------------------------------------------------------
    
    @IBAction func GoogleLogin(_ sender: Any) {
        cambiarColorBoton(btn_Google)
        GoogleSignIn()
    }
        
    func GoogleSignIn() {
    
        // Configure Google SignIn with Firebase
           guard let clientID = FirebaseApp.app()?.options.clientID else { return }
           let config = GIDConfiguration(clientID: clientID)
           GIDSignIn.sharedInstance.configuration = config
                  
        // Start the sign in flow!
           GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
               guard error == nil else {
                   return
               }

               guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                   return
               }

               let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

               Auth.auth().signIn(with: credential) { result, error in
                   guard error == nil else {
                       return
                   }

                   Task {
                       await self.createUser(googleUser: user)
                                       
                       DispatchQueue.main.async {
                   // SessionManager.setSession(forUser: user.profile!.email, andPassword: "", withProvider: LoginProvider.google)
                                           
                           self.performSegue(withIdentifier: "goToNavigate", sender: nil)
                       }
                   }
               }
           }
    }
    
    func createUser(googleUser: GIDGoogleUser) async {
        
            let userID = Auth.auth().currentUser!.uid
            let db = Firestore.firestore()
            let docRef = db.collection("Usuarios").document(userID)
            
            do {
                let document = try await docRef.getDocument()
                if !document.exists {
                    let username = googleUser.profile!.email
                    let firstName = googleUser.profile!.givenName ?? googleUser.profile!.name
                    let lastName = googleUser.profile!.familyName ?? ""
                    //let birthday = nil
                    let gender = Gender.unspecified
                    let profileImageUrl = googleUser.profile!.hasImage ? googleUser.profile!.imageURL(withDimension: 200) : nil
                    
                    let user = User(id: userID, username: username, firstName: firstName, lastName: lastName, gender: gender, birthday: nil, provider: .google, profileImageUrl: profileImageUrl?.absoluteString)
                    
                    do {
                        try db.collection("Usuarios").document(userID).setData(from: user)
                    } catch let error {
                        print("Error escribiendo en FireStore: \(error)")
                    }
                }
            } catch {
                print("Error: No se puede recuperar perfil del usuario\(error)")
            }
        }
    
    
    
// Login: HOTMAIL  ----------------------------------------------------------------------------
    
    @IBAction func MicrosoftLogin(_ sender: Any) {
        cambiarColorBoton(btn_Microsoft)
        MicrosoftSingIn()
    }
    
    func MicrosoftSingIn() {
  
        
        
    }
    
// Logi: APPLE  ------------------------------------------------------------------------------
    @IBAction func AppleLogin(_ sender: Any) {
        cambiarColorBoton(btn_Apple)
        AppleSignIn()
    }
    
   func AppleSignIn() {
        
       
       
    }
      
// Login: FACEBOOK  -------------------------------------------------------------------------
    
    @IBAction func FacebookLogin(_ sender: Any) {
        cambiarColorBoton(btn_Facebook)
        FacebookSignIn()
    }
    
    func FacebookSignIn() {
            
        
    }
    
// cambiar de color los botones  -----------------------------------------------------------
    
    func cambiarColorBoton(_ nBoton: UIButton){
        
        setButtonBackColor(btn_Apple)
        setButtonBackColor(btn_Google)
        setButtonBackColor(btn_Facebook)
        setButtonBackColor(btn_Microsoft)
        
        switch (nBoton.tag) {
            case 0: setButtonColor(btn_Google)
            case 1: setButtonColor(btn_Microsoft)
            case 2: setButtonColor(btn_Apple)
           default:setButtonColor(btn_Facebook)
        }
    }
    
    func setButtonBackColor(_ nBoton: UIButton){
        nBoton.backgroundColor = UIColor.fondoBoton
    }
    
    func setButtonColor(_ nBoton: UIButton){
        nBoton.backgroundColor = UIColor.setColorBoton
    }
    
}
