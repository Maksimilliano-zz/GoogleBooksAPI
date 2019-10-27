

import UIKit
import GoogleSignIn


    
class AuthorizationVC: UIViewController {
//    Sigh In button
    let signInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        Set google auth API delegate
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance().presentingViewController = self
        
//        Add button to the screen
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
//    Handle authorization process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error == nil {
            let newVC = SearchBookVC()
            newVC.modalPresentationStyle = .fullScreen
            self.present(newVC, animated: true)
        } else {
          print("Error \(error.localizedDescription)")
        }
    }
    
    
}
