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
import Lottie

class ViewController2: UIViewController {
    var loanTerms:Terms!
    //var loanTerms:Terms = Terms(interest: 2.0, fees: 2222, loanAmount: 1111111, loanDebt: 1111111, income: 0, amortizationMode: AmortizationMode.minimum)
    var timer = Timer()
    let STARTING_FRACTION = 0.5         // Starting place for slider
    let AMORTIZATION_RATE = 0.03

    @IBOutlet weak var lottieView: LOTAnimatedControl!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var slider: Slider!
    @IBOutlet weak var sliderHeight: NSLayoutConstraint!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var debtLab: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    @IBOutlet weak var monthlyCostLabel: UILabel!
    @IBOutlet weak var monthCostConst: NSLayoutConstraint!
    @IBOutlet weak var monthConst: NSLayoutConstraint!
    @IBOutlet weak var valDist: NSLayoutConstraint!
    @IBOutlet weak var textDist: NSLayoutConstraint!
    
    
    
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
        if (modelName.contains("5") || modelName.contains("SE")) {
            debtLabel.font = debtLabel.font.withSize(debtLabel.font.pointSize - 5)
            monthlyCostLabel.font = monthlyCostLabel.font.withSize(monthlyCostLabel.font.pointSize - 5)
            monthlyLabel.font = monthlyLabel.font.withSize(monthlyLabel.font.pointSize - 5)
            debtLab.font = debtLab.font.withSize(debtLab.font.pointSize - 5)
            
            sliderHeight.constant = sliderHeight.constant - 15
            monthConst.constant = monthConst.constant - 15
            monthCostConst.constant = monthCostConst.constant - 15
        }
        else if (modelName == "iPhone 6" || modelName == "iPhone 6s" || modelName == "iPhone 7" || modelName == "iPhone 8" || modelName == "Simulator iPhone 8") {
            valDist.constant = valDist.constant
            textDist.constant = textDist.constant
            monthConst.constant = monthConst.constant - 10
            monthCostConst.constant = monthCostConst.constant - 10
        }
        else if (modelName == "iPhone 6 Plus" || modelName == "iPhone 6s Plus" || modelName == "iPhone 7 Plus" || modelName == "Simulator iPhone 8 Plus") {
            valDist.constant = valDist.constant + 20
            textDist.constant = textDist.constant + 20
            
        }
        else if (modelName.contains("iPhone XS Max")) {
            valDist.constant = valDist.constant + 20
            textDist.constant = textDist.constant + 20
        }
        else if (modelName.contains("iPhone XR")) {
            valDist.constant = valDist.constant + 20
            textDist.constant = textDist.constant + 20
        }
        else{
            valDist.constant = valDist.constant + 20
            textDist.constant = textDist.constant + 20
        }
        
        pieChart.isHidden = true
        
        pieChart.isHidden = true
        
        pieChart.holeColor = pieChart.backgroundColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { //Delay because otherwise the keyboard will not load
            self.scheduledTimerWithTimeInterval()
        }
        
        sliderLimit = whenDebtGone(debt: loanTerms.loanDebt)
        
        pieChart.chartDescription?.text = ""
        pieChart.legend.enabled = false
        amortDataEntry.value = Double(loanTerms.loanDebt)
        amortDataEntry.label = "Amortering"
        
        interestDataEntry.value = Double(loanTerms.interest)
        interestDataEntry.label = "Ränta"
        
        feeDataEntry.value = Double(loanTerms.fees)
        feeDataEntry.label = "Avgifter"
        
        theChart = [amortDataEntry, interestDataEntry, feeDataEntry]
        
        slider.fraction = CGFloat(STARTING_FRACTION)
        changeValues()
        
        lottieView.animationView.setAnimation(named: "confetti.json")
        lottieView.animationView.center = self.view.center
        lottieView.animationView.contentMode = .scaleAspectFill
        lottieView.animationView.animationSpeed = 1.0
        lottieView.animationView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [unowned self] in
            self.lottieView.animationView.isHidden = false
            self.lottieView.animationView.play()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [unowned self] in
            self.pieChart.isHidden = false
        }
        
        //Slider:
        Helper.setSlider(slider: self.slider, sliderLabel: self.label, sliderLimit:self.sliderLimit)
        
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting(){
        pieChart.rotationAngle += 0.25
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
    }
    
    func whenDebtGone(debt:Int) -> Double {
        var tempDebt:Double = Double(debt)
        var tempAmort:Double = 0
        
        var year:Double = 0
        while (tempDebt > 0) {
            tempAmort = AMORTIZATION_RATE * Double(loanTerms.loanAmount)
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
            tempAmort = AMORTIZATION_RATE * Double(loanTerms.loanAmount)
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
        let sliderVal = Double(slider.fraction) * sliderLimit
        let dispValues = calc_monthly_payment(nYears: Int((sliderVal * 1).rounded()/1), debt: loanTerms.loanDebt, interestRate: loanTerms.interest)
        
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
    
    @IBAction func pauseTimerForSlider(_ sender: Any) {
        timer.invalidate()
    }
    @IBAction func resumeTimerForSlider(_ sender: Any) {
        timer.fire()
    }
    
    
    

}

//TODO: Make the tenant fee a user-input.
