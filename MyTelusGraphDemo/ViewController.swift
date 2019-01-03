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
        
        let xConfig = LineChartAxisConfig(minValue: 2, maxValue: 6, numberOfSegments: 2, unitOfMeasure: nil, title: "Bill Cycle")
        let yConfig = LineChartAxisConfig(minValue: 2, maxValue: 6, numberOfSegments: 2, unitOfMeasure: "GB", title: "Data Used")
        
        let lineChart = LineChart(xConfig: xConfig, yConfig: yConfig)
        
        chartView.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}

