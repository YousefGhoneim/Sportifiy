import UIKit
import Lottie

class HomeViewController: UIViewController, HomeViewProtocol {

    // MARK: - IBOutlets for Sport Views
    @IBOutlet weak var footballView: UIView!
    @IBOutlet weak var basketballView: UIView!
    @IBOutlet weak var baseballView: UIView!
    @IBOutlet weak var tennisView: UIView!

    private var lottieBackgroundView: AnimationView!
    var presenter: HomePresenterProtocol!
    private var sports: [Sport] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addLottieBackground(named: "homeLottie")
        presenter = HomePresenter(view: self, viewController: self)
        presenter.viewDidLoad()
        setupGestureRecognizers()
        styleSportViews()
    }

    func showSports(_ sports: [Sport]) {
        self.sports = sports
        let views = [footballView, basketballView, baseballView, tennisView]
        let borderColors: [UIColor] = [.systemRed, .systemBlue, .systemGreen, .systemOrange]

        for view in views {
            view?.alpha = 0
        }

        for (index, sport) in sports.enumerated() where index < views.count {
            guard let view = views[index] else { continue }

            view.subviews.forEach { $0.removeFromSuperview() }

            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 16
            view.layer.borderWidth = 2
            view.layer.borderColor = borderColors[index % borderColors.count].cgColor
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOpacity = 0.1
            view.layer.shadowOffset = CGSize(width: 0, height: 2)
            view.layer.shadowRadius = 4
            view.layer.masksToBounds = false

            let label = UILabel()
            label.text = sport.name
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textColor = .label
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false

            let imageView = UIImageView(image: UIImage(named: sport.imageName))
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(label)
            view.addSubview(imageView)

            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18),

                imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 4),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])

            UIView.animate(withDuration: 0.4, delay: Double(index) * 0.1, options: [], animations: {
                view.alpha = 1
            })
        }
    }

    private func styleSportViews() {
        [footballView, basketballView, baseballView, tennisView].forEach {
            $0?.layer.cornerRadius = 16
            $0?.layer.shadowColor = UIColor.black.cgColor
            $0?.layer.shadowOpacity = 0.15
            $0?.layer.shadowOffset = CGSize(width: 0, height: 3)
            $0?.layer.shadowRadius = 6
            $0?.layer.masksToBounds = false
        }
    }

    private func addLottieBackground(named name: String) {
        guard let animation = Animation.named(name) else {
            print("Lottie animation '\(name)' not found.")
            return
        }

        lottieBackgroundView = AnimationView(animation: animation)
        lottieBackgroundView.contentMode = .scaleAspectFill
        lottieBackgroundView.loopMode = .loop
        lottieBackgroundView.animationSpeed = 0.8
        lottieBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        view.insertSubview(lottieBackgroundView, at: 0)

        NSLayoutConstraint.activate([
            lottieBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            lottieBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), // ✅ Important
            lottieBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lottieBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        lottieBackgroundView.play()
    }

    private func setupGestureRecognizers() {
        let footballTap = UITapGestureRecognizer(target: self, action: #selector(didTapFootball))
        footballView.addGestureRecognizer(footballTap)
        footballView.isUserInteractionEnabled = true

        let basketballTap = UITapGestureRecognizer(target: self, action: #selector(didTapBasketball))
        basketballView.addGestureRecognizer(basketballTap)
        basketballView.isUserInteractionEnabled = true

        let baseballTap = UITapGestureRecognizer(target: self, action: #selector(didTapCricket))
        baseballView.addGestureRecognizer(baseballTap)
        baseballView.isUserInteractionEnabled = true

        let tennisTap = UITapGestureRecognizer(target: self, action: #selector(didTapTennis))
        tennisView.addGestureRecognizer(tennisTap)
        tennisView.isUserInteractionEnabled = true
    }

    // MARK: - Tap Actions with Bounce Animation

    @objc private func didTapFootball() {
        animateTap(footballView) {
            self.presenter.didSelectSport(named: "Football")
        }
    }

    @objc private func didTapBasketball() {
        animateTap(basketballView) {
            self.presenter.didSelectSport(named: "BasketBall")
        }
    }

    @objc private func didTapCricket() {
        animateTap(baseballView) {
            self.presenter.didSelectSport(named: "Cricket")
        }
    }

    @objc private func didTapTennis() {
        animateTap(tennisView) {
            self.presenter.didSelectSport(named: "Tennis")
        }
    }

    private func animateTap(_ view: UIView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                           view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       }, completion: { _ in
                           UIView.animate(withDuration: 0.1,
                                          animations: {
                                              view.transform = CGAffineTransform.identity
                                          }, completion: { _ in
                                              completion()
                                          })
                       })
    }
}
