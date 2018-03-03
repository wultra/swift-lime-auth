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

public class KeysExchangeViewController: UIViewController, ActivationProcessController {
    
    public var router: (ActivationProcessRouter & KeysExchangeRoutingLogic)!
    public var uiDataProvider: ActivationUIDataProvider!
    
    
    // MARK: - Object lifecycle
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let router = KeysExchangeRouter()
        router.viewController = self
        viewController.router = router
    }
    
    // MARK: - View lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = router?.activationProcess,
            let _ = router?.activationProcess.activationData.activationCode else {
                fatalError("KeysExchangeViewController is not configured properly.")
        }
        
        prepareUI()
        createActivation()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sessionOperation?.cancel()
    }
    
    // MARK: - Routing
    
    public func connect(activationProcess process: ActivationProcess) {
        router?.activationProcess = process
        uiDataProvider = process.uiDataProvider
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router?.prepare(for: segue, sender: sender)
    }
    
    
    // MARK: - Begin activation
    
    private weak var sessionOperation: Operation?
    
    public func createActivation() {
        
        let process = router.activationProcess!
        
        let activationName = UIDevice.current.name
        let activationCode = process.activationData.activationCode ?? ""
        
        sessionOperation = router.activationProcess.session.createActivation(name: activationName, activationCode: activationCode) { [weak self] (result, error) in
            if let result = result {
                self?.router.routeToCreatePassword(with: result)
            } else if let error = error {
                self?.router.routeToError(with: error)
            }
        }
    }
    
    
    // MARK: - Presentation
    
    @IBOutlet weak var pendingActivityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var pendingDescriptionLabel: UILabel?
    
    // MARK: -
    
    open func prepareUI() {
        
        let uiData = uiDataProvider.uiDataForKeysExchange
        
        pendingDescriptionLabel?.text = uiData.strings.pendingActivationTitle

    }
    
}