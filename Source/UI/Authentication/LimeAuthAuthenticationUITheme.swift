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

public struct LimeAuthAuthenticationUITheme {
    
    public struct Common {
        
        /// Common background color for all scenes.
        /// You can choose between `backgroundColor` or `backgroundImage`, or use both.
        public var backgroundColor: UIColor?
        
        /// Common background image for all scenes.
        /// You can choose between `backgroundColor` or `backgroundImage`, or use both.
        public var backgroundImage: LazyUIImage?
        
        /// Style applied to all activity indicators
        public var activityIndicator: ActivityIndicatorStyle
        
        /// Style used for system keyboards
        public var keyboardAppearance: UIKeyboardAppearance
    }
    
    public struct Images {
        
        /// Logo displayed in pin keyboards
        public var logo: LazyUIImage?
        
        /// Image displayed when entered password is correct
        public var successImage: LazyUIImage
        
        /// Image displayed in case of error
        public var failureImage: LazyUIImage
        
        /// Touch ID icon for PIN keyboard's biometry button
        public var touchIdIcon: LazyUIImage
        
        /// Face ID icon for PIN keyboard's biometry button
        public var faceIdIcon: LazyUIImage
    }
    
    public struct Buttons {
        
        /// Style for all digits on PIN keyboard
        public var pinDigits: ButtonStyle
        
        /// Style for all auxiliary buttons (backspace, cancel, etc...) on PIN keyboard
        public var pinAuxiliary: ButtonStyle
        
        /// "OK" button used in scene with variable PIN length, or in alphanumeric password
        public var ok: ButtonStyle
        
        /// A "Close / Cancel" button used typically on alphanumeric password picker.
        public var close: ButtonStyle
        
        /// Style for button embededd in keyboard's accessory view. This button is typically
        /// used when a new alphanumeric password is going to be created ("Choose password complexity"),
        /// or as biometry button on alphanumeric password picker ("Use Touch ID / Use Face ID")
        public var keyboardAuxiliary: ButtonStyle
    }
    
    public var common: Common
    public var images: Images
    public var buttons: Buttons
    
    
    /// Function provides a fallback theme used internally, for theme initial values.
    public static func fallbackTheme() -> LimeAuthAuthenticationUITheme {
        return LimeAuthAuthenticationUITheme(
            common: Common(
                backgroundColor: .white,
                backgroundImage: nil,
                activityIndicator: .small(.blue),
                keyboardAppearance: .default),
            images: Images(
                logo: nil,
                successImage: .empty,
                failureImage: .empty,
                touchIdIcon: .empty,
                faceIdIcon: .empty),
            buttons: Buttons(
                pinDigits: .noStyle,
                pinAuxiliary: .noStyle,
                ok: .noStyle,
                close: .noStyle,
                keyboardAuxiliary: .noStyle)
        )
    }

}