//
//  DoggosAPI.swift
//  Doggos
//
//  Created by Alexander on 3/15/18.
//  Copyright © 2018 None. All rights reserved.
//

import Moya

enum DoggosAPI {
  case loadBreedList
  case loadSubbreedList(breed: String)
  case loadImagesByBreed(breed: String)
  case loadImagesBySubbreed(breed: String, subbreed: String)
}

extension DoggosAPI: TargetType {
  var baseURL: URL { return URL(string: "https://dog.ceo/api")! }

  var path: String {
    switch self {
    case .loadBreedList: return "breeds/list"
    case .loadSubbreedList(let breed): return "breed/\(breed)/list"
    case .loadImagesByBreed(let breed): return "breed/\(breed)/images"
    case .loadImagesBySubbreed(let breed, let subbreed): return "breed/\(breed)/\(subbreed)/images"
    }
  }

  var method: Method {
    switch self {
    case .loadBreedList, .loadSubbreedList, .loadImagesByBreed, .loadImagesBySubbreed:
      return .get
    }
  }

  var sampleData: Data {
    switch self {
    case .loadBreedList:
      return "{\"status\":\"success\",\"message\":[\"affenpinscher\",\"african\",\"airedale\",\"akita\",\"appenzeller\",\"basenji\",\"beagle\"]}".data(using: .utf8) ?? Data()
    case .loadSubbreedList:
      return "{\"status\":\"success\",\"message\":[\"afghan\",\"basset\",\"blood\",\"english\",\"ibizan\",\"walker\"]}".data(using: .utf8) ?? Data()
    case .loadImagesByBreed, .loadImagesBySubbreed:
      return "{\"status\":\"success\",\"message\":[\"https://images.dog.ceo/breeds/hound-basset/n02088238_10005.jpg\",\"https://images.dog.ceo/breeds/hound-basset/n02088238_10013.jpg\",\"https://images.dog.ceo/breeds/hound-basset/n02088238_10028.jpg\",\"https://images.dog.ceo/breeds/hound-basset/n02088238_10049.jpg\"]}".data(using: .utf8) ?? Data()
    }
  }

  var task: Task {
    switch self {
    case .loadBreedList, .loadSubbreedList, .loadImagesByBreed, .loadImagesBySubbreed:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return nil
  }

}
