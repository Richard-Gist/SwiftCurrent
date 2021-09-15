//
//  WorkflowViewModel.swift
//  SwiftCurrent_SwiftUI
//
//  Created by Megan Wiemer on 7/13/21.
//  Copyright © 2021 WWT and Tyler Thompson. All rights reserved.
//

import SwiftCurrent
import SwiftUI
import Combine

class Event {
    var value: AnyWorkflow.Element
    var seenBy = [AnyWorkflow.Element]()

    init(value: AnyWorkflow.Element) {
        self.value = value
    }
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
final class WorkflowViewModel: ObservableObject {
    @Published var body: AnyWorkflow.Element?
    let onAbandonPublisher = PassthroughSubject<Void, Never>()
    let onFinishPublisher = CurrentValueSubject<AnyWorkflow.PassedArgs?, Never>(nil)
    let onProceedPublisher = CurrentValueSubject<AnyWorkflow.Element?, Never>(nil)
    let onBackUpPublisher = PassthroughSubject<AnyWorkflow.Element, Never>()

    var approvers = [AnyWorkflow.Element]()
    var events = [Event]()
    func getEvents(for element: AnyWorkflow.Element?) -> [Event] {
        guard let element = element else { return events }
        let debugEvents = events.filter { !$0.seenBy.contains(where: { $0 === element }) }
        return debugEvents
    }

    @Binding var isLaunched: Bool
    private let launchArgs: AnyWorkflow.PassedArgs

    init(isLaunched: Binding<Bool>, launchArgs: AnyWorkflow.PassedArgs) {
        _isLaunched = isLaunched
        self.launchArgs = launchArgs
    }
}

@available(iOS 14.0, macOS 11, tvOS 14.0, watchOS 7.0, *)
extension WorkflowViewModel: OrchestrationResponder {
    func launch(to destination: AnyWorkflow.Element) {
        onFinishPublisher.send(nil) // We launched, so make sure nobody thinks we finished yet.
        events.append(Event(value: destination))
        body = destination
    }

    func proceed(to destination: AnyWorkflow.Element, from source: AnyWorkflow.Element) {
        events.append(Event(value: destination))
        body = destination
        onProceedPublisher.send(destination)
    }

    func backUp(from source: AnyWorkflow.Element, to destination: AnyWorkflow.Element) {
        body = destination
        onBackUpPublisher.send(source)
    }

    func abandon(_ workflow: AnyWorkflow, onFinish: (() -> Void)?) {
        isLaunched = false
        body = nil
        onAbandonPublisher.send()
        if isLaunched == true {
            workflow.launch(withOrchestrationResponder: self, passedArgs: launchArgs)
        }
    }

    func complete(_ workflow: AnyWorkflow, passedArgs: AnyWorkflow.PassedArgs, onFinish: ((AnyWorkflow.PassedArgs) -> Void)?) {
        if workflow.lastLoadedItem?.value.metadata.persistence == .removedAfterProceeding {
            if let lastPresentableItem = workflow.lastPresentableItem {
                body = lastPresentableItem
            } else {
                isLaunched = false
            }
        }
        onFinishPublisher.send(passedArgs)
        onFinish?(passedArgs)
    }
}

extension AnyWorkflow {
    fileprivate var lastLoadedItem: AnyWorkflow.Element? {
        last { $0.value.instance != nil }
    }

    fileprivate var lastPresentableItem: AnyWorkflow.Element? {
        last {
            $0.value.instance != nil && $0.value.metadata.persistence != .removedAfterProceeding
        }
    }
}
