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
        
        let dataPoints = [
            LineGraphData(x: 4, y: 0),
            LineGraphData(x: 6, y: 2),
            LineGraphData(x: 6.5, y: 4)
        ]
        
        lineGraph.drawLineChart(data: dataPoints, color: .blue, lineWidth: 1, animated: true)
    }
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let horizontalAxisConfig = LineGraphAxisConfig(minValue: 4, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
        
        let verticalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Days")
        
        let chart = LineGraph(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        lineGraph.initializeLineChart(lineChart: chart, gridType: .fullGrid)
    }
}
