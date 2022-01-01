//
//  ViewController.swift
//  LargeDataPoints
//
//  Created by Farhan Arshad on 31/12/2021.
//  Copyright © 2021 Me. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    

    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var lineChartView: LineChartView!
    let points = [10, 100, 200, 500, 10000, 2000000, 20000, 50000, 5000000, 1000, 100, 3000000]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func plotGraph(_ sender: Any) {
        
        var lineChartEntry = [ChartDataEntry]()
        var dataCollection = [Double]()
        if (number.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            return
        }
        let dataRange: Int = (number.text ?? "0") != "0" ? Int(number.text!)! : Int(0)
        if dataRange < 12 {
            let alert = UIAlertController(title: "Alert", message: "Please enter 12 or more data points", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            for i in 0...(dataRange - 1){
                dataCollection.append(pow(Double(i), Double(2)))
            }
            for i in 0...(12 - 1){
                var averageValue : Double = 0.0
                for j in Int(floor((Double(dataRange / 12 * i))))...Int(floor((Double((dataRange / 12 * i+1)-1)))){
                    averageValue += dataCollection[j]
                }
                averageValue = averageValue / Double((dataRange / 12))
                //let chartEntery = ChartDataEntry(x: Double(i), y: dataCollection[i])
                let chartEntery = ChartDataEntry(x: Double(i), y: averageValue)
                lineChartEntry.append(chartEntery)
            }
            
            let line1 = LineChartDataSet(entries: lineChartEntry, label: "Hello")
            line1.colors = [NSUIColor.blue]
            let data = LineChartData(dataSet: line1)
            lineChartView.data = data
            lineChartView.xAxis.setLabelCount(12, force: true)
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Jan", "Feb", "Mar", "April", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"])
            //lineChartView.setVisibleXRangeMaximum(20)
            lineChartView.chartDescription?.text = "My Data"
        }
    }
    

}


