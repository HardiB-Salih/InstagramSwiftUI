//
//  Superhero.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct Superhero: Identifiable {
    let id = UUID()
    let username: String
    let fullname: String
    let imagename: String
}

let superheroArray = [
    Superhero(username: "batman", fullname: "Bruce Wayne", imagename: "batman"),
    Superhero(username: "war-machine", fullname: "James Rhodes", imagename: "war-machine"),
    Superhero(username: "red-hood", fullname: "Jason Todd", imagename: "red-hood"),
    Superhero(username: "nightwing", fullname: "Dick Grayson", imagename: "nightwing"),
    Superhero(username: "batgirl", fullname: "Barbara Gordon", imagename: "batgirl"),
    Superhero(username: "captain-america", fullname: "Steve Rogers", imagename: "captain-america"),
    Superhero(username: "hawkeye", fullname: "Clint Barton", imagename: "hawkeye"),
    Superhero(username: "black-panther", fullname: "T'Challa", imagename: "black-panther"),
    Superhero(username: "ant-man", fullname: "Scott Lang", imagename: "ant-man"),
    Superhero(username: "spider-man", fullname: "Peter Parker", imagename: "spider-man"),
    Superhero(username: "iron-man", fullname: "Tony Stark", imagename: "iron-man"),
    Superhero(username: "wolverine", fullname: "Logan", imagename: "wolverine"),
    Superhero(username: "captain-marvel", fullname: "Carol Danvers", imagename: "captain-marvel"),
    Superhero(username: "scarlet-witch", fullname: "Wanda Maximoff", imagename: "scarlet-witch"),
    Superhero(username: "loki", fullname: "Loki Laufeyson", imagename: "loki"),
    Superhero(username: "superman", fullname: "Clark Kent", imagename: "superman"),
    Superhero(username: "winter-soldier", fullname: "Bucky Barnes", imagename: "winter-soldier"),
    Superhero(username: "thor", fullname: "Thor Odinson", imagename: "thor"),
    Superhero(username: "doctor-strange", fullname: "Stephen Strange", imagename: "doctor-strange"),
    Superhero(username: "black-widow", fullname: "Natasha Romanoff", imagename: "black-widow"),
    Superhero(username: "wonder-woman", fullname: "Diana Prince", imagename: "wonder-woman"),
    Superhero(username: "hulk", fullname: "Bruce Banner", imagename: "hulk"),
    Superhero(username: "gamora", fullname: "Gamora", imagename: "gamora"),
    Superhero(username: "flash-person", fullname: "Barry Allen", imagename: "flash-person"),
    Superhero(username: "supergirl", fullname: "Kara Zor-El", imagename: "supergirl")
]
