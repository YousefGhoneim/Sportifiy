import UIKit
import CoreData

class LeagueDetailsViewController: UIViewController, LeagueDetailsViewProtocol, TeamSelectionDelegate {

    // MARK: - Properties
    private var upcomingEvents: [Event] = []
    private var latestEvents: [Event] = []
    private var teams: [Team] = []

    private var presenter: LeagueDetailsPresenterProtocol!
    private var isFavorite: Bool = false

    private let leagueName: String
    private let leagueLogo: String
    private let leagueKey: Int
    private let sportName: String

    // MARK: - UI Components
    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()

    private let upcomingSection = EventSectionView(title: "Upcoming Events")
    private let latestSection = EventSectionView(title: "Latest Events")
    private let teamsSection = TeamSectionView()

    // MARK: - Init
    init(sport: String, leagueId: Int, leagueName: String, leagueLogo: String) {
        self.sportName = sport
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
        self.leagueKey = leagueId
        super.init(nibName: nil, bundle: nil)
        self.presenter = LeagueDetailsPresenter(view: self, sportName: sport, leagueId: leagueId)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = leagueName
        view.backgroundColor = .systemBackground

        setupLayout()
        isFavorite = isLeagueInFavorites()
        setupFavoriteButton()

        presenter.viewDidLoad()
    }

    // MARK: - Layout
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

        teamsSection.delegate = self // ✅ Set delegate

        contentStack.addArrangedSubview(upcomingSection)
        contentStack.addArrangedSubview(latestSection)
        contentStack.addArrangedSubview(teamsSection)
    }

    // MARK: - Favorite Button
    private func setupFavoriteButton() {
        let heartImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
        let favoriteButton = UIBarButtonItem(image: heartImage, style: .plain, target: self, action: #selector(didTapFavorite))
        navigationItem.rightBarButtonItem = favoriteButton
    }

    @objc private func didTapFavorite() {
        isFavorite.toggle()
        setupFavoriteButton()

        if isFavorite {
            saveLeagueToFavorites()
        } else {
            removeLeagueFromFavorites()
        }
    }

    private func saveLeagueToFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let league = Leagues(context: context)
        league.name = leagueName
        league.image = leagueLogo
        league.key = Int32(leagueKey)

        do {
            try context.save()
            print("League saved to favorites.")
        } catch {
            print("Failed to save league: \(error)")
        }
    }

    private func removeLeagueFromFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        let fetch: NSFetchRequest<Leagues> = Leagues.fetchRequest()
        fetch.predicate = NSPredicate(format: "key == %d", leagueKey)

        do {
            let results = try context.fetch(fetch)
            for league in results {
                context.delete(league)
            }
            try context.save()
            print("League removed from favorites.")
        } catch {
            print("Failed to remove league: \(error)")
        }
    }

    private func isLeagueInFavorites() -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let context = appDelegate.persistentContainer.viewContext

        let fetch: NSFetchRequest<Leagues> = Leagues.fetchRequest()
        fetch.predicate = NSPredicate(format: "key == %d", leagueKey)

        do {
            let count = try context.count(for: fetch)
            return count > 0
        } catch {
            return false
        }
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

    // MARK: - TeamSelectionDelegate
    func didSelectTeam(_ team: Team) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
            vc.configure(with: team, sport: sportName)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
