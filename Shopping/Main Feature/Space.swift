//
//  Space.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

public final class Shopping {

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Dependency Injection
    /* ////////////////////////////////////////////////////////////////////// */

    private var flow: Any
    private init(flow: Any) {

        self.flow = flow
        print("🟦 Shopping: \(self.flow) init.")
    }

    deinit {
        print("🗑 Shopping: \(self.flow) deinit.")
    }

    /* ////////////////////////////////////////////////////////////////////// */
    // MARK: Static Functions
    /* ////////////////////////////////////////////////////////////////////// */

    /// Start NMap Home Sapce
    static func startSpace<Delegate: HomeUseCase>(
        delegate: Delegate
    ) -> Shopping{

        // Composition NMap Flow
        let flow = HomeUseCaseFlow(delegate: delegate)
        flow.start()
        return Shopping(flow: flow)
    }

}
