//
//  shousai.swift
//  webapi
//
//  Created by 山口 智生 on 2015/02/26.
//  Copyright (c) 2015年 Tomoki Yamaguchi. All rights reserved.
//

import UIKit
import CoreLocation

class searchViewController: UIViewController, CLLocationManagerDelegate {
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    var myLocationManager:CLLocationManager!
    
    @IBOutlet weak var textinput: UITextField!
    
    
    @IBAction func determine(sender: AnyObject) {
        let query: String = textinput.text
        let encodedQuery: String = query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        appDelegate.urlstring = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=150d3d7de833b99b&format=json&name=\(encodedQuery)"
        
        println("loadsegue")
        
        performSegueWithIdentifier("search",sender: nil)
    }
    
    @IBAction func aroundsearch(sender: AnyObject) {
        appDelegate.urlstring = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=150d3d7de833b99b&format=json&lat=\(appDelegate.lat)&lng=\(appDelegate.lon)"
        
        println("loadsegue")
        
        performSegueWithIdentifier("search",sender: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 現在地の取得.
        myLocationManager = CLLocationManager()
        
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if(status == CLAuthorizationStatus.NotDetermined) {
            println("didChangeAuthorizationStatus:\(status)");
            
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            self.myLocationManager.requestWhenInUseAuthorization()
        }
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        myLocationManager.distanceFilter = 100

        
        
        myLocationManager.startUpdatingLocation()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        println("didChangeAuthorizationStatus");
        
        // 認証のステータスをログで表示.
        var statusStr = "";
        switch (status) {
        case .NotDetermined:
            statusStr = "NotDetermined"
        case .Restricted:
            statusStr = "Restricted"
        case .Denied:
            statusStr = "Denied"
        case .Authorized:
            statusStr = "Authorized"
        case .AuthorizedWhenInUse:
            statusStr = "AuthorizedWhenInUse"
        }
        println(" CLAuthorizationStatus: \(statusStr)")
    }
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: [AnyObject]!){
        
        appDelegate.lat = manager.location.coordinate.latitude
        appDelegate.lon = manager.location.coordinate.longitude
        
        println("緯度：\(manager.location.coordinate.latitude)")
        println("経度：\(manager.location.coordinate.longitude)")
        
        
    }
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        println("error")
    }
    
    
}
