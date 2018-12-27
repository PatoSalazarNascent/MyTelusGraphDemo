import Foundation
import UIKit

internal class ChartView: CustomView {
        
    // MARK: Instance Properties
    
    // MARK: IBOUtlets
    
    @IBOutlet private weak var gridView: GridView!
    @IBOutlet private weak var verticalAxis: UIStackView!
    @IBOutlet private weak var horizontalAxis: UIStackView!
    
    internal override init() {
        super.init()
    }
    
    // only called when built from interface builder
    internal required init?(coder aDecoder: NSCoder) {
        
        // call super constructor
        super.init(coder: aDecoder)
    }
    
    // MARK: Internal Methods
    
    internal func initializeLineChart(lineChart: LineChart, gridType: GridType) {
        
//        gridView.initGrid(xSegmentsCount: lineChart.xConfig.numberOfSegments, ySegmentsCount: lineChart.yConfig.numberOfSegments)
//        gridView.addGrid(gridType)
        
        createHorizontalAxis(horizontalConfig: lineChart.xConfig)
        createVerticalAxis(verticalConfig: lineChart.yConfig)
    }
    
    // MARK Private Methods
    
    private func createHorizontalAxis(horizontalConfig: LineChartAxisConfig) {
        for (index, value) in horizontalConfig.segmentValues.enumerated() {
            
            let horizontalAxisView = HorizontalAxisView()
            
            if index == 0 {
                horizontalAxisView.bind(initValue: "\(horizontalConfig.minValue)\(horizontalConfig.unitOfMeasure ?? "")", value: "\(value)\(horizontalConfig.unitOfMeasure ?? "")")
            }
            else {
                horizontalAxisView.bind(value: "\(value) \(horizontalConfig.unitOfMeasure ?? "")")
            }
            
            horizontalAxis.addArrangedSubview(horizontalAxisView)
        }
    }
    
    
    private func createVerticalAxis(verticalConfig: LineChartAxisConfig) {
        
        for (index, value) in verticalConfig.segmentValues.reversed().enumerated() {
            let verticalAxisView = VerticalAxisView()
            
            if index == verticalConfig.segmentValues.count - 1 {
                verticalAxisView.bind(initValue: "\(verticalConfig.minValue)\(verticalConfig.unitOfMeasure ?? "")", value: "\(value)\(verticalConfig.unitOfMeasure ?? "")")
            }
            else {
                verticalAxisView.bind(value: "\(value)\(verticalConfig.unitOfMeasure ?? "")")
            }
            
            verticalAxis.addArrangedSubview(verticalAxisView)
        }
    }
}
