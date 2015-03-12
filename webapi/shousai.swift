//
//  shousai.swift
//  webapi
//
//  Created by 山口 智生 on 2015/02/26.
//  Copyright (c) 2015年 Tomoki Yamaguchi. All rights reserved.
//

import UIKit
import Social

class shousaiViewController: UIViewController, UITextViewDelegate {
    
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
        myComposeView.setInitialText("\(appDelegate.activeShopData.name)に行くよ")

        myComposeView.addImage(UIImage(named: "oouchi.jpg"))
        
        // myComposeViewの画面遷移.
        self.presentViewController(myComposeView, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func bu_back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var err: NSError?
        var imageData :NSData = NSData(contentsOfURL: NSURL(string: appDelegate.activeShopData.photourl)!,options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)!;
        shopimageview.image = UIImage(data:imageData)!
        
        //shopimageview.image = appDelegate.imgdata[appDelegate.selectedid]
        
        shopnamelabel.text = appDelegate.activeShopData.name
        addresslabel.text = appDelegate.activeShopData.address
        
        
        
        self.addresslabel.returnKeyType = UIReturnKeyType.Done
        self.addresslabel.delegate = self
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange,
        replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder() //キーボードを閉じる
                return false
            }
            return true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
