//
//  StaticsVC.swift
//  FavPlayers
//
//  Created by Ece Saygut on 11.08.2023.
//

import UIKit

class StatisticsVC: UIViewController {

    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var ptsLabel: UILabel!
    @IBOutlet weak var rebLabel: UILabel!
    @IBOutlet weak var astLabel: UILabel!
    
    var playerId: Int? // Önceki sayfadan gelen oyuncu kimliği
    var selectedSeason: Int = 2022 // Varsayılan sezon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let playerId = playerId {
            fetchPlayerStatistics(playerId: playerId, season: selectedSeason)
        }
    }
    
    @IBAction func seasonsSC(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: selectedSeason = 2020
        case 1: selectedSeason = 2021
        case 2: selectedSeason = 2022
        default: selectedSeason = 2022
        }
        
        if let playerId = playerId {
            fetchPlayerStatistics(playerId: playerId, season: selectedSeason)
        }
    }
    
    func fetchPlayerStatistics(playerId: Int, season: Int) {
        let urlString = "https://www.balldontlie.io/api/v1/season_averages?season=\(season)&player_ids[]=\(playerId)"
        
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(PlayerStatisticsResponse.self, from: data)
                    if let playerStats = response.data.first {
                        let filteredPlayerStats = PlayerStatistics(
                            gamesPlayed: playerStats.gamesPlayed,
                            min: playerStats.min,
                            pts: playerStats.pts,
                            reb: playerStats.reb,
                            ast: playerStats.ast
                        )
                        DispatchQueue.main.async {
                            self.updateUI(with: filteredPlayerStats)
                        }
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
        }.resume()
    }
    
    func updateUI(with statistics: PlayerStatistics) {
        gamesPlayedLabel.text = "Games Played: \(statistics.gamesPlayed)"
        minLabel.text = "Average Minutes: \(statistics.min)"
        ptsLabel.text = "Average Points: \(statistics.pts)"
        rebLabel.text = "Average Rebounds: \(statistics.reb)"
        astLabel.text = "Average Assists: \(statistics.ast)"
    }
}


