//
//  ViewController.swift
//  FavPlayers
//
//  Created by Ece Saygut on 11.08.2023.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerTeamLabel: UILabel!
    @IBOutlet weak var playerImages: UIImageView!
    
    
    // MARK: Properties
    
    var currentIndex = 0
    var playerIds = [237, 140, 228, 322, 115, 15, 57, 192, 53]
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlayerData()
    }
    
    
    // MARK: Networking
    
    func fetchPlayerData() {
        let playerId = playerIds[currentIndex]
        let urlString = "https://www.balldontlie.io/api/v1/players/\(playerId)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let player = try JSONDecoder().decode(Player.self, from: data)
                    DispatchQueue.main.async {
                        self.updateUI(player: player)
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
        
        playerImages.image = UIImage(named: "\(currentIndex + 1)")
    }
    
    
    // MARK: UI Update
    
    func updateUI(player: Player) {
        playerNameLabel.text = "Name: \(player.firstName) \(player.lastName)"
        playerPositionLabel.text = "Position: \(player.position)"
        playerTeamLabel.text = "Team: \(player.team.fullName)"
    }
    
    
    // MARK: IBActions
    
    @IBAction func previousPlayerButton(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            fetchPlayerData()
        } else {
            alertAction(message: "You are in the first player")
        }
    }
    
    @IBAction func nextPlayerButton(_ sender: Any) {
        if currentIndex < playerIds.count - 1 {
            currentIndex += 1
            fetchPlayerData()
        } else {
            alertAction(message: "You are in the last player")
        }
    }
    
    @IBAction func staticsDetailsButton(_ sender: Any) {
        performSegue(withIdentifier: "ToStaticsVC", sender: self)
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToStaticsVC", let staticsVC = segue.destination as? StatisticsVC {
            staticsVC.playerId = playerIds[currentIndex]
        }
    }
    
    
    // MARK: Helper
    
    func alertAction(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}







