import UIKit
import FirebaseAuth

class AuthController: UIViewController {
    // MARK: - UI Elements
        private let emailField: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor(white: 1, alpha: 0.2)
            textField.textColor = .white
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            // Açıq placeholder rəngi
            textField.attributedPlaceholder = NSAttributedString(
                string: "Email Address",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            
            return textField
    }()
    
        private let nameField: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor(white: 1, alpha: 0.2)
            textField.textColor = .white
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            // Açıq placeholder rəngi
            textField.attributedPlaceholder = NSAttributedString(
                string: "Your Name",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            
            return textField
        }()

        private let passwordField: UITextField = {
            let textField = UITextField()
            textField.borderStyle = .roundedRect
            textField.backgroundColor = UIColor(white: 1, alpha: 0.2)
            textField.textColor = .white
            textField.isSecureTextEntry = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            // Açıq placeholder rəngi
            textField.attributedPlaceholder = NSAttributedString(
                string: "Password",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            )
            
            return textField
        }()
        
    @objc private let signUpButton: UIButton = {
            let button = UIButton()
            button.setTitle("Sign up", for: .normal)
            button.backgroundColor = UIColor.systemPink
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        private let socialStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.spacing = 16
            stackView.distribution = .equalSpacing
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        private func createSocialButton(imageName: String) -> UIButton {
            let button = UIButton()
            button.setImage(UIImage(named: imageName), for: .normal)
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(white: 1, alpha: 0.2)
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            return button
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor.black
            setupUI()
        }
    
        @objc func signUpTapped() {
            if let email = emailField.text, !email.isEmpty,
               let name = nameField.text, !name.isEmpty,
               let password = passwordField.text, !password.isEmpty {
                
                if Auth.auth().currentUser == nil {
                    Auth.auth().createUser(withEmail: email,
                                           password: password) { result, error in
                        if let error {
                            print(error.localizedDescription)
                        } else if let result {
                            print(result)
                        }
                    }
                } else {
                    Auth.auth().signIn(withEmail: email,
                                       password: password) { result, error in
                        if let error {
                            print(error.localizedDescription)
                        } else if let result {
                            print(result)
                        }
                    }
                }
                
            }
        }
        
        private func setupUI() {
            view.addSubview(emailField)
            view.addSubview(nameField)
            view.addSubview(passwordField)
            view.addSubview(signUpButton)
            view.addSubview(socialStackView)
            
            let googleButton = createSocialButton(imageName: "google_icon")
            let appleButton = createSocialButton(imageName: "apple_icon")
            let facebookButton = createSocialButton(imageName: "facebook_icon")
            
            socialStackView.addArrangedSubview(googleButton)
            socialStackView.addArrangedSubview(appleButton)
            socialStackView.addArrangedSubview(facebookButton)
            
            signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
                emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
                
                nameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
                nameField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
                nameField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
                
                passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
                passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
                passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
                
                signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
                signUpButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
                signUpButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
                signUpButton.heightAnchor.constraint(equalToConstant: 50),
                
                socialStackView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 40),
                socialStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                socialStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
}
