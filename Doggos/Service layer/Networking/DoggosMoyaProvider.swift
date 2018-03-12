//
//  DoggosMoyaProvider.swift
//  Doggos
//
//  Created by Alexander on 3/16/18.
//  Copyright © 2018 None. All rights reserved.
//

import Moya

class DoggosMoyaProvider<Target: TargetType>: MoyaProvider<Target> {

  override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
                stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                callbackQueue: DispatchQueue? = nil,
                manager: Moya.Manager = MoyaProvider<Target>.defaultAlamofireManager(),
                plugins: [PluginType] = [],
                trackInflights: Bool = false) {

    let pluginsBuilder = NetworkPluginsBuilder()
    let modifiedPlugins = pluginsBuilder.pluginsForBaseProvider(unmodifiedPlugins: plugins)

    super.init(endpointClosure: endpointClosure,
               requestClosure: requestClosure,
               stubClosure: stubClosure,
               callbackQueue: callbackQueue,
               manager: manager,
               plugins: modifiedPlugins,
               trackInflights: trackInflights)
  }
}
