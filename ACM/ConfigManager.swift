//
//  ConfigManager.swift
//  ACM
//
//  Created by Connor Laber on 6/16/25.
//
//
//  ConfigManager.swift
//  ACM
//
//  Created by Connor Laber on 6/16/25.
//

import Foundation

struct ConfigManager {
    static let shared = ConfigManager()
    
    private init() {}
    
    private func getValue(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let value = plist[key] as? String else {
            fatalError("Could not find value for key: \(key) in Config.plist")
        }
        return value
    }
    
    var supabaseURL: String {
        return getValue(for: "SUPABASE_URL")
    }
    
    var supabaseAnonKey: String {
        return getValue(for: "SUPABASE_ANON_KEY")
    }
}
