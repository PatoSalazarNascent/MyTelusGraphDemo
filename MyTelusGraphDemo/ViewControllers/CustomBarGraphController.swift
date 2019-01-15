import Foundation
import UIKit
import Graphs

internal class CustomBarGraphController: UIViewController {
    
    // MARK: Properties
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var simpleBarGraph: BarGraphView!
    
    // MARK: Life Cycle
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBarGraph()
    }

    // MARK: Private Methods
    
    private func initializeBarGraph() {
        
        let verticalAxisConfig = NumericGraphAxisConfig(minValue: 0, maxValue: 8, numberOfSegments: 4, unitOfMeasure: nil, title: "Y Axis: Bill cycle days")
        
        let horizontalAxisConfig = CategoryGraphAxisConfig(categoryValues: ["Pepsi", "Coca Cola", "Fanta", "Sprite", "RC", "Zuko", "Kapo", "Inca"], title: "X Axis: Pop Brands")
        
        let graph = BarGraph(yConfig: verticalAxisConfig, xConfig: horizontalAxisConfig)
        simpleBarGraph.initializeBarGraph(graph: graph, gridType: .vertical)
        simpleBarGraph.setCustomFont(font: UIFont.systemFont(ofSize: 9))
    }
    
    private func addBarData() {
        let dataPoints = [
            BarGraphData(x: "Pepsi", y: 2),
            BarGraphData(x: "Coca Cola", y: 6),
            BarGraphData(x: "Fanta", y: 5),
            BarGraphData(x: "Sprite", y: 4),
            BarGraphData(x: "RC", y: 8)
        ]
        
        simpleBarGraph.drawBars(title: "Bottle by Pop Brand", data: dataPoints, color: UIColor.magenta.withAlphaComponent(0.8), barWidth: 20, withAnimationDuration: 0.5, animationType: .sequence)
    }
}
