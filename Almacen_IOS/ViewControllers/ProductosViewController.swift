//
//  ProductosViewController.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import UIKit
import FirebaseAuth

class ProductosViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var ProductosTableView: UITableView!
    @IBOutlet weak var lblProductos: UILabel!
    
    var productoList: [ProductosClass] = []
    var categoria: CategoriaClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProductosTableView.dataSource = self
        
     // vemos la barra de búsqueda  -----------------------------------------------
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
            
        lblProductos.text = "Categoría [ \(categoria.nCategoria) ]"
        loadAllProductos(categoria: categoria.nCategoria)
    }
    
// funciones del TableView  ----------------------
            
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return productoList.count
        }
                
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ProductosViewCell
                let producto = productoList[indexPath.item]
                cell.render(producto: producto)
                return cell
            }
        
    // Barra de búsqueda: OnChange  ------------------------------------------------------------------------
                
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
         //   if let query = searchBar.text {
         //       findProductoBy(name: query)
         //   } else {
         //       loadAllProductos(name: query)
         //   }
        }

// Load Productos  ----------------------------------------------------------------
    
    func loadAllProductos(categoria: String) {
        Task {
            do {
                productoList = try await ProductosProvider.findAllProductos(categoria: categoria)
                DispatchQueue.main.async {
                    self.ProductosTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
// movernos a otro ViewController pasando parámetros -----------------------------------------
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToArticulo") {
            let articuloViewController = segue.destination as! ArticuloViewController
            let indexPath = ProductosTableView.indexPathForSelectedRow!
            let productoClass = productoList[indexPath.row]
                
            articuloViewController.idArticulo = productoClass.id
            ProductosTableView.deselectRow(at: indexPath, animated: true)
        }
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
