//
//  ViewController.swift
//  TableView
//
//  Created by Miguel Hernandez on 10/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var movies: [Movie] = Movie.movies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movies"
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    // indexPath.section te va ir indicando la posición de los sections
    // indexPath.row te va ir indicando la posición de los rows
    
    // Métodos obligatorios para que funcione un Tableview
    // Método para mostrar el numero de elementos en una sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Método que va a instanciar la celda con el identificador agregado
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowForSectionACell") as! RowForSectionACell
        cell.configureCell(with: movies[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // Método para detectar los clicks en la celda.
    // Usamos el indexPath.row para detectar la posición del elemento seleccionado y acceder al array a través de el.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Movie selected: \(movies[indexPath.row])")
    }
}
