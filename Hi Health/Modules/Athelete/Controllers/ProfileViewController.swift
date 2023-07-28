//
//  ProfileViewController.swift
//  Hi Health
//
//  Created by k2 tam on 14/07/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    
//    var profileVM: FakeProfileViewModel!
    var profileVM: ProfileViewModel!

    var tableProfileData: ProfileTable!
    var groupedActivites: [SpecificActivity]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initProfileVM()
        initProfileTalble()
          
    }
    
    func initProfileVM() {
        
//      profileVM = FakeProfileViewModel()
        
        profileVM = ProfileViewModel()
        
        profileVM.fetchProfileTableData {[weak self] profileTableData in
            self?.tableProfileData = profileTableData
            
            DispatchQueue.main.async {
                self?.profileTableView.reloadData()
//                print(self?.tableProfileData.profileSections[1])
            }

        }
    }
    
    func initProfileTalble() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
            
        profileTableView.register(UINib(nibName: K.Cells.profileCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.profileCellId)
        profileTableView.register(UINib(nibName: K.Cells.chartCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.chartCellId)
        profileTableView.register(UINib(nibName: K.Cells.signOutBtnCellNibName, bundle: nil), forCellReuseIdentifier: K.Cells.signOutCellId)
       
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
     
        guard let profileData = tableProfileData else {
            return 0
        }
        
        return tableProfileData.profileSections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableProfileData.profileSections[section]{
        case let .items(itemsSection):
            return itemsSection.rows
        default:
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch tableProfileData.profileSections[section] {
        case let .profile(profileSectionModel):
            let profileInfoSectionView = tableView.dequeueReusableCell(withIdentifier: K.Cells.profileCellId) as! InfoCell
            profileInfoSectionView.displayNameLabel.text = profileSectionModel.profileNameDisplay
            profileInfoSectionView.locationLabel.text = profileSectionModel.userLocation
        
            let url = URL(string: profileSectionModel.avatarUrlString)
            
            if let url = url  {
                
                
                let session = URLSession(configuration: .default)
                
                let task = session.dataTask(with: url) { data, _, error in
                
                    DispatchQueue.main.async {
                        profileInfoSectionView.avatarImgView.image = UIImage(data: data!)
                    }
                    
                }
                
                task.resume()
            }
          
            return profileInfoSectionView
        case let .chart(chartSectionModel):
            let chartSectionView = tableView.dequeueReusableCell(withIdentifier: K.Cells.chartCellId) as! ChartCell   
            
            chartSectionView.chartCellData = chartSectionModel
 
            
            return chartSectionView
        case .signOutBtn:
            let signOutView = tableView.dequeueReusableCell(withIdentifier: K.Cells.signOutCellId) as! SignOutCell
                
//            signOutView.callBack = { [weak self] in
//                self?.profileVM.performSignOut()
//            }
            
            signOutView.delegate = self
            
            return signOutView
            
        default:
            return tableView.dequeueReusableCell(withIdentifier: K.Cells.profileCellId)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: InfoCellDelegate {
    
    func signOutButtonTapped() {
        
//        performDeauthorizeRequest(accessToken: TokenDataManager.shared.getAccessToken())

        TokenDataManager.shared.clearUserLocalData()
        
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    public func performDeauthorizeRequest(accessToken: String) {
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

extension ProfileViewController: SignOutCellDelegate {
    func didPressSignOut() {
        self.profileVM.performSignOut()
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }

}
