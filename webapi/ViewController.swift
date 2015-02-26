//
//  ViewController.swift
//  webapi
//
//  Created by 山口 智生 on 2015/02/24.
//  Copyright (c) 2015年 Tomoki Yamaguchi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    var myLocationManager:CLLocationManager!
    
    var timer : NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 現在地の取得.
        myLocationManager = CLLocationManager()
        
        myLocationManager.delegate = self
        
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        
        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if(status == CLAuthorizationStatus.) {
            println("didChangeAuthorizationStatus:\(status)");
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            self.myLocationManager.requestWhenInUseAuthorization()
        }
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        myLocationManager.distanceFilter = 100
        
        myLocationManager.startUpdatingLocation()
        
        
        var text = "モスバーガー"
        let keyword:String! = text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        
        var url: NSURL = NSURL(string:"http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=3d7b9b87e2cdb691&format=json&name=\(keyword)")!
        var myRequest = NSMutableURLRequest(URL:  url)
        myRequest.HTTPMethod = "GET"
        
        // use NSURLSession
        var task = NSURLSession.sharedSession().dataTaskWithRequest(myRequest, completionHandler: { data, response, error in
            if (error == nil) {
                //var result = NSString(data: data, encoding: NSUTF8StringEncoding)!
                //println(result)
                let json = JSON(data: data)
                for i in 0...5{
                    if let stringdata = json["results"]["shop"][i]["name"].string{
                        println(stringdata)
                    }
                }
            } else {
                println(error)
            }
        })
        task.resume()
        
        //タイマーを作る.
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        
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
        
        // 緯度・経度の表示.
        //myLatitudeLabel.text = "緯度：\(manager.location.coordinate.latitude)"
        //myLatitudeLabel.textAlignment = NSTextAlignment.Center
        
        //myLongitudeLabel.text = "経度：\(manager.location.coordinate.longitude)"
        //myLongitudeLabel.textAlignment = NSTextAlignment.Center
        
        
        //self.view.addSubview(myLatitudeLabel)
        //self.view.addSubview(myLongitudeLabel)
        
        println("緯度：\(manager.location.coordinate.latitude)")
        println("経度：\(manager.location.coordinate.longitude)")
        
        
        
    }
    
    // 位置情報取得に失敗した時に呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
        println("error")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {//画面遷移する
        if timer.valid == true {
            //timerを破棄する.
            timer.invalidate()
        }
    }
    
    override func viewWillAppear(animated: Bool) {//画面遷移してくる
    }
    
    func onUpdate(timer : NSTimer){
        println("count")
    }


}

