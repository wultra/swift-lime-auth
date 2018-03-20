//
// Copyright 2018 Lime - HighTech Solutions s.r.o.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions
// and limitations under the License.
//

import UIKit

public enum Authentication {
    
    public enum Result {
        case success
        case failure
        case cancel
    }
    


    // MARK: - Common data
    
    public struct UIData {
        
        public struct CommonStrings {
            
            public let enterPin: String
            public let enterOldPin: String
            public let enterNewPin: String
            public let retypePin: String
            public let pinNoMatch: String
            
            public let enterPassword: String
            public let enterOldPassword: String
            public let enterNewPassword: String
            public let retypePassword: String
            public let passwordNoMatch: String
            
            public let useTouchId: String
            public let useFaceId: String
            
            public let okButton: String
            public let cancelButton: String
            public let yesButton: String
            public let noButton: String
            
            public let pleaseWait: String
            public let success: String
            
            public static func fallbackStrings() -> CommonStrings {
                return CommonStrings(
                    enterPin: "Enter PIN",
                    enterOldPin: "Enter old passcode",
                    enterNewPin: "Enter new passcode",
                    retypePin: "Retype new passcode",
                    pinNoMatch: "Passcodes did not match. Try again.",
                    
                    enterPassword: "Enter password",
                    enterOldPassword: "Enter old password",
                    enterNewPassword: "Enter new password",
                    retypePassword: "Retype new password",
                    passwordNoMatch: "Passwords did not match. Try again.",
                    
                    useTouchId: "Use Touch ID",
                    useFaceId: "Use Face ID",
                    
                    okButton: "OK",
                    cancelButton: "Cancel",
                    yesButton: "Yes",
                    noButton: "No",
                    
                    pleaseWait: "Please wait...",
                    success: "Operation did finish"
                )
            }
        }
        
        public struct CommonErrors {
            public let passwordChangeDidFail: String
            
            public static func fallbackErrors() -> CommonErrors {
                return CommonErrors(
                    passwordChangeDidFail: "Password change did fail on unknown error."
                )
            }
        }
        
        public struct CommonImages {
            
            public let success: LazyUIImage
            public let failure: LazyUIImage
            public let touchIdButton: LazyUIImage
            public let faceIdButton: LazyUIImage
            
            public static func fallbackImages() -> CommonImages {
                return CommonImages(success: .empty(),
                                    failure: .empty(),
                                    touchIdButton: .empty(),
                                    faceIdButton: .empty())
            }
        }
        
        public struct CommonStyle {
            public let tintColor: UIColor
            public let backgroundColor: UIColor
            
            public static func fallbackStyle() -> CommonStyle {
                return CommonStyle(tintColor: .blue,
                                   backgroundColor: .white)
            }
        }
    }
    
    
    // MARK: - Per operation data
    
    public struct UIRequest {
        
        public struct Prompts {
            /// Title for presented keyboard. For example: "Authorize"
            public var keyboardTitle: String?
            
            /// Prompt displayed in the keyboard. For example: "Enter PIN to authorize payment"
            public var keyboardPrompt: String?
            
            /// Prompt displayed in case the biometry system dialog is presented.
            public var biometricPrompt: String?
            
            /// An information message displayed during the execution activity. For example: "Authorizing your operation..."
            public var activityMessage: String?
            
            /// A success message displayed when operation ends correctly
            public var successMessage: String?
            
            public init() {
            }
        }
        
        public struct Options : OptionSet {
            
            /// Enables signing with possession factor.
            /// By default contains true
            public static let usePossession                = Options(rawValue: 1 << 0)
            
            /// If set, then the biometry factor will be used as a 2nd factor.
            ///
            /// If current activation doesn't contain biometry key, then you can still set this value to true.
            /// This boolean is just a hint and will be sanitized before the UI presentation to proper value.
            public static let allowBiometryFactor            = Options(rawValue: 1 << 1)
            
            /// If set, then the authentication will ask for biometry factor first and then the
            /// knowledge factor will be used as a fallback.
            ///
            /// If current activation doesn't contain biometry key, then you can still set this value to true.
            /// This boolean is just a hint and will be sanitized before the UI presentation to proper value.
            public static let askFirstForBiometryFactor    = Options(rawValue: 1 << 2)
            
            /// Combination for must used cases.
            public static let defaultValues: Options = [.usePossession]
            
            public let rawValue: Int
            
            public init(rawValue: Int) {
                self.rawValue = rawValue
            }
        }
        
        public struct Tweaks {
            /// If true, keyboard was presented as modal, with its own navigation controller.
            /// The keyboard can use this as hint for arranging UI components
            public var presentedAsModal: Bool = false
            
            /// If true, keyboard implementation should hide its navigation bar.
            public var hideNavigationBar: Bool = true
            
            /// Delay between operation success and keyboard dismiss
            public var successAnimationDelay: Int = 3000
            
            /// Delay between operation failure and retry
            public var errorAnimationDelay: Int = 1500
            
            public init() {
            }
        }
        
        public var options: Options
        public var prompts: Prompts
        public var tweaks: Tweaks
        
        public init(options: Options = .defaultValues, prompts: Prompts = Prompts(), tweaks: Tweaks = Tweaks()) {
            self.options = options
            self.prompts = prompts
            self.tweaks = tweaks
        }
    }
    
    
    public struct UIResponse {
        
        /// Set to error, when error occured
        public let error: LimeAuthError?
        
        /// (optional) object with result, but the type depends on the operation type
        public let result: Any?
        
        /// Set to true if operation has been cancelled
        public let cancelled: Bool
        
        /// Set to true if operation has been completed successfully
        public var completed: Bool {
            return !cancelled && error == nil
        }
        /// Returns true if response has error
        public var hasError: Bool {
            return error != nil
        }
        /// Response constructor
        public init(result: Any? = nil, error: LimeAuthError? = nil, cancelled: Bool = false) {
            self.error = error
            self.result = result
            self.cancelled = cancelled
        }
    }
    
    
    public struct UICredentials {
        public let password: String
        public let paswordOptionsIndex: Int?
        
        public init(password: String, optionsIndex: Int? = nil) {
            self.password = password
            self.paswordOptionsIndex = optionsIndex
        }
    }
    
    public struct UICredentialsChange {
        public let current: UICredentials
        public let next: UICredentials
    }
}