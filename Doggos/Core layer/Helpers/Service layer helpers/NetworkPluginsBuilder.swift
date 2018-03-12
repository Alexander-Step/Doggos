//
//  NetworkPluginsBuilder.swift
//  Doggos
//
//  Created by Alexander on 3/16/18.
//  Copyright © 2018 None. All rights reserved.
//

import Moya

struct NetworkPluginsBuilder {

  // MARK: - Internal
  func pluginsForBaseProvider(unmodifiedPlugins: [PluginType]) -> [PluginType] {
    var resultPlugins = unmodifiedPlugins
    if !resultPlugins.contains(where: { (plugin) -> Bool in
      plugin is NetworkLoggerPlugin
    }) {
      resultPlugins.append(jsonNetworkLoggerPlugin())
    }
    return resultPlugins
  }

  // MARK: - Private
  private func jsonNetworkLoggerPlugin() -> PluginType {
    return NetworkLoggerPlugin(verbose: true,
                               responseDataFormatter: { (inputData) -> (Data) in
              do {
                let json = try JSONSerialization.jsonObject(with: inputData,
                                                            options: [])
                let resultData = try JSONSerialization.data(withJSONObject: json,
                                                            options: [.prettyPrinted])
                return resultData
              } catch {
                return inputData
              }
    })
  }
}
