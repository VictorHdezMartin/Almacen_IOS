//
//  ArticuloViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 21/1/25.
//

import UIKit
import FirebaseAuth

class ArticuloViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var ResenasTableView: UITableView!
    @IBOutlet weak var ImgCollectionView: UICollectionView!
    @IBOutlet weak var GaleriaTableView: UITableView!
    
    @IBOutlet weak var lbl_Articulo: UILabel!
    @IBOutlet weak var lbl_NombreArticulo: UILabel!
    
    @IBOutlet weak var SegmenControl: UISegmentedControl!
    @IBOutlet weak var CaracteristicasView: UIView!
    @IBOutlet weak var ResenasView: UIView!
    @IBOutlet weak var GaleriaView: UIView!
    
 // Imagen del artículo
    @IBOutlet weak var imgArticulo: UIImageView!
    
 // Características
    @IBOutlet weak var lbl_Categoria: UILabel!
    @IBOutlet weak var lbl_Marca: UILabel!
    @IBOutlet weak var lbl_Description: UITextView!
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
    @IBOutlet weak var NavigacionView: UIView!
    @IBOutlet weak var btn_Anterior: UIButton!
    @IBOutlet weak var btn_Siguiente: UIButton!
    
//  -----------------------------------------------------
    
    var idArticulo: Int!
    var articulo: ArticuloClass!
    
    var resenasList: [Review] = []      // reseñas en modo vertical
    var galeriaList: [String] = []      // galeria imagenes en modo vertical
    //var galeriaHList: [String] = []     // galeria imagenes en modo horizontal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ResenasTableView.dataSource = self
        GaleriaTableView.dataSource = self
        
     // Configurar el CollectionView
        ImgCollectionView.delegate = self
        ImgCollectionView.dataSource = self
     
        SegmenControl.selectedSegmentIndex = 0
        TabBarSelect(SegmenControl.selectedSegmentIndex)
        
        LoadArticulo(id: idArticulo)
    }
    
// Selección del TabBar  -----------------------------------------------------------
        
    func TabBarSelect(_ index: Int) {
        
        CaracteristicasView.isHidden = true
        ResenasView.isHidden = true
        GaleriaView.isHidden = true
        NavigacionView.isHidden = true
            
        switch index {
            case 0: CaracteristicasView.isHidden = false
            case 1: ResenasView.isHidden = false
            case 2: GaleriaView.isHidden = false
            default: NavigacionView.isHidden = false
        }
    }

// funciones del TableView  --------------------------------------------------------
                
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView.tag{
            case 0: return resenasList.count
            default: return galeriaList.count
        }
    }
                    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView.tag {
        case 0: let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ResenasViewCell
                let resena = resenasList[indexPath.item]
                cell.render(review: resena)
                return cell
            
        default: let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GaleriaViewCell
                 let galeria = galeriaList[indexPath.item]
                 cell.render(imagen: galeria)
                 return cell
        }
    }
    
// funciones del CollectionView  ------------------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galeriaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GaleriaHViewCell
        let galeriaH = galeriaList[indexPath.item]
        cell.render(imagen: galeriaH)
        return cell
    }
    
// Moverse por las imagenes en el CollectionView  ---------------------------------
    
    @IBAction func ImagenAnterior() {
        let currentIndexPath = ImgCollectionView.indexPathsForVisibleItems.first
        let prevItem = (currentIndexPath?.item ?? 0) - 1
        if prevItem >= 0 {
            let indexPath = IndexPath(item: prevItem, section: 0)
            ImgCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            let indexPath = IndexPath(item: galeriaList.count - 1, section: 0)
            ImgCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func ImagenSiguiente() {
        let currentIndexPath = ImgCollectionView.indexPathsForVisibleItems.first
        let nextItem = (currentIndexPath?.item ?? 0) + 1
        if nextItem < galeriaList.count {
            let indexPath = IndexPath(item: nextItem, section: 0)
            ImgCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            let indexPath = IndexPath(item: 0, section: 0)
            ImgCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
// SegmenControl cambio de selcción ---------------------------------------------
    
    @IBAction func CambioSeleccion(_ sender: Any) {
        TabBarSelect(SegmenControl.selectedSegmentIndex)
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
        lbl_Articulo.text = "Categoría [ \(articulo.category ?? "") ] "
        lbl_NombreArticulo.text = articulo.title ?? ""
        
        lbl_Categoria.text = "  \(articulo.category ?? "")"
        lbl_Marca.text = "  \(articulo.brand ?? "")"
        lbl_Description.text = "  \(articulo.description ?? "")"
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
        ResenasTableView.reloadData()
        
     // Galería ---------
        
        galeriaList = articulo.images!
        GaleriaTableView.reloadData()
        
    // Galeria Horizontal  -----------
        
        ImgCollectionView.reloadData()
        
    }
    
// Salir de la aplicacion (Log out)  ---------------------------------------
    @IBAction func LogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
                  
        self.navigationController?.navigationController?.popToRootViewController(animated: true)
    }
    
}
