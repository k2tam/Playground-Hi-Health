//
//  TokenDataManager.swift
//  Hi Health
//
//  Created by k2 tam on 21/07/2023.
//

import Foundation

class TokenDataManager {
    
    var athleteModel: Athlete!

    static let shared = TokenDataManager()


    private init() {}

    // UserDefault keys
    private enum UserDefaultKeys {
        static let athleteID = "AthleteID"
        static let accessToken = "AccessToken"
        static let refreshToken = "RefreshToken"
        static let expiresAt = "ExpiresAt"
    }

    // Save tokens to UserDefault
    func saveData(tokenExchange: TokenExchange) {
        let defaults = UserDefaults.standard
        defaults.set(tokenExchange.athleteId, forKey: UserDefaultKeys.athleteID)
        defaults.set(tokenExchange.accessToken, forKey: UserDefaultKeys.accessToken)
        defaults.set(tokenExchange.refreshToken, forKey: UserDefaultKeys.refreshToken)
        defaults.set(tokenExchange.expiresAt, forKey: UserDefaultKeys.expiresAt)
        
        athleteModel = tokenExchange.athleteInfo

    }


    func getTokens() -> TokenExchange? {
        let defaults = UserDefaults.standard
        guard
              let accessToken = defaults.string(forKey: UserDefaultKeys.accessToken),
              let refreshToken = defaults.string(forKey: UserDefaultKeys.refreshToken)
        else {
            return nil
        }
        
        let athleteId = defaults.integer(forKey: UserDefaultKeys.athleteID)
        let expiresAt = defaults.integer(forKey: UserDefaultKeys.expiresAt)

        return TokenExchange(refreshToken: refreshToken, accessToken: accessToken, expiresAt: expiresAt, athleteId: athleteId, athleteInfo: athleteModel)
    }
}

