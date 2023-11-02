//
//  Movie.swift
//  TableView
//
//  Created by Miguel Hernandez on 10/20/23.
//

import Foundation

struct Movie {
    let name: String
    let actor: String
    let type: String
    let imageURL: String
}

extension Movie {
    static let movies: [Movie] = [
        Movie(name: "Green Book", actor: "Viggo Mortensen", type: "Adventure", imageURL: "green_book_portada"),
        Movie(name: "Toy Story", actor: "Woody", type: "Animation", imageURL: "toy_story_portada"),
        Movie(name: "Dracula", actor: "Ricardo Ferreti", type: "Miedo", imageURL: "dracula_portada")
    ]
}
