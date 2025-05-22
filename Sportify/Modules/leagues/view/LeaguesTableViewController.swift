//
//  LeaguesTableViewController.swift
//  Sportify
//
//  Created by Ahmed on 5/13/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import Reachability

class LeaguesTableViewController: UITableViewController, LeaguesViewProtocol {
    
    var reachability: Reachability?
    var isConnected: Bool = true
    var indicator : UIActivityIndicatorView!
    
    var selectedSport: String?
    private var presenter: LeaguesPresenterProtocol!
    private var leagues: [League] = []
    
    
    func showLeagues(_ leagues: [League]) {
        self.leagues = leagues
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.tableView.reloadData()
            
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(handleReachability(_:)), name: ReachabilityManager.reachabilityChangedNotification, object: nil)
        
        
        title = selectedSport ?? "Leagues"
        tableView.register(LeagueTableViewCell.self, forCellReuseIdentifier: "LeagueCell")
        tableView.rowHeight = 80
        
        guard let sport = selectedSport else {
            showError("No sport selected.")
            return
        }
        
        presenter = LeaguesPresenter(view: self, sportName: sport)
        
        self.setUpIndicator()
            setupReachability()
            if isConnected {
                
                presenter.fetchLeagues()
            
            } else {
               showInternetSettingsAlert()
            }
            
            reachability?.whenReachable = { [weak self] _ in
                self?.isConnected = true
                self?.presenter.fetchLeagues()
            }
            reachability?.whenUnreachable = { [weak self] _ in
                self?.isConnected = false
                self?.showInternetSettingsAlert()
            }
        
        
        
        
    }

    deinit {
        reachability?.stopNotifier()
    }
    
    func showInternetSettingsAlert() {
        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your internet settings and try again.",
            preferredStyle: .alert
        )
    
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        
        
        present(alert, animated: true)
    }


    func setUpIndicator() {
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.color = .red
        indicator.startAnimating()
        
        view.addSubview(indicator)
        
    }
    
    func setupReachability() {
        reachability = try? Reachability()
        
        reachability?.whenReachable = { [weak self] _ in
            self?.isConnected = true
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.isConnected = false
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
//    @objc private func handleReachability(_ notification: Notification) {
//        guard let isConnected = notification.object as? Bool else { return }
//
//        if !isConnected {
//            let alert = UIAlertController(title: "No Internet", message: "You are offline.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default))
//            present(alert, animated: true)
//        }
//    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leagues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: leagues[indexPath.row])
        
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let league = leagues[indexPath.row]
        
        guard let sport = selectedSport else { return }

        let leagueDetailsVC = LeagueDetailsViewController(
            sport: sport,
            leagueId: league.league_key ?? 0,
            leagueName: league.league_name ?? "League",
            leagueLogo: league.league_logo ?? ""
        )

        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }

}


/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


