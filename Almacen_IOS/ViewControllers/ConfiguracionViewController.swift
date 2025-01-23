//
//  ConfiguracionViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 23/1/25.
//

import UIKit
import FirebaseAuth

class ConfiguracionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

// Salir de la aplicacion (Log out)  -------------------------------------------
    @IBAction func LogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
                  
        self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }

}
