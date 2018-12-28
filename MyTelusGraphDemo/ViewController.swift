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
        
        chartView.drawLineChart(data: [
            LineChartData(x: 0, y: 0),
            LineChartData(x: 4, y: 2),
            LineChartData(x: 8, y: 4),
            LineChartData(x: 12, y: 2),
            LineChartData(x: 16, y: 6),
        ])
    }
    
    // MARK: Private Method
    
    private func initializeLineChart() {
        
        let xConfig = LineChartAxisConfig(minValue: 0, maxValue: 16, numberOfSegments: 4, unitOfMeasure: nil, title: "Bill Cycle")
        let yConfig = LineChartAxisConfig(minValue: 0, maxValue: 6, numberOfSegments: 3, unitOfMeasure: "GB", title: "Data Used")
        
        let lineChart = LineChart(xConfig: xConfig, yConfig: yConfig)
        
        chartView.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}

