//
//  ViewController.swift
//  GoogleBooksFinder
//
//  Created by Maksim Chizhavko on 10/24/19.
//  Copyright © 2019 Maksim Chizhavko. All rights reserved.
//

import UIKit
import GoogleSignIn


    
class AuthorizationVC: UIViewController {
    
    let signInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
        
        
        self.view.addSubview(signInButton)
        let constraints: [NSLayoutConstraint] = [
            signInButton.heightAnchor.constraint(equalToConstant: 30),
            signInButton.widthAnchor.constraint(equalToConstant: 100),
            signInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
        
    }
    
    
    

}


extension AuthorizationVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            
        } else {
          print("Error \(error.localizedDescription)")
        }
    }
    
    
}
