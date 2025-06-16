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
    
    private func getValue(for key: String) -> String? {
        // First, try to load from Config.plist
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: path),
           let value = plist[key] as? String {
            return value
        }
        
        // If Config.plist doesn't exist, try environment variables
        if let envValue = ProcessInfo.processInfo.environment[key], !envValue.isEmpty {
            return envValue
        }
        
        return nil
    }
    
    var supabaseURL: String {
        // Try to get from Config.plist or environment
        if let value = getValue(for: "SUPABASE_URL") {
            return value
        }
        
        // Fallback for development/testing
        print("⚠️ Config.plist not found, using fallback Supabase URL")
        return "https://qmfxylsrkgdgrtmzdjjw.supabase.co"
    }
    
    var supabaseAnonKey: String {
        // Try to get from Config.plist or environment
        if let value = getValue(for: "SUPABASE_ANON_KEY") {
            return value
        }
        
        // Fallback for development/testing
        print("⚠️ Config.plist not found, using fallback Supabase key")
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFtZnh5bHNya2dkZ3J0bXpkamp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwNTAyOTMsImV4cCI6MjA2NTYyNjI5M30.Tmfi0PRVoWW_XMMeOILdbqJWQTJh9JhmLvuemMr92_k"
    }
    
    // Helper method to check if we're using secure configuration
    var isUsingSecureConfig: Bool {
        return Bundle.main.path(forResource: "Config", ofType: "plist") != nil
    }
    
    // Method to validate configuration
    func validateConfiguration() {
        if !isUsingSecureConfig {
            print("🚨 WARNING: Using fallback credentials! Create Config.plist for production.")
            print("📝 Instructions:")
            print("   1. Copy Config.plist.template to Config.plist")
            print("   2. Add your Supabase credentials to Config.plist")
            print("   3. Rebuild the app")
        } else {
            print("✅ Using secure configuration from Config.plist")
        }
    }
}
