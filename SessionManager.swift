//
//  SessionManager.swift
//  iosApp
//
//  Created by Hitesh Jayaram Sahu on 28/09/25.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let cookieKey = "sessionCookie"
    private let userIdKey = "user_id"
    private let userNameKey = "user_name"
    private let userEmailKey = "user_email"
    private let fcmTokenKey = "fcm_token"
    
    private init() {}

    // MARK: - Save Methods
    func saveSessionCookie(_ cookie: String) {
        userDefaults.set(cookie, forKey: cookieKey)
    }
    
    func saveUserId(_ id: String?) {
        userDefaults.set(id, forKey: userIdKey)
    }
    
    func saveUserName(_ name: String?) {
        userDefaults.set(name, forKey: userNameKey)
    }
    
    func saveUserEmail(_ email: String?) {
        userDefaults.set(email, forKey: userEmailKey)
    }
    
    func saveFcmToken(_ token: String?) {
        userDefaults.set(token, forKey: fcmTokenKey)
    }
    
    // MARK: - Get Methods
    func getSessionCookie() -> String? {
        return userDefaults.string(forKey: cookieKey)
    }
    
    func getUserId() -> String? {
        return userDefaults.string(forKey: userIdKey)
    }
    
    func getUserName() -> String? {
        return userDefaults.string(forKey: userNameKey)
    }
    
    func getUserEmail() -> String? {
        return userDefaults.string(forKey: userEmailKey)
    }
    
    func getFcmToken() -> String? {
        return userDefaults.string(forKey: fcmTokenKey)
    }
    
    // MARK: - Clear Session
    func clearSession() {
        userDefaults.removeObject(forKey: cookieKey)
        userDefaults.removeObject(forKey: userIdKey)
        userDefaults.removeObject(forKey: userNameKey)
        userDefaults.removeObject(forKey: userEmailKey)
        userDefaults.removeObject(forKey: fcmTokenKey)
    }

}
