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

internal class DefaultActivationResourcesProvider: ActivationUIProvider, ActivationUIDataProvider {
    
    public lazy var bundle: Bundle = {
        return providedBundle ?? Bundle(for: type(of: self))
    }()
    
    private var providedBundle: Bundle?
    
    public init(bundle: Bundle? = nil) {
        self.providedBundle = bundle
    }
    
    
    // MARK: - LimeAuthActivationUIProvider
    
    public func instantiateInitialScene() -> BeginActivationViewController {
        guard let controller = storyboard.instantiateInitialViewController() as? BeginActivationViewController else {
            fatalError("Cannot instantiate Initial scene")
        }
        return controller
    }
    
    public func instantiateConfirmScene() -> ConfirmActivationViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "Confirm") as? ConfirmActivationViewController else {
            fatalError("Cannot instantiate Confirm scene")
        }
        return controller
    }
    
    public func instantiateScanCodeScene() -> ScanActivationCodeViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "ScanCode") as? ScanActivationCodeViewController else {
            fatalError("Cannot instantiate ScanCode scene")
        }
        return controller
    }
    
    public func instantiateEnterCodeScene() -> EnterActivationCodeViewController {
        guard let controller = storyboard.instantiateViewController(withIdentifier: "EnterCode") as? EnterActivationCodeViewController else {
            fatalError("Cannot instantiate EnterCode scene")
        }
        return controller
    }
    
    public func instantiateNavigationController(with rootController: UIViewController) -> UINavigationController? {
        return UINavigationController(rootViewController: rootController)
    }
    
    public lazy var uiDataProvider: ActivationUIDataProvider = {
        return self
    }()
    
    //
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Activation", bundle: bundle)
    }
    
    // MARK: - LimeAuthActivationUIDataProvider
    
    public var uiCommonStrings: Activation.UIData.CommonStrings {
        return .fallbackStrings()
    }

    public var uiCommonStyle: Activation.UIData.CommonStyle {
        return .fallbackStyle()
    }
    
    public var uiDataForBeginActivation: BeginActivation.UIData {
        return .fallbackData()
    }
    
    public var uiDataForNoCameraAccess: NoCameraAccess.UIData {
        return .fallbackData()
    }
    
    public var uiDataForEnterActivationCode: EnterActivationCode.UIData {
        return .fallbackData()
    }
    
    public var uiDataForScanActivationCode: ScanActivationCode.UIData {
        return .fallbackData()
    }
    
    public var uiDataForKeysExchange: KeysExchange.UIData {
        return .fallbackData()
    }
    
    public var uiDataForEnableBiometry: EnableBiometry.UIData  {
        return .fallbackData()
    }
    
    public var uiDataForConfirmActivation: ConfirmActivation.UIData {
        return .fallbackData()
    }
    
    public var uiDataForSuccessActivation: SuccessActivation.UIData {
        return .fallbackData()
    }
    
    public var uiDataForErrorActivation: ErrorActivation.UIData {
        return .fallbackData()
    }
}

