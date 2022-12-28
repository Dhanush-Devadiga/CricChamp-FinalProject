
import Foundation

struct CricketFilterNewsResultModel : Codable {
    let resultCode : Int?
    let message : String?
    let response : FilterResponseModel?

    enum CodingKeys: String, CodingKey {
        case resultCode = "resultCode"
        case message = "message"
        case response = "response"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resultCode = try values.decodeIfPresent(Int.self, forKey: .resultCode)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        response = try values.decodeIfPresent(FilterResponseModel.self, forKey: .response)
    }
}


struct FilterResponseModel : Codable {
   
    let list: [FilterModel]?
    
    enum CodingKeys: String, CodingKey {
      
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([FilterModel].self, forKey: .list)
    }
}


struct FilterModel: Codable {
    let id : String?
    let data : String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case data = "data"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }
}
