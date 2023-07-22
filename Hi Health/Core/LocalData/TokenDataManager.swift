//
//  TokenDataManager.swift
//  Hi Health
//
//  Created by k2 tam on 21/07/2023.
//

import Foundation

class TokenDataManager {
    let defaults = UserDefaults.standard

    static let shared = TokenDataManager()


    private init() {}

    // Save tokens to UserDefault
    func saveData(tokenExchange: TokenExchange) {
        defaults.set(tokenExchange.athleteId, forKey: K.UserDefaultKeys.athleteID)
        defaults.set(tokenExchange.accessToken, forKey: K.UserDefaultKeys.accessToken)
        defaults.set(tokenExchange.refreshToken, forKey: K.UserDefaultKeys.refreshToken)
        defaults.set(tokenExchange.expiresAt, forKey: K.UserDefaultKeys.expiresAt)
        
        
//        self.athleteModel = tokenExchange.athleteInfo
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(tokenExchange.athleteInfo)
            
            defaults.set(jsonData, forKey: K.UserDefaultKeys.athleteModel)
        } catch {
            print("Error encoding athlete instance: \(error)")
        }

    }
    
    func clearUserLocalData() {
        defaults.removeObject(forKey: K.UserDefaultKeys.athleteID)
        defaults.removeObject(forKey: K.UserDefaultKeys.accessToken)
        defaults.removeObject(forKey: K.UserDefaultKeys.refreshToken)
        defaults.removeObject(forKey: K.UserDefaultKeys.expiresAt)
        defaults.removeObject(forKey: K.UserDefaultKeys.athleteModel)
    }
    
    func getRefreshToken() -> Int {
        return defaults.integer(forKey: K.UserDefaultKeys.refreshToken)
    }
    
    
    func getTokenExpiresAt() -> Int {
        return defaults.integer(forKey: K.UserDefaultKeys.expiresAt)
    }
    
    

    func getTokens() -> TokenExchange? {
        let defaults = UserDefaults.standard
        guard
            let accessToken = defaults.string(forKey: K.UserDefaultKeys.accessToken),
            let refreshToken = defaults.string(forKey: K.UserDefaultKeys.refreshToken)
        else {
            return nil
        }
        
        let athleteId = defaults.integer(forKey: K.UserDefaultKeys.athleteID)
        let expiresAt = defaults.integer(forKey: K.UserDefaultKeys.expiresAt)
        
        let athleteModel: Athlete?

        if let athleteModelSaved = defaults.data(forKey: K.UserDefaultKeys.athleteModel) {
            let decoder = JSONDecoder()
            do {
                let savedAthleteInstance = try decoder.decode(Athlete.self, from: athleteModelSaved)
                // Now "savedAthleteInstance" contains the decoded Athlete instance
                print(savedAthleteInstance) // You can use the saved instance as needed
                athleteModel = savedAthleteInstance
            } catch {
                print("Error decoding athlete instance: \(error)")
                athleteModel = nil // Initialize the optional with nil in case of decoding error
            }
        } else {
            athleteModel = nil // Initialize the optional with nil if no data is saved in UserDefaults
        }

        // Use 'guard let' to ensure athleteModel is initialized before the return statement
        guard let initializedAthleteModel = athleteModel else {
            fatalError("Failed to initialize 'athleteModel'")
        }
        
        

        return TokenExchange(refreshToken: refreshToken, accessToken: accessToken, expiresAt: expiresAt, athleteId: athleteId, athleteInfo: initializedAthleteModel)
    }
}

