//
//  SignOut.swift
//  Hi Health
//
//  Created by k2 tam on 27/07/2023.
//

import UIKit

protocol SignOutCellDelegate {
    func didPressSignOut()
}

class SignOutCell: UITableViewCell {
    
    var delegate: SignOutCellDelegate?
    
//    var callBack: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func signOutPressed(_ sender: UIButton) {
//            self.callBack?()
        delegate?.didPressSignOut()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func performDeauthorizeRequest(accessToken: String) {
        let urlString = "https://www.strava.com/oauth/deauthorize"
        let url = URL(string: urlString)

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        let bodyParameters = "access_token=\(accessToken)"
        request.httpBody = bodyParameters.data(using: .utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Error: \(error)")
                // Handle the error accordingly
                return
            }

        }

        task.resume()
    }
    
}
