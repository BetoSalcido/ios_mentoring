//
//  ViewController.swift
//  CollectionViews
//
//  Created by Beto Salcido on 01/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var collectionViewB: UICollectionView!
    @IBOutlet private var collectionViewC: UICollectionView!
    
    // Contenido a mostrar en el collectionView
    private let movies: [Movie] = {
        var movies = [Movie]()
        movies.append(contentsOf: Movie.moviesWithA)
        movies.append(contentsOf: Movie.moviesWithB)
        movies.append(contentsOf: Movie.moviesWithC)
        movies.append(contentsOf: Movie.moviesWithD)
        return movies
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

// MARK: - Private Methods
private extension ViewController {
    
    func configureView() {
        self.title = "Movies"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        
        collectionViewC.dataSource = self
        collectionViewC.delegate = self
        // Una vez obtenido el contenido a mostrar en el collectionView.
        // Tenemos que decirle al collectionView que el contenido esta listo para mostrarse.
        collectionView.reloadData()
        collectionViewB.reloadData()
        collectionViewC.reloadData()
        
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    // Métodos obligatorios para que funcione un CollectionView
    // Método para mostrar el numero de elementos en una sección
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Método que va a instanciar la celda con el identificador agregado
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.configureCell(with: movies[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    // Método para configurar el tamaño de las celdas en el collectionView.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfItems: CGFloat = 2
        let widthPerItem = collectionView.frame.width / numberOfItems - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem, height: 210)
    }
}
