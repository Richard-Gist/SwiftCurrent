//
//  ReplaySubcription.swift
//  SwiftCurrent
//
//  Created by Tyler Thompson on 9/15/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//  

import Combine

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
final class ReplaySubcription<Output, Failure: Error>: Subscription {
    private let downstream: AnySubscriber<Output, Failure>
    private var isCompleted = false
    private var demand: Subscribers.Demand = .none

    init(downstream: AnySubscriber<Output, Failure>) {
        self.downstream = downstream
    }

    func request(_ newDemand: Subscribers.Demand) {
        demand += newDemand
    }

    func cancel() {
        isCompleted = true
    }

    func receive(_ value: Output) {
        guard !isCompleted, demand > 0 else { return }

        demand += downstream.receive(value)
        demand -= 1
    }

    func receive(completion: Subscribers.Completion<Failure>) {
        guard !isCompleted else { return }
        isCompleted = true
        downstream.receive(completion: completion)
    }

    func replay(_ values: [Output], completion: Subscribers.Completion<Failure>?) {
        guard !isCompleted else { return }
        values.forEach { value in receive(value) }
        if let completion = completion { receive(completion: completion) }
    }
}
