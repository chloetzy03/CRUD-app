//
//  ListViewController.swift
//  CRUD app
//
//  Created by Chloe Tay on 19/10/26.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    private var excuses: [Excuse] = [
        Excuse(activity: "Gym", reason: .tired, validity: 3),
        Excuse(activity: "Finish report", reason: .busy, validity: 2),
        Excuse(activity: "Run", reason: .tired, validity: 7),
        Excuse(activity: "Frisbee", reason: .lazy, validity: 1)
    ]
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Excuse Log"
        
        setupNavigationBar()
        setupTableView()
    }
    
    //MARK: - setup
    //adds the + button on the top right
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
    }
    
    
    private func setupTableView(){
        //tells the table that "im ur data source and delegate, ask me"
        tableView.delegate = self
        tableView.dataSource = self
        
        //register the cell so the table knows which class to use for rows
        tableView.register(ExcuseTableViewCell.self, forCellReuseIdentifier: ExcuseTableViewCell.identifier)
        
        // Let rows size themselves to fit their content.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        
        //add table to screen, make it fill the whole view
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        ])
        
    
    }
    
    //MARK: - Actions
    @objc private func addButtonTapped(){
        // No excuse passed -> the form is in "add" mode
        let formVC = ExcuseFormViewController()
        
        // Wrap in a navigation controller so the form gets its own top bar (Cancel/Save)
        let navController = UINavigationController(rootViewController: formVC)
        
        // slide up modally over the current screen
        present(navController, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    //implement numberOfRowsInSection
    // Q: "How many rows?"  A: one per excuse
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        excuses.count
        
    }
    
    //Implement cellForRowAt
    // Q: "What goes in this row?"  A: a cell filled with that excuse's data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ask the table for a recycled cell of our type
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExcuseTableViewCell.identifier,
            for: indexPath
        ) as? ExcuseTableViewCell else { //`as?` tries to treat it as an ExcuseTableViewCell; if that fails, return a plain cell
            return UITableViewCell()
        }

        // indexPath.row = which row (0, 1, 2...) grab that excuse and show it
        cell.configure(with: excuses[indexPath.row])
        return cell
    }
    
    
    //swipe-to-delete function
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            excuses.remove(at: indexPath.row)                      //remove from the data first
            tableView.deleteRows(at: [indexPath], with: .fade)     //then remove the row from the screen
        }
    }
    
    
    //MARK: - UITableViewDelegate
    // Called when a row is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)   // remove the grey highlight
        
        // 1. Find which excuse was tapped.
        let selectedExcuse = excuses[indexPath.row]
        
        // 2. Create a detail screen and hand it that excuse.
        let detailVC = ExcuseDetailViewController(excuse: selectedExcuse)
        
        // 3. Push it onto the navigation stack (slides in, with a back button for free).
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: ListViewController())
}

//
//#Preview {
//    ListViewController()
//}
