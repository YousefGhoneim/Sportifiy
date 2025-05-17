//
//  FavTableViewController.swift
//  Sportify
//
//  Created by Ahmed on 5/15/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit
import CoreData


class FavTableViewController: UITableViewController {

    
    var indicator : UIActivityIndicatorView!
    //var coreDataLeagues: [Leagues] = [ ]
    var isConnected: Bool = true
    
    var coreDataLeagues: [Leagues] = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create static leagues
        let league1 = Leagues(context: context)
        
        league1.name = "English Premier League"
        league1.image = "https://example.com/premier_league.png"
        
        let league2 = Leagues(context: context)
        league2.name = "NBA"
        league2.image = "https://example.com/nba.png"
        
        let league3 = Leagues(context: context)
        
        league3.name = "NFL"
        league3.image = "https://example.com/nfl.png"
        
        return [league1, league2, league3]
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //fetchFromCoreData()
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func fetchFromCoreData() {
        
        indicator.startAnimating()
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Leagues> = Leagues.fetchRequest()
        
        do {
            coreDataLeagues = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.indicator.stopAnimating()
            }
        } catch {
            print("Failed to fetch from CoreData: \(error)")
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.showAlert(message: "Failed to load saved Leagues")
            }
        }
        
        
        
    }
    
    func setUpIndicator() {
        
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.color = .red
        indicator.startAnimating()
        
        view.addSubview(indicator)
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return coreDataLeagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        let league = coreDataLeagues[indexPath.row]
               cell.leagueName.text = league.name
               
               // Load image using Kingfisher or similar library
        if let imageUrl = league.image, let url = URL(string: imageUrl) {
                   cell.leagueImage.kf.setImage(with: url, placeholder: UIImage(named: "ball"))
               } else {
                   cell.leagueImage.image = UIImage(named: "ball")
               }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueToDelete = coreDataLeagues[indexPath.row]
            
            // Show confirmation alert
            let alert = UIAlertController(
                title: "Delete League",
                message: "Are you sure you want to delete \(leagueToDelete.name ?? "this league")?",
                preferredStyle: .alert
            )
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.performDeletion(at: indexPath)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
                self?.tableView.setEditing(false, animated: true)
            }
            
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true)
        }
    }
    
    private func performDeletion(at indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let leagueToDelete = coreDataLeagues[indexPath.row]
        
        context.delete(leagueToDelete)
        
        do {
            try context.save()
            coreDataLeagues.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            showAlert(message: "Failed to delete league: \(error.localizedDescription)")
            tableView.reloadData()
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

}

extension FavTableViewController {
    func showAlert(message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
