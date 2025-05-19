//
//  FavTableViewController.swift
//  Sportify
//
//  Created by Ahmed on 5/15/25.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController, FavoritesViewProtocol {

    private var presenter: FavoritesPresenterProtocol!
    private var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
        setupTableView()
        presenter = FavoritesPresenter(view: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicator.startAnimating()
        presenter.fetchFavorites() // refresh on every appear
    }

    private func setupTableView() {
        //  REMOVE XIB registration - you're using storyboard
        // tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")

        tableView.rowHeight = 80
    }

    private func setupIndicator() {
        indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.color = .red
        view.addSubview(indicator)
    }

    // MARK: - FavoritesViewProtocol Methods

    func showLeagues(_ leagues: [Leagues]) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
    }

    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }

    // MARK: - TableView DataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let league = presenter.favorites[indexPath.row]
        cell.leagueName.text = league.name

        if let imageUrl = league.image, let url = URL(string: imageUrl) {
            cell.leagueImage.kf.setImage(with: url, placeholder: UIImage(named: "ball"))
        } else {
            cell.leagueImage.image = UIImage(named: "ball")
        }

        return cell
    }

    // MARK: - TableView Deletion

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let league = presenter.favorites[indexPath.row]
            let alert = UIAlertController(
                title: "Delete League",
                message: "Are you sure you want to delete \(league.name ?? "this league")?",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.presenter.deleteLeague(at: indexPath.row)
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(alert, animated: true)
        }
    }

    // MARK: - League Tapped → Navigate to LeagueDetails

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let league = presenter.favorites[indexPath.row]

        let vc = LeagueDetailsViewController(
            sport: "football", // or store actual sport if available
            leagueId: Int(league.key),
            leagueName: league.name ?? "Unknown",
            leagueLogo: league.image ?? ""
        )

        navigationController?.pushViewController(vc, animated: true)
    }
}
