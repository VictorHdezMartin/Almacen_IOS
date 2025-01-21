//
//  ArticuloViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 21/1/25.
//

import UIKit

class ArticuloViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var SegmenControl: UISegmentedControl!
    @IBOutlet weak var CaracteristicasView: UIView!
    @IBOutlet weak var ResenasView: UIView!
    @IBOutlet weak var GaleriaView: UIView!
    
 // Imagen del artículo
    @IBOutlet weak var imgArticulo: UIImageView!
    
 // Características
    @IBOutlet weak var lbl_Categoria: UILabel!
    @IBOutlet weak var lbl_Marca: UILabel!
    @IBOutlet weak var lbl_Descripcion: UILabel!
    @IBOutlet weak var lbl_Nombre: UILabel!
    @IBOutlet weak var lbl_Precio: UILabel!
    @IBOutlet weak var lbl_Devoluciones: UILabel!
    @IBOutlet weak var lbl_InfEnvio: UILabel!
    @IBOutlet weak var lbl_SegInventario: UILabel!
    @IBOutlet weak var lbl_Existencias: UILabel!
    @IBOutlet weak var lbl_InfGarantia: UILabel!
    @IBOutlet weak var lbl_Peso: UILabel!
    @IBOutlet weak var lbl_PedidoMinimo: UILabel!
    @IBOutlet weak var lbl_Valoracion: UILabel!
    
// Reseñas
    
    
    
// Galería
    
    
    
    
 
//  -----------------------------------------------------
    
    var idArticulo: Int!
    var articulo: ArticuloClass!
    
    var resenasList: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SegmenControl.selectedSegmentIndex = 0
        TabBarSelect(SegmenControl.selectedSegmentIndex)
        
        LoadArticulo(id: idArticulo)
    }
    
// Selección del TabBar --------------------------------
        
    func TabBarSelect(_ index: Int) {
        CaracteristicasView.isHidden = true
        ResenasView.isHidden = true
        GaleriaView.isHidden = true
            
        switch index {
            case 0: CaracteristicasView.isHidden = false
            case 1: ResenasView.isHidden = false
            default: GaleriaView.isHidden = false
        }
    }

// funciones del TableView  --------------------------------------------------------
                
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resenasList.count
    }
                    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResenasViewCell
        let resena = resenasList[indexPath.item]
        cell.render(resena: resena)
        return cell
    }
    
    
// Load Articulo  ----------------------------------------------------------------
        
    func LoadArticulo(id: Int) {
        Task {
            do {
                articulo = try await ArticuloProvider.findArticulo(id: id)
                DispatchQueue.main.async {
                    self.MostrarDatosArticulo()
                }
            } catch {
                print(error)
            }
        }
    }
    
// Mostramos el artículo seleccionado  -------------------------------------------
    
    func MostrarDatosArticulo() {
        
        imgArticulo.loadFrom(url: articulo.thumbnail)
        
     // Características ------
        lbl_Categoria.text = "  \(articulo.category ?? "")"
        lbl_Marca.text = "  \(articulo.brand ?? "")"
        lbl_Descripcion.text = "  \(articulo.description ?? "")"
        lbl_Nombre.text = "  \(articulo.title ?? "")"
        lbl_Precio.text = "  \(String(format: "%.2f", articulo.price ?? 0.00))"
        lbl_Devoluciones.text = "  \(articulo.returnPolicy ?? "")"
        lbl_InfEnvio.text = "  \(articulo.shippingInformation ?? "")"
        lbl_SegInventario.text = "  \(articulo.availabilityStatus ?? "")"
        lbl_Existencias.text = "  \(String(articulo.stock ?? 0))"
        lbl_InfGarantia.text = "  \(articulo.warrantyInformation ?? "")"
        lbl_Peso.text = "  \(String(format: "%.2f", articulo.weight ?? 0.00))"
        lbl_PedidoMinimo.text = "  \(String(articulo.minimumOrderQuantity ?? 0))"
        lbl_Valoracion.text = "  \(String(format: "%.1f", articulo.rating ?? 0.0))"
        
     // Reseñas  --------
        
        resenasList = articulo.reviews
        
        
        
     // Galería ---------
        
        
    }
    
}
