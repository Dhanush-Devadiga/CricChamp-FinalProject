
import Foundation

protocol ViewModelProtocol {
    func showFilterData(model: FilterResponseModel?)
}

class ViewModel {
   
    var view: ViewModelProtocol?
    
    init(_ view: ViewModelProtocol) {
        self.view = view
    }
    
    func getFilterModelMockData() {
        let responseJsonModel = CricketFilterNewsResultModel.fromJSON(jsonFile: "filterFile") as CricketFilterNewsResultModel?
        self.view?.showFilterData(model: responseJsonModel?.response)
    }
}

