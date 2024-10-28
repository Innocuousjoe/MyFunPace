import XCTest
@testable import myfunpace

final class stepDetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInstantiation() throws {
        let now = Date()
        let viewModel = StepDetailViewModel(MockPedometerData(steps: 123, date: now, distanceTravelled: 0.123))
        
        XCTAssertTrue(viewModel.stepCount == 123)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        XCTAssertTrue(viewModel.dateString == dateFormatter.string(from:now))
        
        XCTAssertTrue(viewModel.stepAttributedString.string == "123 / 10,000")
    }
}
