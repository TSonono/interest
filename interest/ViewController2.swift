//
//  ViewController2.swift
//  interest
//
//  Created by Tofik Sonono on 2018-01-15.
//  Copyright © 2018 Tofik Sonono. All rights reserved.
//

import UIKit
import Charts
import fluid_slider

class ViewController2: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var slider: Slider!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var monthlyCostLabel: UILabel!
    
    
    var interestRate:Double!
    var monthlyInterest:Double!
    var monthlyAmortization:Int!
    var monthlyTenantFee:Int!
    var currentDebt:Int!
    
    var amortDataEntry = PieChartDataEntry(value: 0)
    var interestDataEntry = PieChartDataEntry(value: 0)
    var feeDataEntry = PieChartDataEntry(value: 0)
    
    var theChart = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        interestRate = interest
        //currentDebt =
        //monthlyAmortization = calcAmort()
        //monthlyInterest = calcInterest()
        
        pieChart.chartDescription?.text = ""
        pieChart.legend.enabled = false
        amortDataEntry.value = Double(loanAmount)
        amortDataEntry.label = "Amortization"
        
        interestDataEntry.value = Double(interest)
        interestDataEntry.label = "Interest"
        
        feeDataEntry.value = fees
        feeDataEntry.label = "Fee"
        
        theChart = [amortDataEntry, interestDataEntry, feeDataEntry]
        
        changeValues()
        
        //Slider:
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 40) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "40", attributes: labelTextAttributes))
        slider.fraction = 0
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 153/255.0, green: 180/255.0, blue: 51/255.0, alpha: 1)
        slider.valueViewColor = .white
        slider.didBeginTracking = { [weak self] _ in
            self?.setLabelHidden(true, animated: true)
        }
        slider.didEndTracking = { [weak self] _ in
            self?.setLabelHidden(false, animated: true)
        }
        
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(values: theChart, label: nil)
        chartDataSet.valueFormatter = DefaultValueFormatter(decimals:0)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "iosColor"), UIColor(named: "macColor"), UIColor(named: "yellow")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
        
        
        print("amort:", amortDataEntry.value)
        print("interest:", interestDataEntry.value)
        print("tenant fee:", feeDataEntry.value)
    }
    
    func calc_monthly_payment(nYears:Int, loanAmount: Int, interestRate:Double) -> (amortization: Double, interest: Double, resultingDebt: Double){
        var tempDebt:Double = Double(loanAmount)
        var tempAmort:Double = 0
        var tempInterest:Double = 0
        var priorDebt:Double = 0
        
        var year:Int = 0
        while year < nYears + 1 {

            priorDebt = tempDebt
            tempAmort = 0.03 * Double(loanAmount)  //TODO: Change to something like Double(loanAmount)
            tempInterest = (interestRate/100) * tempDebt
            tempDebt -= tempAmort
            
            year += 1
        }
        
        return (((tempAmort/12) * 1).rounded()/1, ((tempInterest/12) * 1).rounded()/1, ((priorDebt) * 1).rounded()/1)
    }

    
    @IBAction func sliderMoves(_ sender: Slider) {
        changeValues()
    }
    
    func changeValues() {
        let sliderVal = Double(slider.fraction) * 40
        let dispValues = calc_monthly_payment(nYears: Int((sliderVal * 1).rounded()/1), loanAmount: loanAmount, interestRate: interestRate)
        
        amortDataEntry.value = dispValues.amortization
        interestDataEntry.value = dispValues.interest
        
        debtLabel.text = String(Int(dispValues.resultingDebt))
        monthlyCostLabel.text = String(Int(amortDataEntry.value + interestDataEntry.value + feeDataEntry.value))
        
        updateChartData()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setLabelHidden(_ hidden: Bool, animated: Bool) {
        let animations = {
            self.label.alpha = hidden ? 0 : 1
        }
        if animated {
            UIView.animate(withDuration: 0.11, animations: animations)
        } else {
            animations()
        }
    }
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//TODO: Make the tenant fee a user-input.
