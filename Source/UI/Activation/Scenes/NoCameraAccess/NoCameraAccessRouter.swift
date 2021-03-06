//
// Copyright 2018 Wultra s.r.o.
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

public protocol NoCameraAccessRoutingLogic {
    func routeToPreviousScene()
    func routeToSystemSettings()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

public class NoCameraAccessRouter: NoCameraAccessRoutingLogic, ActivationUIProcessRouter {
    
    public var activationProcess: ActivationUIProcess!
    public weak var viewController: NoCameraAccessViewController?
    
    public func routeToPreviousScene() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    public func routeToSystemSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // empty
    }
}
