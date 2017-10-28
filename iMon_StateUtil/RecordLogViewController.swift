//
//  RecordLogViewController.swift
//  iMon_StateUtil
//
//  Created by naver on 2017. 7. 30..
//  Copyright © 2017년 ansi. All rights reserved.
//

import Foundation
import UIKit
import Charts

class RecordLogViewController : UIViewController{

    @IBOutlet var playBtn : UIButton!
    @IBOutlet var stopBtn : UIButton!
    @IBOutlet var timeLabel : UILabel!
    @IBOutlet var graphView : UIView!

    let common = Common()
    let saveLog = SaveLog()
    var myChart:ChartsGraph!
    var lineChart : LineChartView!
    var graphType = 0
    var fileName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        stopBtn.isEnabled = false
        let width = self.view.frame.width/2
        let height = self.view.frame.height/2
        let frame = CGRect(x: width - height/2, y: height - height/2, width: height, height: height)
        myChart = ChartsGraph(frame)
        let lineView = myChart.baseLineGraph()        
        self.view.addSubview(lineView)
        self.lineChart = lineView
    }
    
    @IBAction func playRecordLog(){
        
        let alert = UIAlertController(title: "Input Log File Name", message: "Input Log File Name", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "FileName"
        })
        
        
        let okBtn = UIAlertAction(title: "Start", style: .default){
        (_) in
            self.fileName = (alert.textFields?[0].text)!
            self.playBtn.isEnabled = false
            self.stopBtn.isEnabled = true
            
            self.common.startTimer(time: 1, target: self, selector: #selector(self.recordingLog))
            self.saveLog.startRecord()
            self.lineChart.backgroundColor = UIColor.darkGray
            self.view.addSubview(self.lineChart)
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(okBtn)
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func stopRecordLog(){
        playBtn.isEnabled = true
        stopBtn.isEnabled = false
        common.stopTimer()
        saveLog.resetRecordTime()
        self.timeLabel.text = saveLog.getRunningTime()
        saveLog.saveLogToCSV(fileName : self.fileName)
    }
    
    func recordingLog(){
        saveLog.recording()
        self.timeLabel.text = saveLog.getRunningTime()
        self.refreshChart()
    }
    
    func refreshChart(){
        var datas:[[Double]] = []
        var labels:[String] = []
        var colors:[UIColor] = []
        switch self.graphType {
        case 0:
            datas = saveLog.getRecordCPU()
            labels = ["CORE0","CORE1"]
            colors =  [UIColor.cyan, UIColor.brown]
        case 1 :
            datas = saveLog.getRecordTraffic()
            labels = ["Wifi_Rx","Wifi_Tx","Cell_Rx","Cell_Tx","Local_Rx","Local_Tx"]
            colors =  [UIColor.cyan, UIColor.brown, UIColor.black, UIColor.green, UIColor.red, UIColor.purple]
        case 2 :
            datas = saveLog.getRecordMem()
            labels = ["Total","Wire","Active","Inactive","Free","User"]
            colors =  [UIColor.cyan, UIColor.brown, UIColor.black, UIColor.green, UIColor.red, UIColor.purple]
        default:
            break
        }
        
        self.lineChart.data = myChart.setLineGraphData(datas: datas, labels: labels , colors: colors)
        
    }
    
    @IBAction func changeGraphType(sender : UISegmentedControl){
        self.graphType = sender.selectedSegmentIndex
        self.refreshChart()
    }
    
    
    
    
}
