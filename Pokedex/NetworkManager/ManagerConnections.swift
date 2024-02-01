//
//  ManagerConnections.swift
//  Pokedex
//
//  Created by Joel Villa on 30/01/24.
//

import Foundation


class ManagerConnections {
    
    func fetchPokemon(id: String, _ completion: @escaping (_ success: Bool, _ data: Pokemon?) -> Void) {
        let session = URLSession.shared
        var components = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/" + id)!
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {
                completion(false, nil)
                return
            }
            
            if response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(true, pokemon)
                    print(pokemon.name)
                } catch {
                    completion(false, nil)
                    print("Ha ocurrido un error: \(error.localizedDescription)")
                }
            } else {
                completion(false, nil)
                print("Network request failed")
            }
        }.resume()
    }
}
