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
            LineGraphData(x: 0, y: 0),
            LineGraphData(x: 2, y: 1),
            LineGraphData(x: 8, y: 9)
        ])
    }
    
  
    
    // MARK: Internal Methods
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let horizontalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 16, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
        
        let verticalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 24, numberOfSegments: 4, unitOfMeasure: "GB", title: "Days")
        
        let lineChart = LineGraph(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        
        lineGraph.initializeLineChart(lineChart: lineChart, gridType: .horizontal)
    }
}
