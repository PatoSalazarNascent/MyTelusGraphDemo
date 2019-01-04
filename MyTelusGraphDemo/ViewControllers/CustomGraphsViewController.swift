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
        
        let horizontalAxisConfig = LineGraphAxisConfig(minValue: 6, maxValue: 12, numberOfSegments: 3, unitOfMeasure: nil, title: "Data")
        
        let verticalAxisConfig = LineGraphAxisConfig(minValue: 3, maxValue: 7, numberOfSegments: 2, unitOfMeasure: "GB", title: "Days")
        
        let lineChart = LineGraph(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        
        lineGraph.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}
