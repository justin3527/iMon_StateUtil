//
//  Common.swift
//  iMon_StateUtil
//
//  Created by naver on 2017. 8. 6..
//  Copyright © 2017년 ansi. All rights reserved.
//

import Foundation
import UIKit
class Common{

    var timer : Timer!
    
    
    func startTimer(time:Double, target:Any, selector:Selector){
        timer = Timer.scheduledTimer(timeInterval: time, target: target, selector: selector, userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        timer.invalidate()
    }
    
    func basicAalert(title:String, msg:String, target:Any) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "comfirm", style: .default)
        
        alert.addAction(ok)
         
        (target as! UIViewController).present(alert,animated:true)
    }
    
    func getCurrentDate()->String{
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: now as Date)
    }
}
