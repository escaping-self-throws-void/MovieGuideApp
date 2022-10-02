//
//  LanguageService.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 17/07/2022.
//

import UIKit
import Localize_Swift

final class LanguageService {
    
    static let shared = LanguageService()
        
    var isEn = NSLocale.current.languageCode != C.Lang.ar
    
    private init() {}
    
    func changeLanguage(_ appStart: Bool = false) {
        let lan = isEn ? C.Lang.en : C.Lang.ar
        Localize.setCurrentLanguage(lan)
        changeSemantics()
        reloadApp(appStart)
    }
    
    private func reloadApp(_ appStart: Bool) {
        let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        let coord = AppCoordinator(window: appDelegate?.window ?? UIWindow())
        appStart ? coord.start() : coord.startWithNewLanguage()
    }
    
    private func changeSemantics() {
        let semantic: UISemanticContentAttribute = isEn ? .forceLeftToRight : .forceRightToLeft
        UIView.appearance().semanticContentAttribute = semantic
        UILabel.appearance().semanticContentAttribute = semantic
        UINavigationBar.appearance().semanticContentAttribute = semantic
        UITabBar.appearance().semanticContentAttribute = semantic
        UITableView.appearance().semanticContentAttribute = semantic
        UISwitch.appearance().semanticContentAttribute = semantic
        UITextField.appearance().semanticContentAttribute = semantic
    }
}
