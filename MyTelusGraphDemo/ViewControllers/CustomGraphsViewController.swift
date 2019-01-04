import Foundation
import UIKit

internal class CustomGraphsViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineGraph: ChartView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLineGraph()
        
    }
    
    // MARK: Internal Methods
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let horizontalAxisConfig = LineChartAxisConfig(minValue: 2, maxValue: 14, numberOfSegments: 2, unitOfMeasure: nil, title: "Data")
        
        let verticalAxisConfig = LineChartAxisConfig(minValue: 0, maxValue: 14, numberOfSegments: 2, unitOfMeasure: "GB", title: "Days")
        
        let lineChart = LineChart(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        
        lineGraph.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}
