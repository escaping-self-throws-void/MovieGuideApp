//
//  Constants.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 07/07/2022.
//

import Foundation

enum C {
    enum Colors {
        static let brownishGreyTwo = "#brownishGreyTwo"
        static let dark = "#dark"
        static let darkBlueGrey = "#darkBlueGrey"
        static let darkSkyBlue = "#darkSkyBlue"
        static let darkGrey = "#dark grey"
        static let dustyRed = "#dustyRed"
        static let midBlue = "#midBlue"
        static let nightBlue = "#nightBlue"
        static let cobalt = "#cobalt"
        static let dullOrange = "#dullOrange"
        static let lightPeriwinkle = "#lightPeriwinkle"
        static let greyishBrownThree = "#greyishBrownThree"
        static let warmGrey = "#warmGrey"
        static let veryLightPink = "#veryLightPink"
        static let veryLightPinkThree = "#veryLightPinkThree"
        static let darkishBlue = "#darkishBlue"
        static let navy = "#navy"
        static let blackZero = "#blackZero"
        static let darkTwo = "#darkTwo"
        static let greyishBrownFour = "#greyishBrownFour"
        static let waterBlue = "#waterBlue"
    }

    enum Images {
        static let eyeOpened = "eyeOpenBttn"
        static let eyeClosed = "eyeClosedBttn"
        static let calendar = "calendarBttn"
        static let exit = "exitBttn"
        static let check = "checkBttn"
        static let circle = "circleBttn"
        static let disclosure = "disclosureBttn"
        static let timelineBackground = "timelineBg"
        static let mbcTwoPlaceholder = "mbc2Placeholder"
        static let mbcMaxPlaceholder = "mbcMaxPlaceholder"
        static let mbcTwoLogo = "mbc2Logo"
        static let mbcMaxLogo = "mbcMaxLogo"
        static let burgerMenu = "burgerBarButton"
        static let calendarBarButton = "calendarBarButton"
        static let sideMenuBg = "sideMenuBg"
        static let genreIcon = "genreIcon"
        static let logoutIcon = "logoutIcon"
        static let quizIcon = "quizIcon"
        static let settingsIcon = "settingsIcon"
        static let timelineIcon = "timelineIcon"
        static let userIcon = "userIcon"
        static let watchlistIcon = "watchlistIcon"
        static let reminderButton = "reminderBttn"
        static let exitBarButton = "exitBarBttn"
        static let actorPlaceholder = "actorPlaceholder"
        static let addReminder = "addReminder"
        static let shareIcon = "shareIcon"
        static let watchNowIcon = "watchNowIcon"
        static let rightDisclosure = "rightDisclosure"
        static let privacyIcon = "privacyIcon"
        static let timeFormatIcon = "timeFormatIcon"
        static let notificationIcon = "notificationIcon"
        static let languageIcon = "languageIcon"
    }
    
    enum LocKeys {
        static let skipBttn = "Skip"
        static let signBttn = "Sign Up"
        static let alreadyLbl = "Already have an account?"
        static let logInBttn = "Log in here"
        static let orLbl = "OR"
        static let sUFirstNameCellLbl = "  First Name  "
        static let sULastNameCellLbl = "  Last Name  "
        static let sUEmailCellLbl = "  Email  "
        static let sUPasswordCellLbl = "  Password  "
        static let sUConfirmPassCellLbl = "  Confirm Password  "
        static let sUNamePlaceholder = "First Name"
        static let sULastNamePlaceholder = "Last Name"
        static let sUEmailPlaceholder = "Email"
        static let sUPasswordPlaceholder = "Password"
        static let sUConfirmPlaceholder = "Confirm Password"
        static let sUBirthdayPlaceholder = "Birthday (Optional)"
        static let sUGenderPlaceholder = "Gender (Optional)"
        static let sUCountryPlaceholder = "Country (Optional)"
        static let sUBigButtonLbl = "Sign Up"
        static let sUBigButtonLogInLbl = "Login"
        static let sUForgotButton = "Forgot?"
        static let sUNameErrorLbl = "Wrong name format"
        static let sULastNameErrorLbl = "Wrong lastname format"
        static let sUEmailErrorLbl = "Not valid email format"
        static let sUPasswordErrorLb = "Atleast one letter, one special character with the length of 8 digits"
        static let sUConfirmErrorLbl = "Password does not match"
        static let timelineBarTitleLbl = "Timeline"
        static let nowTimeStampLbl = "NOW"
        static let sideMenuAccount = "Guest"
        static let sideMenuGenres = "Genres"
        static let sideMenuWatchlist = "Watchlist"
        static let sideMenuQuiz = "Quiz"
        static let sideMenuLogout = "Logout"
        static let sideMenuLogin = "Login"
        static let watchListButton = "Add to Watchlist"
        static let chatroomButton = "Chatroom"
        static let castSectionTitle = "Cast"
        static let directorsSectionTitle = "Directors"
        static let genresSectionTitle = "Genres"
        static let reminderMenuWatchNow = "Watch Now"
        static let reminderMenuSetReminder = "Set Reminder"
        static let reminderMenuShareMovie = "Share Movie Via..."
        static let settingsTitle = "Settings"
        static let languageRowTitle = "Language"
        static let notificationsRowTitle = "Notifications"
        static let timeFormatRowTitle = "24-Hour Time"
        static let privacyRowTitle = "Privacy Policy"
        static let alertSuccessTitle = "Successfully added to your calendar"
        static let alertFailureTitle = "The event was not added"
        static let alertSuccessMessage = "Reminder was set 30 mins before movie starts!"
        static let alertFailureMessage = "Please try again"
        static let alertActionTitle = "OK"
    }
    
    enum Fonts {
        static let almaraiBold = "Almarai-Bold"
        static let almaraiExtraBold = "Almarai-ExtraBold"
        static let almaraiRegular = "Almarai-Regular"
        static let heeboRegular = "Heebo-Regular"
    }
    
    enum Links {
        static let terms = "YOUR_TERMS"
        static let privacy = "YOUR_PRIVACY_POLICY"
        static let movieDataApi = "YOUR_MOVIES_API"
        static let movieDetailApi = "YOUR_DETAILS_API"
    }
    
    enum Lang {
        static let en = "en"
        static let ar = "ar"
    }
    
    enum Genders {
        static let none = "Not selected"
        static let male = "Male"
        static let female = "Female"
    }
}
