//
//  ViewController.swift
//  iMon_StateUtil
//
//  Created by naver on 2017. 7. 12..
//  Copyright © 2017년 ansi. All rights reserved.
//

import UIKit
import Charts

class ResourceViewController: UIViewController {
    //CPU Label
    @IBOutlet var cpu0_Lbl : UILabel!
    @IBOutlet var cpu1_Lbl : UILabel!
    
    //CPU progress
    @IBOutlet var cpu0_progress : UIProgressView!
    @IBOutlet var cpu1_progress : UIProgressView!
    
    //Traffics Label
    @IBOutlet var wifi_Lbl : UILabel!
    @IBOutlet var cellular_Lbl : UILabel!
    @IBOutlet var local_Lbl : UILabel!
    
    //memory Label
    @IBOutlet var physical_Lbl : UILabel!
    @IBOutlet var user_Lbl : UILabel!
    @IBOutlet var used_Lbl : UILabel!
    @IBOutlet var total_Lbl : UILabel!
    
    var isChartView = false
    var chartView:UIView!
    var frame:CGRect!
    var myChart:ChartsGraph!
    override func viewDidLoad() {
        self.getResource()
        self.setResourceDataToLabel()
        super.viewDidLoad()
        
        let width = self.view.frame.width/2
        let height = self.view.frame.height/2
        frame = CGRect(x: width - height/2, y: height - height/2, width: height, height: height)
        myChart = ChartsGraph(self.frame)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getResource(){
        getCPU()
        getTraffic()
        getMemory()
    }
    
    func setResourceDataToLabel(){
        //set CPU data
        cpu0_Lbl.text = String(currentCPU.core0)
        cpu1_Lbl.text = String(currentCPU.core1)
        cpu0_progress.progress = currentCPU.core0 * 0.01
        cpu1_progress.progress = currentCPU.core1 * 0.01
        
        //set Traffics  data
        wifi_Lbl.text = String(format:"%d / %d KB", currentWiFi.rx - currentWiFi.rxFirst, currentWiFi.tx - currentWiFi.txFirst)
        cellular_Lbl.text = String(format:"%d / %d KB", currentCell.rx - currentCell.rxFirst, currentCell.tx - currentCell.txFirst)
        local_Lbl.text = String(format:"%d / %d KB", currentLocal.rx - currentLocal.rxFirst, currentLocal.tx - currentLocal.txFirst)
        
        //set memory data
        physical_Lbl.text = String(format:"%.1f% %MB", currentMemory.physical / 1024)
        user_Lbl.text =  String(format:"%.1f% %MB", currentMemory.user / 1024)
        used_Lbl.text = String(format:"%.1f% %MB", currentMemory.used)
        total_Lbl.text = String(format:"%.1f% %MB", currentMemory.total)
    }
    func reverseTuples(_ tuples: [(Int, Int)]) -> [(Int, Int)] {
        return tuples.map{($0.1, $0.0)}
    }
    
    @IBAction func openCPUGraphView(){
       
        if !isChartView{
            
            let datas = [Double(currentCPU.core0),Double(currentCPU.core1)]
            let labels = ["CPU #0","CPU #1"]
            let barView = myChart.setBarGraphView(datas: datas, labels: labels)
            
            barView.leftAxis.axisMinimum = 0
            barView.leftAxis.axisMaximum = 100
            
            
            self.view.addSubview(barView)
            self.chartView = barView
            self.isChartView = true
        }
        else{
            chartView.removeFromSuperview()
            self.isChartView = false
        }
        
        
    }
    
    @IBAction func openTrafficsGraphView(){
        if !isChartView{
            
            let datas = [Double(currentWiFi.rx),Double(currentWiFi.tx),Double(currentCell.rx),Double(currentCell.tx),Double(currentLocal.rx),Double(currentLocal.tx)]
            let labels = ["WI-FI(Rx/Tx)","Cellular(Rx/Tx)","Local(Rx/Tx)"]
            let barView = myChart.setBarGraphView(datas: datas, labels: labels, groupEntryCount: 2)
            
            
            self.view.addSubview(barView)
            self.chartView = barView
            self.isChartView = true
        }
        else{
            chartView.removeFromSuperview()
            self.isChartView = false
        }
    }
    
    @IBAction func openMemoryGraphView(){
        
        if !isChartView{
            
            let datas = [currentMemory.free, currentMemory.active, currentMemory.inactive, currentMemory.wired]
            let labels = ["free","active","inactive","wired"]
            let pieView = myChart.setPieGraphView(datas: datas, labels: labels)
            
            self.view.addSubview(pieView)
            self.chartView = pieView
            self.isChartView = true
        }
        else{
            chartView.removeFromSuperview()
            self.isChartView = false
        }
    }

    
    
    @IBAction func refresh(){
        self.getResource()
        self.setResourceDataToLabel()
    }
    



}

