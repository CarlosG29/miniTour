//
//  Toruism practice
// Tourism
//
//  Created by Carlos Eduardo on 2/9/24.
//


import UIKit

class LoginView: UIViewController {

    let titleLabel = UILabel()
    let userTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let backgroundImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        // Configurar la imagen de fondo
        backgroundImageView.image = UIImage(named: "img1")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)

        // Configurar el título de bienvenida
        titleLabel.text = "¡Bienvenido a Tourism Nic!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Configurar el campo de texto para el usuario
        userTextField.placeholder = "Usuario"
        userTextField.text = "Carlos" // Valor predeterminado
        userTextField.borderStyle = .roundedRect
        userTextField.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userTextField)

        // Configurar el campo de texto para la contraseña
        passwordTextField.placeholder = "Contraseña"
        passwordTextField.text = "123456" // Valor predeterminado
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)

        // Boton login
        loginButton.setTitle("→", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        loginButton.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
        loginButton.layer.cornerRadius = 25
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)

        // Añadir restricciones de Auto Layout
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            userTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            userTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: userTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 60)
        ])
    }

    @objc func loginButtonTapped() {
        // Verificar credenciales (opcional)
        let username = userTextField.text
        let password = passwordTextField.text

        if username == "Carlos" && password == "123456" {
            // Redirigir a la vista Home
            let homeVC = HomeView()
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true, completion: nil)
        } else {
            // Mostrar alerta de error
            let alert = UIAlertController(title: "Error", message: "Usuario o contraseña incorrectos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
