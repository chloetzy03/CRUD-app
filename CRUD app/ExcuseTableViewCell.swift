//
//  ExcuseTableViewCell.swift
//  CRUD app
//
//  Created by Chloe Tay on 19/10/26.
//

import UIKit

//describes how ONE excuse looks in the list
class ExcuseTableViewCell: UITableViewCell {

    //tag for this cell type so can recycle the rows
    static let identifier = "ExcuseTableViewCell" //static means it belongs to the class itself
    
    // MARK: - Labels (one text box per piece of data)
    private let activityLabel = UILabel()   // e.g. "Gym"
    private let reasonLabel = UILabel()     // e.g. "Tired"
    private let validityLabel = UILabel()   // e.g. "Validity: 3/10"
    private let dateLabel = UILabel()       // e.g. "19 Oct 2026"

    //date formatter
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium   // e.g. "19 Oct 2026"
        formatter.timeStyle = .none     // we don't care abt the time
        return formatter
    }()

    // MARK: - Initialisers
    // Runs when the cell is created in code
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)  // let UIKit do its own setup first
        setupUI()                                                   // then do ours
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupUI(){
        // The ">" on the right telling the user "tap for more"
        accessoryType = .disclosureIndicator
        
        // Style the labels.
        activityLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        reasonLabel.font = .systemFont(ofSize: 14)
        validityLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 14)
        reasonLabel.textColor = .secondaryLabel
        validityLabel.textColor = .secondaryLabel
        dateLabel.textColor = .secondaryLabel
        
        // Row of small details side by side: reason | validity | date
        let detailsStack = UIStackView(arrangedSubviews: [reasonLabel, validityLabel, dateLabel])
        detailsStack.axis = .horizontal   // left to right
        detailsStack.spacing = 12         // gap between labels
        
        // Whole cell: activity on top, details row underneath
        let mainStack = UIStackView(arrangedSubviews: [activityLabel, detailsStack])
        mainStack.axis = .vertical        // top to bottom
        mainStack.spacing = 4
        
        // Add it to the cell. `contentView` is the area inside the cell where content goes (the chevron lives outside it).
        mainStack.translatesAutoresizingMaskIntoConstraints = false  // we're using manual constraints
        contentView.addSubview(mainStack)
        
        // Pin the stack to the cell's edges, with some padding
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
    }
    
    // MARK: - Configure

       //the list screen calls this for each row: "show THIS excuse in this cell"
       func configure(with excuse: Excuse) {
           activityLabel.text = excuse.activity
           reasonLabel.text = excuse.reason.rawValue
           validityLabel.text = "Validity: \(excuse.validity)/10"
           dateLabel.text = Self.dateFormatter.string(from: excuse.date)
       }
    
    
}
