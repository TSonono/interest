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
    
    let STARTING_FRACTION = 0.5
    let AMORTIZATION_RATE = 0.03

    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var slider: Slider!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var monthlyCostLabel: UILabel!
    
    
    var interestRate:Double!
    var sliderLimit:Double!
    
    var amortDataEntry = PieChartDataEntry(value: 0)
    var interestDataEntry = PieChartDataEntry(value: 0)
    var feeDataEntry = PieChartDataEntry(value: 0)
    //var chartDataSet = PieChartDataSet(values: nil, label: nil)
    
    var theChart = [PieChartDataEntry]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 9.5, animations : {
            self.slider.fraction += CGFloat(self.STARTING_FRACTION)
        })
        changeValues()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.slider.fraction = 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        interestRate = interest
        sliderLimit = whenDebtGone(debt: loanDebt)
        
        pieChart.chartDescription?.text = ""
        pieChart.legend.enabled = false
        amortDataEntry.value = Double(loanDebt)
        amortDataEntry.label = "Amortering"
        
        interestDataEntry.value = Double(interest)
        interestDataEntry.label = "Ränta"
        
        feeDataEntry.value = fees
        feeDataEntry.label = "Avgifter"
        
        theChart = [amortDataEntry, interestDataEntry, feeDataEntry]
        
        slider.fraction = CGFloat(STARTING_FRACTION)
        changeValues()
        
        //Slider:
        let labelTextAttributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        slider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (Double(fraction) * self.sliderLimit) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: String(Int(sliderLimit)), attributes: labelTextAttributes))
        slider.fraction = 0
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = UIColor(red: 255/255.0, green: 196/255.0, blue: 13/255.0, alpha: 1)
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
        if (amortDataEntry.value == 0){
            chartDataSet.drawValuesEnabled = false
        }
        chartDataSet.valueFormatter = DefaultValueFormatter(decimals:0)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(named: "iosColor"), UIColor(named: "macColor"), UIColor(named: "green")]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
        
        
        //print("amort:", amortDataEntry.value)
        //print("interest:", interestDataEntry.value)
        //print("tenant fee:", feeDataEntry.value)
    }
    
    func whenDebtGone(debt:Int) -> Double {
        var tempDebt:Double = Double(debt)
        var tempAmort:Double = 0
        
        var year:Double = 0
        while (tempDebt > 0) {
            tempAmort = AMORTIZATION_RATE * Double(loanAmount)
            tempDebt -= tempAmort
            year += 1
        }
        return year
    }
    
    func calc_monthly_payment(nYears:Int, debt: Int, interestRate:Double) -> (amortization: Double, interest: Double, resultingDebt: Double){
        var tempDebt:Double = Double(debt)
        var tempAmort:Double = 0
        var tempInterest:Double = 0
        var priorDebt:Double = 0
        
        var year:Int = 0
        while year < nYears + 1 {

            priorDebt = tempDebt
            tempAmort = AMORTIZATION_RATE * Double(loanAmount)  //TODO: Change to something like Double(loanAmount)
            tempInterest = (interestRate/100) * tempDebt
            tempDebt -= tempAmort
            
            year += 1
        }

        return (((tempAmort/12) * 1).rounded()/1, ((tempInterest/12) * 1).rounded()/1, ((priorDebt) * 1).rounded()/1)
    }

    
    @IBAction func sliderMoves(_ sender: Slider) {
        //print(pieChart.rotationAngle)
        changeValues()
    }
    
    func changeValues() {
        let sliderVal = Double(slider.fraction) * sliderLimit
        let dispValues = calc_monthly_payment(nYears: Int((sliderVal * 1).rounded()/1), debt: loanDebt, interestRate: interestRate)
        
        if (dispValues.resultingDebt < 0) {
            amortDataEntry.value = 0
            interestDataEntry.value = 0
            debtLabel.text = "0"
            amortDataEntry.label = ""
            interestDataEntry.label = ""
        }
        else {
            amortDataEntry.value = dispValues.amortization
            interestDataEntry.value = dispValues.interest
            debtLabel.text = String(Int(dispValues.resultingDebt))
            amortDataEntry.label = "Amortering"
            interestDataEntry.label = "Ränta"
        }
        
        
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
