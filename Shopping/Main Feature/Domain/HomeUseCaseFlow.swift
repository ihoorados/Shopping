//
//  HomeUseCaseFlow.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 19/5/2022.
//

import Foundation

final class HomeUseCaseFlow<Delegate:HomeUseCase> {

    private let delegate: Delegate

    init(delegate: Delegate) {

        print("🟦 HomeUseCaseFlow: init.")
        self.delegate = delegate
    }

    deinit{

        print("🗑 HomeUseCaseFlow: deinit.")
    }

    func start() {

        self.delegate.startHome()
    }

}
