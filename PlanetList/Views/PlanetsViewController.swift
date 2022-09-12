//
//  ViewController.swift
//  PlanetList
//
//  Created by Amila Prasad on 2022-09-11.
//

import UIKit
import Combine

class PlanetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let httpHandler = HttpRequestHandler()
    private var viewModel :PlanetsViewModel!
    private var cancellables : Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Planets"
        
        self.viewModel = PlanetsViewModel(httpHandler: httpHandler)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "PlanetListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlanetListTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        // Refresh List Navigation Button
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        self.setupSubscribers()
        viewModel.getPlanets()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupSubscribers(){
        
        // Alert message subscriber
        viewModel.$alertMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[unowned self] message in
                if let message = message {
                    self.showAlert(message: message)
                }
            }).store(in: &cancellables)
        
        // Planets list subscriber
        viewModel.$planets
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[unowned self] drinks in
                if (drinks.count > 0){
                    self.navigationItem.rightBarButtonItem?.isEnabled = false
                    self.tableView.reloadData()
                }else{
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                }
                
            }).store(in: &cancellables)
        
        // loader subscriber
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[unowned self] isLoading in
                if let isLoading = isLoading {
                    self.activityIndicator.isHidden = !isLoading
                }
            }).store(in: &cancellables)
        
    }

    // Common method to display alert message
    // Subscribed to $alertMessage in view model
    func showAlert( message: String) {
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func reloadData() {
        viewModel.getPlanets()
    }
    
    
    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlanetListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlanetListTableViewCell") as! PlanetListTableViewCell
        cell.tag = indexPath.row
        cell.configure(planet: viewModel.planets[indexPath.row], httpHandler: httpHandler)
        
        if(viewModel.url != nil && indexPath.row == viewModel.planets.count-1) {
            viewModel.getPlanets()
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let planetDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PlanetDetailsViewController") as! PlanetDetailsViewController
        planetDetailsVC.planet = viewModel.planets[indexPath.row]
        self.navigationController?.present(planetDetailsVC, animated: true)
    }
}

