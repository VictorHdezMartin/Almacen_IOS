//
//  PerfilUsuarioViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 23/1/25.
//

import UIKit

class PerfilUsuarioViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
