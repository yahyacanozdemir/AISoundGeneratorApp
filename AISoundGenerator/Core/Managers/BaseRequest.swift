//
//  BaseRequest.swift
//  MyBaseApp
//
//  Created by Yahya Can Özdemir on 2.11.2024.
//

import Alamofire

// MARK: - Request

struct BaseRequest {

  // MARK: Lifecycle

  init(
    endpoint: Endpoint,
    method: HTTPMethod = .get,
    parameters: [String: Any]? = nil,
    parameterType: ParameterType? = nil,
    contentType: ContentType = .json)
//    isShowProgressAllowed: Bool = true,
//    isAutoErrorMessageAllowed: Bool = true,
//    isSnackBarErrorMessage: Bool = false,
//    isPopupErrorMessage: Bool = true,
  {
    self.endpoint = endpoint
    self.method = method
    self.parameters = parameters
    self.parameterType = parameterType
    self.contentType = contentType
//    self.isShowProgressAllowed = isShowProgressAllowed
//    self.isAutoErrorMessageAllowed = isAutoErrorMessageAllowed
//    self.isSnackBarErrorMessage = isSnackBarErrorMessage
//    self.isPopupErrorMessage = isPopupErrorMessage
  }

  // MARK: Internal

  var endpoint: Endpoint
  var method: HTTPMethod
  var parameters: [String: Any]?
  var parameterType: ParameterType?
  var contentType: ContentType
//  var isShowProgressAllowed: Bool
//  var isAutoErrorMessageAllowed: Bool
//  var isSnackBarErrorMessage: Bool
//  var isPopupErrorMessage: Bool
}

enum ParameterType {
    case url
    case body
}

enum ContentType: String {
    case json = "application/json"
    case formURLEncoded = "application/x-www-form-urlencoded"
}
