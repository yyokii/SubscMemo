//
//  Validator.swift
//  SubscMemo
//
//  Created by 東原与生 on 2021/03/18.
//

import SwiftUI
import Combine

protocol Validatable: class {

    associatedtype Subject

    associatedtype Result

    var subject: Subject { get set }

    var cancellables: [AnyCancellable] { get }

    func validate<T>(state: Binding<Result?>, keyPath: KeyPath<Subject, T>, transform: @escaping (T) -> Result?)
}

extension Validatable {

    subscript<T>(keyPath: WritableKeyPath<Subject, T>) -> T {
        get {
            return subject[keyPath: keyPath]
        }
        set {
            self.subject[keyPath: keyPath] = newValue
        }
    }
}

class AnyValidator<Subject, Result>: ObservableObject, Validatable {

    @Published var subject: Subject

    init(_ initialValue: Subject) {
        self.subject = initialValue
    }

    var cancellables: [AnyCancellable] = []

    func validate<T>(state: Binding<Result?>, keyPath: KeyPath<Subject, T>, transform: @escaping (T) -> Result?) {
        $subject
            .map(keyPath)
            .map(transform)
            .receive(on: RunLoop.main)
            .sink { state.wrappedValue = $0 }
            .store(in: &cancellables)
    }
}

struct Validator<Subject, Result, Content>: View where Content: View {

    @State var result: Result?

    var keyPath: WritableKeyPath<Subject, String>

    var validator: ObservedObject<AnyValidator<Subject, Result>>

    var content: (Result?, Binding<String>) -> Content

    var transform: (String) -> Result?

    init(validator: ObservedObject<AnyValidator<Subject, Result>>, keyPath: WritableKeyPath<Subject, String>, @ViewBuilder content: @escaping (Result?, Binding<String>) -> Content, transform: @escaping (String) -> Result?) {
        self.validator = validator
        self.keyPath = keyPath
        self.content = content
        self.transform = transform
    }

    var body: some View {
        content(self.result, self.validator.projectedValue[keyPath])
            .onAppear {
                self.validator.wrappedValue.validate(state: self.$result, keyPath: self.keyPath, transform: self.transform)
            }
    }
}
