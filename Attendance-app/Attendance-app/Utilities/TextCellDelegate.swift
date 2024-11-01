//
//  TextCellDelegate.swift
//  Attendance-app
//
//  Created by Keon Johnson on 10/10/24.
//

import UIKit

// Protocol for delegating text change events
protocol TextCellDelegate: AnyObject {
    func textCell(_ cell: TextCell, didChangeText text: String?)
}

class TextCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Label to display the title or description of the input field
    private let titleLabel = UILabel()
    
    // Text field for user input
    private let textField = UITextField()
    
    // Delegate to handle text change events
    weak var delegate: TextCellDelegate?
    
    // Property to get or set the text field's content
    var text: String? {
        get { textField.text }
        set {
            textField.text = newValue
            // Notify delegate of text changes
            delegate?.textCell(self, didChangeText: newValue)
        }
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // Required initializer for NSCoding compliance
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        // Disable cell selection highlighting
        selectionStyle = .none
        
        // Add and configure title label
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add and configure text field
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.autocorrectionType = .no
        
        // Add target for text change events
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // Set up Auto Layout constraints
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Position title label on the left side of the cell
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // Position text field to the right of the title label
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    // Method to configure the cell with a title and optional placeholder
    func configure(title: String, placeholder: String? = nil) {
        titleLabel.text = title
        textField.placeholder = placeholder
    }
    
    // MARK: - UITableViewCell
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Make the text field the first responder when the cell is selected
        if selected && !textField.isFirstResponder {
            textField.becomeFirstResponder()
        }
    }
    
    // MARK: - Actions
    
    // Called when the text field's content changes
    @objc private func textFieldDidChange() {
        // Update the text property, trimming whitespace and newlines
        text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
