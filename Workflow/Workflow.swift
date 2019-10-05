//
//  Workflow.swift
//  Workflow
//
//  Created by Tyler Thompson on 8/26/19.
//  Copyright © 2019 Tyler Tompson. All rights reserved.
//

import Foundation

public class Workflow: LinkedList<AnyFlowRepresentable.Type> {
    
    internal var instances:LinkedList<AnyFlowRepresentable?> = []
    internal var presenter:AnyPresenter?

    public var firstLoadedInstance:LinkedList<AnyFlowRepresentable?>.Node<AnyFlowRepresentable?>?
    
    override init(_ node: Element?) {
        super.init(node)
    }
    
    deinit {
        removeInstances()
        presenter = nil
    }
    
    public func applyPresenter(_ presenter:AnyPresenter) {
        self.presenter = presenter
    }
    
    public func launch(from: Any?, with args:Any?, withLaunchStyle launchStyle:PresentationType = .default, onFinish:((Any?) -> Void)? = nil) -> LinkedList<AnyFlowRepresentable?>.Node<AnyFlowRepresentable?>? {
        #if DEBUG
        if (NSClassFromString("XCTest") != nil) {
            NotificationCenter.default.post(name: .workflowLaunched, object: [
                "workflow" : self,
                "launchFrom": from,
                "args": args,
                "style": launchStyle,
                "onFinish": onFinish
            ])
        }
        #endif
        removeInstances()
        instances.append(contentsOf: map { _ in nil })
        _ = first?.traverse { node in
            var flowRepresentable = node.value.instance()
            flowRepresentable.workflow = self
            let shouldLoad = flowRepresentable.erasedShouldLoad(with: args)
            defer {
                if (shouldLoad) {
                    let position = node.position
                    instances.replace(atIndex: position, withItem: flowRepresentable)
                    firstLoadedInstance = instances.first?.traverse(position)
                    if let firstLoadedInstance = firstLoadedInstance {
                        self.setupCallbacks(for: firstLoadedInstance, onFinish: onFinish)
                    }
                }
            }
            return shouldLoad
        }
        guard let first = firstLoadedInstance else {
            return nil
        }
        presenter?.launch(view: first.value, from: from, withLaunchStyle: launchStyle)
        return firstLoadedInstance
    }
    
    public func abandon(animated:Bool = true, onFinish:(() -> Void)? = nil) {
        presenter?.abandon(self, animated:animated) {
            self.removeInstances()
            self.firstLoadedInstance = nil
            self.presenter = nil
            onFinish?()
        }
    }
    
    private func removeInstances() {
        instances.forEach { $0.value?.callback = nil }
        instances.removeAll()
        self.firstLoadedInstance = nil
    }
    
    private func replaceInstance(atIndex index:Int, withInstance instance:AnyFlowRepresentable?) {
        instances.replace(atIndex: index, withItem: instance)
    }

    private func setupCallbacks(for node:LinkedList<AnyFlowRepresentable?>.Node<AnyFlowRepresentable?>, onFinish:((Any?) -> Void)?) {
        node.value?.callback = { args in
            var argsToPass = args
            let nextNode = node.next?.traverse {
                let index = $0.position
                var instance = self.first?.traverse(index)?.value.instance()
                instance?.callback = $0.value?.callback
                instance?.workflow = self
                
                let hold = instance?.callback
                defer {
                    instance?.callback = hold
                    self.replaceInstance(atIndex: index, withInstance: instance)
                }
                
                instance?.callback = { argsToPass = $0 }
                
                return instance?.erasedShouldLoad(with: argsToPass) == true
            }

            guard let nodeToPresent = nextNode,
                  let instanceToPresent = self.instances.first?.traverse(nodeToPresent.position)?.value else {
                onFinish?(args)
                return
            }
            
            self.setupCallbacks(for: nodeToPresent, onFinish: onFinish)
            
            self.presenter?.launch(view: instanceToPresent,
                                   from: self.instances.first?.traverse(node.position)?.value,
                                   withLaunchStyle: instanceToPresent.preferredLaunchStyle)
        }
    }
}