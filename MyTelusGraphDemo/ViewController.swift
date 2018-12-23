import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlet
    
    @IBOutlet private weak var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initializeLineChart()
    }
    
    // MARK: Private Method
    
    private func initializeLineChart() {
        
        let xConfig = LineChartAxisConfig(minValue: 0, maxValue: 30, numberOfSegments: 7, unitOfMeasure: nil, title: "Bill Cycle")
        let yConfig = LineChartAxisConfig(minValue: 0, maxValue: 6, numberOfSegments: 6, unitOfMeasure: "GB", title: "Data Used")
        
        let lineChart = LineChart(xConfig: xConfig, yConfig: yConfig)
        
        chartView.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}

