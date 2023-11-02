//
//  Movie.swift
//  CollectionViews
//
//  Created by Beto Salcido on 01/11/23.
//

import Foundation

struct Movie {
    let name: String
    let actor: String
    let type: String
    let imageURL: String
}

extension Movie {
    // indexPath.section = 0
    static let moviesWithA: [Movie] = [
        Movie(name: "Anatomy", actor: "Viggo Mortensen", type: "Adventure", imageURL: "green_book_portada"), // indexPath.row = 0
        Movie(name: "Action", actor: "Woody", type: "Animation", imageURL: "toy_story_portada"), // indexPath.row = 1
        Movie(name: "Alexander", actor: "Ricardo Ferreti", type: "Miedo", imageURL: "dracula_portada") // indexPath.row = 2
    ]
    
    // indexPath.section = 1
    static let moviesWithB: [Movie] = [
        Movie(name: "Booking", actor: "Viggo Mortensen", type: "Adventure", imageURL: "green_book_portada"), // indexPath.row = 0
        Movie(name: "Billy hook", actor: "Woody", type: "Animation", imageURL: "toy_story_portada"), // indexPath.row = 1
        Movie(name: "Belinda", actor: "Ricardo Ferreti", type: "Miedo", imageURL: "dracula_portada") // indexPath.row = 2
    ]
    
    // indexPath.section = 2
    static let moviesWithC: [Movie] = [
        Movie(name: "Calefación", actor: "Viggo Mortensen", type: "Adventure", imageURL: "green_book_portada"), // indexPath.row = 0
        Movie(name: "Center", actor: "Woody", type: "Animation", imageURL: "toy_story_portada"), // indexPath.row = 1
        Movie(name: "Cars", actor: "Ricardo Ferreti", type: "Miedo", imageURL: "dracula_portada") // indexPath.row = 2
    ]
    
    // indexPath.section = 3
    static let moviesWithD: [Movie] = [
        Movie(name: "Diddi", actor: "Viggo Mortensen", type: "Adventure", imageURL: "green_book_portada"), // indexPath.row = 0
        Movie(name: "Dexter", actor: "Woody", type: "Animation", imageURL: "toy_story_portada"), // indexPath.row = 1
        Movie(name: "Dumbest", actor: "Ricardo Ferreti", type: "Miedo", imageURL: "dracula_portada") // indexPath.row = 2
    ]
}
