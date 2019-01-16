import Foundation
import UIKit
import Graphs

internal class CustomLineGraphViewController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    @IBOutlet private weak var lineGraph: LineGraphView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        // LINE GRAPH
        initializeLineGraph()
    }
    
    // MARK: Private Methods
    
    private func initializeLineGraph() {
        
        let verticalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Y Axis: Your usage")
        
        let horizontalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 30, numberOfSegments: 6, unitOfMeasure: nil, title: "X Axis: Bill cycle days")
        
        let graph = LineGraph(yConfig: verticalAxisConfig, xConfig: horizontalAxisConfig)
        lineGraph.initializeLineGraph(graph, gridType: .vertical)
    }
    
    private func addLineGraphData() {
        let dataPoints = [
            LineGraphData(x: 4, y: 0),
            LineGraphData(x: 6, y: 2),
            LineGraphData(x: 8, y: 6.5),
            LineGraphData(x: 20, y: 8),
            LineGraphData(x: 30, y: 8)
        ]
        
        let dataPoints2 = [
            LineGraphData(x: 4, y: 0),
            LineGraphData(x: 20, y: 8),
            LineGraphData(x: 30, y: 8)
        ]
        
        lineGraph.drawLine(title: "First Data", data: dataPoints, color: .red, lineWidth: 2)
        lineGraph.drawLine(title: "Second Data", data: dataPoints2, color: .cyan, lineWidth: 2, animateWithDuration: 1)
    }
    
    // MARK: IBAction

    @IBAction func test(_ sender: Any) {

    }
}
