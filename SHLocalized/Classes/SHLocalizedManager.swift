//
//  HomeBundle.swift
//  KBCore_Example
//
//  Created by Ray on 2023/11/10.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

public func NSLocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
    if let path = bundle.path(forResource: SHLocalizedManager.share.currentLanguage, ofType: "lproj"),
        let bundle = Bundle(path: path) {
        return bundle.localizedString(forKey: key, value: nil, table: tableName)
    } else if let path = bundle.path(forResource: SHLocalizedManager.share.LCLBaseBundle, ofType: "lproj"),
        let bundle = Bundle(path: path) {
        return bundle.localizedString(forKey: key, value: nil, table: tableName)
    }
    return Foundation.NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}

public class SHLocalizedManager {
    /// Internal current language key
    fileprivate let LCLCurrentLanguageKey = "LCLCurrentLanguageKey"
    /// Default language. English. If English is unavailable defaults to base localization.
    fileprivate let LCLDefaultLanguage = "en"

    /// Base bundle as fallback.
    fileprivate let LCLBaseBundle = "Base"

    /// Name for language change notification
    public static let LCLLanguageChangeNotification = "LCLLanguageChangeNotification"
    
    public static let share: SHLocalizedManager = .init()
    
    fileprivate var cacheLanguage: String?
    
    public var currentDisplayLanguage: String {
        self.displayNameForLanguage(self.currentLanguage)
    }
    
    /// 当前语言
    public var currentLanguage: String {
        set {
            let language = newValue
            let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
            if (selectedLanguage != cacheLanguage){
                cacheLanguage = selectedLanguage
                UserDefaults.standard.set(selectedLanguage, forKey: LCLCurrentLanguageKey)
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: Notification.Name(rawValue: SHLocalizedManager.LCLLanguageChangeNotification), object: nil)
            }
        }
        get {
            if let cacheLanguage = cacheLanguage {
                return cacheLanguage
            }
            if let currentLanguage = UserDefaults.standard.object(forKey: LCLCurrentLanguageKey) as? String {
                cacheLanguage = currentLanguage
                return currentLanguage
            }
            cacheLanguage = defaultLanguage()
            return defaultLanguage()
        }
    }
    
    
    /// 获取默认的语言参
    /// - Returns: en
    public func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return LCLDefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = LCLDefaultLanguage
        }
        return defaultLanguage
    }
    
    private init() {
        
    }
    
    /// 获得语言列表数据
    /// - Parameter excludeBase: 是否包含base
    /// - Returns: 数组en
    public func availableLanguages(_ excludeBase: Bool = false) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.firstIndex(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    public func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: currentLanguage)
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
    
    
    /// 获取语言列表
    /// - Returns: 列表
    public func displayLanguages() -> [String] {
        let list = self.availableLanguages().map { item in
            self.displayNameForLanguage(item)
        }
        return list
    }
    
    
    public func resetCurrentLanguageToDefault() {
        self.currentLanguage = self.defaultLanguage()
    }
    
    public static func NSLocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String) -> String {
        if let path = bundle.path(forResource: SHLocalizedManager.share.currentLanguage, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: nil, table: tableName)
        } else if let path = bundle.path(forResource: SHLocalizedManager.share.LCLBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: key, value: nil, table: tableName)
        }
        return Foundation.NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }
}

