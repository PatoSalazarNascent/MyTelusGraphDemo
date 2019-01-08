import Foundation
import UIKit

internal class CustomGraphsViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineGraph: LineGraphView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeLineGraph()
        
        let dataPoints = [
            LineGraphData(x: 4, y: 0),
            LineGraphData(x: 6, y: 2),
            LineGraphData(x: 8, y: 6.5)
        ]
        
        lineGraph.drawLine(data: dataPoints, color: .red, lineWidth: 2, animateWithDuration: 1)
        lineGraph.addGraphFill(data: dataPoints, color: UIColor.purple.withAlphaComponent(0.5), animateWithDuration: 2)
    }
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let horizontalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 30, numberOfSegments: 6, unitOfMeasure: nil, title: "Days")
        
        let verticalAxisConfig = LineGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Data")
    
        
        let graph = LineGraph(xConfig: horizontalAxisConfig, yConfig: verticalAxisConfig)
        lineGraph.initializeLineGraph(lineChart: graph, gridType: .fullGrid)
    }
    
    // MARK: IBAction

    @IBAction func test(_ sender: Any) {

    }
}
