//
//  shousai.swift
//  webapi
//
//  Created by 山口 智生 on 2015/02/26.
//  Copyright (c) 2015年 Tomoki Yamaguchi. All rights reserved.
//

import UIKit
import Social

class shousaiViewController: UIViewController{
    
    var selectedImg: UIImage?
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate //AppDelegateのインスタンスを取得
    
    @IBOutlet weak var shopimageview: UIImageView!
    
    @IBOutlet weak var shopnamelabel: UILabel!
    
    @IBOutlet weak var addresslabel: UITextView!
    
    var myComposeView : SLComposeViewController!
    
    var myTwitterButton: UIButton!
    
    
    @IBAction func tweetbutton(sender: AnyObject) {
        myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        
        // 投稿するテキストを指定.
        myComposeView.setInitialText("\(appDelegate.shopnamelist[appDelegate.selectedid])に行くよ")

        myComposeView.addImage(UIImage(named: "oouchi.jpg"))
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func bu_back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopimageview.image = appDelegate.imgdata[appDelegate.selectedid]
        
        shopnamelabel.text = appDelegate.shopnamelist[appDelegate.selectedid]
        
        addresslabel.text = appDelegate.shopaddresslist[appDelegate.selectedid]
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
