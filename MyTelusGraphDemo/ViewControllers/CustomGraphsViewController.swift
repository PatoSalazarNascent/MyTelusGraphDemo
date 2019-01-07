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
        
        lineGraph.drawLineChart(data: [
            LineGraphData(x: 4, y: 0),
            LineGraphData(x: 6, y: 2),
            LineGraphData(x: 6.5, y: 4)
        ],
        dataLimit: LineGraphData(x: 6.5, y: 4),
        type: .vertical)
    }
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let horizontalAxisConfig = LineGraphAxisConfig(minValue: 4, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
        
        let verticalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Days")
        
        let lineChart = LineGraph(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        
        lineGraph.initializeLineChart(lineChart: lineChart, gridType: .fullGrid)
    }
}
