//
//  ViewController.swift
//  AppleLocationCrash
//
//  Created by steve.ham on 11/1/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var backgroundActivitySession: CLBackgroundActivitySession?
    private var needsLocationUpdate = false {
        didSet {
            updateStateLabel()
        }
    }
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "Background Location Updates Disabled"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the buttons
        let enableButton = UIButton(type: .system)
        enableButton.setTitle("enableBackgroundLocation", for: .normal)
        enableButton.addTarget(self, action: #selector(enableBackgroundLocation), for: .touchUpInside)
        
        let disableButton = UIButton(type: .system)
        disableButton.setTitle("disableBackgroundLocation", for: .normal)
        disableButton.addTarget(self, action: #selector(disableBackgroundLocation), for: .touchUpInside)
        
        // Create a stack view to hold the label and buttons
        let stackView = UIStackView(arrangedSubviews: [stateLabel, enableButton, disableButton])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the stack view to the main view
        view.addSubview(stackView)
        
        // Center the stack view in the view
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
//        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { [weak self] _ in
//            guard let self = self else { return }
//            print("hsteve didEnterBackgroundNotification")
//            if self.needsLocationUpdate {
//                self.backgroundActivitySession = CLBackgroundActivitySession() // === self.backgroundActivitySession = nil
//            } else {
//                self.backgroundActivitySession = nil
//            }
//        }
    }
    
    // Update label text based on the state of background location updates
    private func updateStateLabel() {
        stateLabel.text = needsLocationUpdate ? "Background Location Updates Enabled" : "Background Location Updates Disabled"
    }
    
    // Actions for the buttons
    @objc func enableBackgroundLocation() {
        print("hsteve enableBackgroundLocation")
        needsLocationUpdate = true
        backgroundActivitySession = CLBackgroundActivitySession()
//        let session = CLBackgroundActivitySession()
//        print("hsteve session \(session)")
    }
    
    @objc func disableBackgroundLocation() {
        print("hsteve disableBackgroundLocation")
        needsLocationUpdate = false
        backgroundActivitySession = nil
    }
}
