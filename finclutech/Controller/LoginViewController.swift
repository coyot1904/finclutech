import UIKit
import Validator // Import the Validator library

class LoginViewController: UIViewController {
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let errorLabel = UILabel()

    private let validUsername = "testuser"
    private let validPassword = "password123"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        usernameField.placeholder = "Username"
        usernameField.borderStyle = .roundedRect
        
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true

        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 14)
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [usernameField, passwordField, loginButton, errorLabel])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc private func handleLogin() {
        // Validation
        let usernameValidation = usernameField.text?.isEmpty ?? true
        let passwordValidation = passwordField.text?.isEmpty ?? true

        if usernameValidation {
            errorLabel.text = "Username cannot be empty"
            return
        }

        if passwordValidation {
            errorLabel.text = "Password cannot be empty"
            return
        }

        if usernameField.text == validUsername && passwordField.text == validPassword {
            navigateToMainScreen()
        } else {
            errorLabel.text = "Invalid username or password"
        }
    }

    private func navigateToMainScreen() {
        let mainVC = MainScreenViewController()
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
