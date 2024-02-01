//
//  ViewController.swift
//  Pokedex
//
//  Created by Joel Villa on 30/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextPokemonBtn: UIButton!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblButton: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var nameView: UIView!
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameView.layer.cornerRadius = 12
        nameView.layer.borderWidth = 1
        
        descriptionView.layer.cornerRadius = 3
        descriptionView.layer.borderWidth = 1
        
        nextPokemonBtn.layer.cornerRadius = 0.5 * nextPokemonBtn.bounds.size.width
        nextPokemonBtn.clipsToBounds = true
        nextPokemonBtn.layer.borderWidth = 1
        
        
        lblButton.adjustsFontSizeToFitWidth = true
        lblButton.minimumScaleFactor = 0.5
        lblButton.numberOfLines = 0
        
        getRandomPokemon()
        //Espera los 30 segundos para mandar llamar la funcion
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true, block: { [weak self] (timer) in
                    self?.getRandomPokemon()
                })
    }

    @IBAction func ShowPokemon(_ sender: Any) {
        getRandomPokemon()
    }
    
    func getRandomId() -> String {
        let randomIntNum = Int(arc4random_uniform(100)) + 1
        let randomStringNum = String(randomIntNum)
        print(randomStringNum)
        return randomStringNum
    }
    
    func getRandomPokemon() {
        let managerConection = ManagerConnections()
        managerConection.fetchPokemon(id: getRandomId()) { [weak self] success, data in
            if success, let data = data {
                DispatchQueue.main.async {
                    self?.imgPokemon.imageFromServerURL(urlString: data.sprites?.other?.officialArtwork?.frontDefault ?? "", placeHolderImage: UIImage(named: "person"))
                    self?.lblName.text = "Nombre: " + (data.name ?? "")
                    self?.lblId.text = "Id: " + String(data.id ?? 0)
                    self?.lblWeight.text = "Peso: " + String(data.weight ?? 0)
                    self?.lblHeight.text = "Altura: " + String(data.height ?? 0)
                }
            } else {
                DispatchQueue.main.async {
                    self?.imgPokemon.image = UIImage(named: "person")
                    self?.lblName.text = "xxx"
                    self?.lblId.text = "xxx"
                    self?.lblWeight.text = "xxx"
                    self?.lblHeight.text = "xxx"
                }
            }
        }
    }
    
}

extension UIImageView {
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage?) {
        guard let urlString = URL(string: urlString) else { return }
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}
