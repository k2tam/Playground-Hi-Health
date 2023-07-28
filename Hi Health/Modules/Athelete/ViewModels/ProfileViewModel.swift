//
//  ProfileViewModel.swift
//  Hi Health
//
//  Created by k2 tam on 14/07/2023.
//

import Foundation
import UIKit
import SwiftyJSON

class ProfileViewModel {
        
    private var tableProfileData = ProfileTable()
    
    var groupedActivites: GroupedActivities?

    
     func performSignOut() {
         TokenDataManager.shared.clearUserLocalData()
         APIAuthen.shared.performDeauthorizeRequest(accessToken: TokenDataManager.shared.getAccessToken())
         
    }

    func fetchProfileTableData(completion: @escaping (_ profileTableData: ProfileTable) -> Void ) {
//
//        guard let tokenExchange = TokenDataManager.shared.getTokens() else {
//            print("No token exchange data")
//            return
//        }
        
        let athleteModel = TokenDataManager.shared.getAthleteModel()
        
        let userInfoSection = ProfileSection(firstName: athleteModel.firstName, lastName: athleteModel.lastName, state: athleteModel.state, country: athleteModel.country, avatarUrlString: athleteModel.profileMedium)
        
        
        APIActvity.shared.fetchAthleteGroupedActivitiesData { [self] groupedActivites in

            if let groupedActivites = groupedActivites {
                self.groupedActivites = groupedActivites

                let chartDataSection = ChartSection(groupedActivies: groupedActivites.activites)

                tableProfileData.profileSections = [ProfileSectionType.profile(userInfoSection),ProfileSectionType.chart(chartDataSection),ProfileSectionType.signOutBtn]
                completion(self.tableProfileData)


            }
        }

//        let chartDataSection = ChartSection(groupedActivies: [])
        
//        tableProfileData.profileSections = [ProfileSectionType.profile(userInfoSection),ProfileSectionType.chart(chartDataSection),ProfileSectionType.signOutBtn]
        
//        completion(tableProfileData)
        
    }
   
}



        
