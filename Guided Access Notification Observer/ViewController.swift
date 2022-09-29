//
//  ViewController.swift
//  Guided Access Notification Observer
//
//  Created by Gregorius Albert on 29/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ""
        view.textColor = .black
        view.textAlignment = .center
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configuration = .filled()
        view.setTitle("Open Guided Access Setting", for: .normal)
        view.addTarget(self, action: #selector(openGuidedAccessSettings), for: .touchUpInside)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(button)
        setupConstraints()
        
        setupObserver()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(
            forName: UIAccessibility.guidedAccessStatusDidChangeNotification,
            object: nil,
            queue: OperationQueue.main) { _ in
                if UIAccessibility.isGuidedAccessEnabled {
                    self.label.text = "Guided Access Enabled"
                } else {
                    self.label.text = "Guided Access Disabled"
                }
            }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalToSystemSpacingAfter: view.centerXAnchor, multiplier: 1)
        ])
    }
    
    @objc private func openGuidedAccessSettings() {
        let urlString = "App-prefs:ACCESSIBILITY&path=GUIDED_ACCESS_TITLE"
        let url = URL(string: urlString)!
        UIApplication.shared.open(url)
    }
    
}

