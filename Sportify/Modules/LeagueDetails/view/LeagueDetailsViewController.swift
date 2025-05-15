//
//  LeagueDetailsViewController.swift
//  Sportify
//
//  Created by Yousef Ghoneim on 13/05/2025.
//  Copyright © 2025 Ahmed Ali. All rights reserved.
//

import UIKit

class LeagueDetailsViewController: UIViewController, LeagueDetailsViewProtocol {

    // MARK: - Properties
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []

    private var presenter: LeagueDetailsPresenterProtocol!

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let upcomingSection = EventSectionView(title: "Upcoming Events")
    private let latestSection = EventSectionView(title: "Latest Events")
    private let teamsSection = TeamSectionView()

    // MARK: - Init
    init(sport: String, leagueId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = LeagueDetailsPresenter(view: self, sportName: sport, leagueId: leagueId)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "League Details"
        view.backgroundColor = .systemBackground
        setupLayout()
        presenter.viewDidLoad()
    }

    // MARK: - Setup
    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        contentStack.axis = .vertical
        contentStack.spacing = 24
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        contentStack.addArrangedSubview(upcomingSection)
        contentStack.addArrangedSubview(latestSection)
        contentStack.addArrangedSubview(teamsSection)
    }

    // MARK: - View Protocol Methods
    func showUpcomingEvents(_ events: [Event]) {
        self.upcomingEvents = events
        upcomingSection.setEvents(events)
    }

    func showLatestEvents(_ events: [Event]) {
        self.latestEvents = events
        latestSection.setEvents(events)
    }

    func showTeams(_ teams: [Team]) {
        self.teams = teams
        teamsSection.setTeams(teams)
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
