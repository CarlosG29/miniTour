//
//  Toruism practice
// Tourism
//
//  Created by Carlos Eduardo on 2/9/24.
//

import UIKit

class HomeView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let welcomeLabel = UILabel()
    let profileImageView = UIImageView()
    let searchTextField = UITextField()
    let tripsLabel = UILabel()
    let createTripButton = UIButton()
    var tripsCollectionView: UICollectionView!
    let cerroNegroImageView = UIImageView()
    let cerroNegroLabel = UILabel()
    let exploreLabel = UILabel()
    var exploreCollectionView: UICollectionView!
    let navBar = UIView()
    
    // Datos para la seccion Explore Places
    let exploreItems = [
        ("Costa_Rica", "Costa Rica"),
        ("tailandia", "Tailandia"),
        ("chile", "Chile"),
        ("Australia", "Australia"),
        ("SanJuan", "San Juan Del Sur")
    ]

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        // Inicializar la colección de viajes
        let tripsLayout = UICollectionViewFlowLayout()
        tripsLayout.scrollDirection = .horizontal
        tripsLayout.minimumLineSpacing = 16
        tripsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tripsLayout)

        // Inicializar la colección de lugares
        let exploreLayout = UICollectionViewFlowLayout()
        exploreLayout.scrollDirection = .horizontal
        exploreLayout.minimumLineSpacing = 16
        exploreCollectionView = UICollectionView(frame: .zero, collectionViewLayout: exploreLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    func setupUI() {
        // Agregar subviews a la vista principal
        view.addSubview(welcomeLabel)
        view.addSubview(profileImageView)
        view.addSubview(searchTextField)
        view.addSubview(tripsLabel)
        view.addSubview(createTripButton)
        view.addSubview(tripsCollectionView)
        view.addSubview(cerroNegroImageView)
        view.addSubview(cerroNegroLabel)
        view.addSubview(exploreLabel)
        view.addSubview(exploreCollectionView)
        view.addSubview(navBar)

        // Configurar etiqueta de bienvenida
        welcomeLabel.text = "Welcome Back, Carlos!"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 28)  //  tamaño de fuente
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar imagen de perfil
        profileImageView.image = UIImage(named: "PP")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 30 //  tamaño de la esquina redondeada
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar campo de texto de búsqueda
        searchTextField.placeholder = "Search Destination..."
        searchTextField.borderStyle = .none
        searchTextField.layer.cornerRadius = 25 //  el radio de las esquinas
        searchTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        searchTextField.font = UIFont.systemFont(ofSize: 16) //  el tamaño de fuente
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar etiqueta "Your Trips"
        tripsLabel.text = "Your Trips"
        tripsLabel.font = UIFont.boldSystemFont(ofSize: 22) //  el tamaño de fuente
        tripsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar botón de "Create Trip"
        createTripButton.setTitle("+ Create Trip", for: .normal)
        createTripButton.setTitleColor(.systemBlue, for: .normal)
        createTripButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18) //  el tamaño de fuente
        createTripButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar colección de viajes
        tripsCollectionView.backgroundColor = .clear
        tripsCollectionView.dataSource = self
        tripsCollectionView.delegate = self
        tripsCollectionView.register(ColeccionDeViajesCell.self, forCellWithReuseIdentifier: "tripCell")
        tripsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar etiqueta de "Explore Places"
        exploreLabel.text = "Explore Places"
        exploreLabel.font = UIFont.boldSystemFont(ofSize: 22) //  el tamaño de fuente
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar coleccion de lugares
        exploreCollectionView.backgroundColor = .clear
        exploreCollectionView.dataSource = self
        exploreCollectionView.delegate = self
        exploreCollectionView.register(ExploreCollectionViewCell.self, forCellWithReuseIdentifier: "exploreCell")
        exploreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configurar barra de navegacion inferior
        navBar.backgroundColor = UIColor.white
        navBar.translatesAutoresizingMaskIntoConstraints = false
        
        setupNavBar()
        
        // Añadir restricciones de Auto Layout
        NSLayoutConstraint.activate([
            // Posicionar welcomeLabel
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),  //  espacio superior

            // Posicionar profileImageView al lado derecho de welcomeLabel
            profileImageView.leadingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: welcomeLabel.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),  //  tamaño de la imagen
            profileImageView.heightAnchor.constraint(equalToConstant: 60),  //  tamaño de la imagen

            // Posicionar searchTextField debajo de welcomeLabel y profileImageView
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 25),  //  espacio entre elementos
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),  //  altura de la caja de búsqueda

            // Posicionar tripsLabel y createTripButton
            tripsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tripsLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 30),  //  espacio entre elementos
            
            createTripButton.leadingAnchor.constraint(equalTo: tripsLabel.trailingAnchor, constant: 20),
            createTripButton.centerYAnchor.constraint(equalTo: tripsLabel.centerYAnchor),

            // Posicionar tripsCollectionView debajo de tripsLabel
            tripsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tripsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tripsCollectionView.topAnchor.constraint(equalTo: tripsLabel.bottomAnchor, constant: 20),  //  espacio entre elementos
            tripsCollectionView.heightAnchor.constraint(equalToConstant: 150),  //  tamaño de la colección de viajes

            // Posicionar exploreLabel debajo de tripsCollectionView
            exploreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exploreLabel.topAnchor.constraint(equalTo: tripsCollectionView.bottomAnchor, constant: 30),  //  espacio entre elementos

            // Posicionar exploreCollectionView debajo de exploreLabel
            exploreCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exploreCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exploreCollectionView.topAnchor.constraint(equalTo: exploreLabel.bottomAnchor, constant: 20),  //  espacio entre elementos
            exploreCollectionView.heightAnchor.constraint(equalToConstant: 150),  //  tamaño de la colección de lugares

            // Posicionar barra de navegación en la parte inferior
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 70)  //  tamaño de la barra de navegación
        ])
    }
    
    func setupNavBar() {
        // Configurar iconos de la barra de navegación
        let homeButton = UIButton()
        homeButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(homeButton)

        let searchButton = UIButton()
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(searchButton)

        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        navBar.addSubview(settingsButton)

        NSLayoutConstraint.activate([
            homeButton.centerXAnchor.constraint(equalTo: navBar.centerXAnchor, constant: -80),
            homeButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            homeButton.widthAnchor.constraint(equalToConstant: 35),  //  tamaño del icono
            homeButton.heightAnchor.constraint(equalToConstant: 35),  //  tamaño del icono

            searchButton.centerXAnchor.constraint(equalTo: navBar.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 35),  //  tamaño del icono
            searchButton.heightAnchor.constraint(equalToConstant: 35),  //  tamaño del icono

            settingsButton.centerXAnchor.constraint(equalTo: navBar.centerXAnchor, constant: 80),
            settingsButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 35),  //  tamaño del icono
            settingsButton.heightAnchor.constraint(equalToConstant: 35)  //  tamaño del icono
        ])
    }


    
    

    @objc func homeButtonTapped() {
        print("Already on HomeView")
    }

    @objc func searchButtonTapped() {
        searchTextField.becomeFirstResponder()
    }

    @objc func settingsButtonTapped() {
        let alert = UIAlertController(title: "Settings", message: "Would you like to log out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    
    
    //
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == exploreCollectionView ? exploreItems.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tripsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tripCell", for: indexPath) as! ColeccionDeViajesCell
            cell.imageView.image = UIImage(named: "CerroNegro")
            cell.titleLabel.text = "Trip to Cerro Negro"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCollectionViewCell
            let item = exploreItems[indexPath.row]
            cell.imageView.image = UIImage(named: item.0)
            cell.titleLabel.text = item.1
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// Clase personalizada para celdas de Explore Places
class ExploreCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100), // tamaño de la imagen

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
