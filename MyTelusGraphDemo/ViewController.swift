import UIKit

class ViewController: UIViewController {

    // MARK: IBOutlet
    
    @IBOutlet private weak var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLineChart()
    }
    
    // MARK: Private Method
    
    private func initializeLineChart() {
        
        let xConfig = LineChartAxisConfig(minValue: 1, maxValue: 7, numberOfSegments: 3, unitOfMeasure: nil, title: "Bill Cycle")
        let yConfig = LineChartAxisConfig(minValue: 1, maxValue: 7, numberOfSegments: 3, unitOfMeasure: "GB", title: "Data Used")
        
        let lineChart = LineChart(xConfig: xConfig, yConfig: yConfig)
        
        chartView.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}

