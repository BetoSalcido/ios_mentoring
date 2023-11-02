//
//  ViewController.swift
//  TableView
//
//  Created by Miguel Hernandez on 10/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    /// A type to represent a section of cell in the tableView
    private class Section {
        let title: String
        let movies: [Movie]
        
        init(title: String, movies: [Movie]) {
            self.title = title
            self.movies = movies
        }
    }
    
    private var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Movies"
        tableView.dataSource = self
        tableView.delegate = self
        
        generateMovies()
    }
}

// MARK: - Private Methods
private extension ViewController {
    
    func generateMovies() {
        sections.append(Section(title: "A", movies: Movie.moviesWithA))
        sections.append(Section(title: "B", movies: Movie.moviesWithB))
        sections.append(Section(title: "C", movies: Movie.moviesWithC))
        sections.append(Section(title: "D", movies: Movie.moviesWithD))
        
        // Una vez obtenido el contenido a mostrar en el tableView.
        // Tenemos que decirle al tableView que el contenido esta listo para mostrarse.
        tableView.reloadData() // Método para recargar la información del tableView.
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    // indexPath.section te va ir indicando la posición de los sections
    // indexPath.row te va ir indicando la posición de los rows
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count // Regresará el número de secciones disponibles.
    }
    
    // Métodos obligatorios para que funcione un Tableview
    // Método para mostrar el numero de elementos en una sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionIndex = section
        return sections[sectionIndex].movies.count // Regresará el número de row disponibles en cada sección.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Método que va a instanciar la celda con el identificador agregado
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowForSectionACell") as! RowForSectionACell
        
        // let movie = sections[0].movies[0]
        // let movie = sections[0].movies[1]
        let movie = sections[indexPath.section].movies[indexPath.row]
        cell.configureCell(with: movie)
        return cell
    }
    
    // Método para regresar el nombre de la sección.
    // 1er paso para mostrar la sección con el titulo
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionIndex = section
        return sections[sectionIndex].title
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    // Método para detectar los clicks en la celda.
    // Usamos el indexPath.row para detectar la posición del elemento seleccionado y acceder al array a través de el.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSelected = sections[indexPath.section].movies[indexPath.row]
        
        /// Forma de instanciar un viewController y convertirlo al tipo de viewController deseado. En este caso `MovieDetailViewController`.
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        viewController.movie = movieSelected
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Método para poner el height deseado a las celdas
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // Método para asignar el tamaño de la sección del titulo.
    // 2do paso para mostrar la sección con el titulo
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    // Método para cambiar el tema (background, font, etc) de la sección.
    // Note: Este Método es opcional. Solo se usa si se quiere hacer el custom de la sección.
    // 3er paso para mostrar la sección con el titulo.
    // Descomentar para ver la customización del section.
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.contentView.backgroundColor = .green
//            headerView.textLabel?.textColor = .white
//        }
//    }
}
