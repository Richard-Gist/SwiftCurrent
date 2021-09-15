//
//  ReplaySubject.swift
//  SwiftCurrent
//
//  Created by Tyler Thompson on 9/15/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//  

import Combine
import Foundation

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
final class ReplaySubject<Output, Failure: Error>: Subject {
    private var buffer = [Output]()
    private var subscriptions = [ReplaySubcription<Output, Failure>]()
    private var completion: Subscribers.Completion<Failure>?
    private let lock = NSRecursiveLock()
    var lastKnownValue: Output? {
        buffer.last
    }

    func receive<Downstream: Subscriber>(subscriber: Downstream) where Downstream.Failure == Failure, Downstream.Input == Output {
        lock.lock(); defer { lock.unlock() }
        let subscription = ReplaySubcription<Output, Failure>(downstream: AnySubscriber(subscriber))
        subscriber.receive(subscription: subscription)
        subscriptions.append(subscription)
        subscription.replay(buffer, completion: completion)
    }

    func send(subscription: Subscription) {
        lock.lock(); defer { lock.unlock() }
        subscription.request(.unlimited)
    }

    func send(_ value: Output) {
        lock.lock(); defer { lock.unlock() }
        buffer.append(value)
        subscriptions.forEach { $0.receive(value) }
    }

    func send(completion: Subscribers.Completion<Failure>) {
        lock.lock(); defer { lock.unlock() }
        self.completion = completion
        subscriptions.forEach { subscription in subscription.receive(completion: completion) }
    }
}
