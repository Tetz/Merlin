//
//  Network.swift
//  Merlin
//
//  Created by t on 2021/06/11.
//
import Apollo

class Network {
  static let shared = Network()
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://graphql.bitquery.io")!)
}

class NetworkInterceptorProvider: LegacyInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    // Find a better way to store the token
    let token = "BQYrhZi4sO209Sb5A9izE1YGObE8Tffo"
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        
        request.addHeader(name: "X-API-KEY", value: "\(token)")

        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
