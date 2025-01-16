//
//  CatalogoViewControler.swift
//  Almacen_IOS
//
//  Created by Tardes on 16/1/25.
//

import UIKit

class CatalogoViewControler: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var CategoriasTableView: UITableView!
    
    var categoriasList: [CategoriaClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CategoriasTableView.dataSource = self
        
    // vemos la barra de búsqueda  -----------------------------------------------
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
        loadAllCategorias()
    }
    
// funciones del TableView  ----------------------
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriasList.count
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CatalogoViewCell
            let categoria = categoriasList[indexPath.item]
            cell.render(categoria: categoria)
            return cell
        }
    
// movernos a otro ViewController pasando parámetros --------------------------------------------------
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToProductos") {
            let productosViewController = segue.destination as! ProductosViewController
            let indexPath = CategoriasTableView.indexPathForSelectedRow!
            let CategoriaClass = categoriasList[indexPath.row]
            
            productosViewController.categoria = CategoriaClass
            CategoriasTableView.deselectRow(at: indexPath, animated: true)
        }
    }

// Barra de búsqueda: OnChange  ------------------------------------------------------------------------
            
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let query = searchBar.text {
            findCategoriasBy(name: query)
        } else {
            findCategoriasBy(name: "a")
        }
    }
    
// Búsqueda de Categoría por nombre ---------------------------------------------------------------
            
    func findCategoriasBy(name: String) {
        Task {
            do {
                categoriasList = try await CategoriasProvider.findCategoriasBy(name: name)
                DispatchQueue.main.async {
                    self.CategoriasTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
        
// Load Categorias  ----------------------------------------------------------------
    
    func loadAllCategorias() {
        Task {
            do {
                let result = try await CategoriasProvider.findAllCategorias()
                for (index, item) in result.enumerated() {
                    let categoryClass = CategoriaClass(nCategoria: item, nImagen: CategoriasDiccionario[item]!)
                    categoriasList.append(categoryClass)
                }
                DispatchQueue.main.async {
                    self.CategoriasTableView.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
}
