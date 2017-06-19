//
//  ViewController.swift
//  ReswiftExample
//
//  Created by Ivan Foong Kwok Keong on 16/6/17.
//  Copyright © 2017 ivanfoong. All rights reserved.
//

import UIKit
import ReSwift
import GradientCircularProgress

public struct MyStyle : StyleProperty {
    /*** style properties **********************************************************************************/
    
    // Progress Size
    public var progressSize: CGFloat = 200
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 18.0
    public var startArcColor: UIColor = UIColor.clear
    public var endArcColor: UIColor = UIColor.orange
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 19.0
    public var baseArcColor: UIColor? = UIColor.darkGray
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont(name: "Verdana-Bold", size: 16.0)
    public var ratioLabelFontColor: UIColor? = UIColor.white
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var messageLabelFontColor: UIColor? = UIColor.white
    
    // Background
    public var backgroundStyle: BackgroundStyles = .dark
    
    // Dismiss
    public var dismissTimeInterval: Double? = 0.0 // 'nil' for default setting.
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}

class ViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    @IBOutlet var usdPriceLabel: UILabel!
    
    let progress = GradientCircularProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainStore.subscribe(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshButtonTapped(button: UIButton) {
        refreshData()
    }
    
    private func refreshData() {
        mainStore.dispatch(APIStartLoading())
    }
    
    private func updateEthPrice(usd: Double) {
        if Thread.isMainThread {
            usdPriceLabel.text = "USD \(usd)"
        } else {
            DispatchQueue.main.async {
                self.usdPriceLabel.text = "USD \(usd)"
            }
        }
    }
    
    private func loadingEthPrice() {
        if Thread.isMainThread {
            usdPriceLabel.text = "Loading..."
        } else {
            DispatchQueue.main.async {
                self.usdPriceLabel.text = "Loading..."
            }
        }
    }
    
    private func failToUpdateEthPrice() {
        if Thread.isMainThread {
            usdPriceLabel.text = "Failed to update"
        } else {
            DispatchQueue.main.async {
                self.usdPriceLabel.text = "Failed to update"
            }
        }
    }
    
    // MARK: - StoreSubscriber
    func newState(state: AppState) {
        if state.isLoading {
            progress.show(message: "Loading...", style: MyStyle())
            loadingEthPrice()
        } else {
            progress.dismiss()
            
            if let usdPrice = state.usdPrice {
                updateEthPrice(usd: usdPrice)
            } else {
                failToUpdateEthPrice()
            }
        }
    }
}


