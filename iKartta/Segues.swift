//
//  SwiftUIView.swift
//  iKartta
//
//  Created by Juan Bravo on 22.6.2022.
//

import SwiftUI

public enum SegueType {
    case push,
         modal,
         popover(PopoverAttachmentAnchor, Edge)
}


public struct Segue<Destination, Selection>: ViewModifier
where Destination: View, Selection: Hashable {
    let type: SegueType
    // Trigger this segue when selection is set to this value
    let tag: Selection
    // Trigger binding
    @Binding var selection: Selection?
    // View shown then segue triggered
    @ViewBuilder let destination: () -> Destination
    
    public init(type: SegueType,
                tag: Selection,
                selection: Binding<Selection?>,
                @ViewBuilder destination: @escaping () -> Destination) {
        self.type = type
        self.tag = tag
        _selection = selection
        self.destination = destination
    }
    
    public func body(content: Content) -> some View {
        // Build segue based on type
        switch type {
        case .push:
            pushSegue(content)
        case .modal:
            modalSegue(content)
        case let .popover(anchor, arrowEdge):
            popoverSegue(content, anchor: anchor, arrowEdge: arrowEdge)
        }
    }
    
    @ViewBuilder private func pushSegue(_ content: Content) -> some View {
        // Push segue requires a NavigationLink, using a Group instead of a ZStack does not work
        ZStack {
            content
            NavigationLink(tag: tag,
                           selection: $selection,
                           destination: destination) {
                EmptyView()
            }
        }
    }
    
    @ViewBuilder private func modalSegue(_ content: Content) -> some View {
        if #available(iOS 14.0, *) {
            // Modal in this case is a fullScreenCover
            content
                .fullScreenCover(isPresented: Binding(get: {
                    selection == tag
                }, set: { _ in
                    selection = nil
                }),
                                 onDismiss: nil,
                                 content: destination)
        } else {
            // TODO: handle this part
        }
    }
    
    @ViewBuilder private func popoverSegue(_ content: Content, anchor: PopoverAttachmentAnchor, arrowEdge: Edge) -> some View {
        content
            .popover(isPresented: Binding(get: {
                selection == tag
            }, set: { _ in
                selection = nil
            }),
                    attachmentAnchor: anchor,
                    arrowEdge: arrowEdge,
                     content: destination)
    }
}

public extension View {
    func segue<Destination, Selection>(_ type: SegueType,
                                       tag: Selection,
                                       selection: Binding<Selection?>,
                                       @ViewBuilder destination: @escaping () -> Destination) -> some View
    where Destination : View, Selection : Hashable {
        self.modifier(Segue(type: type,
                            tag: tag,
                            selection: selection,
                            destination: destination))
    }
}


// ----------------------------------------------------------

struct SeguesView: View {
    // All the routes that lead from this view to the next one
    enum Route: Hashable {
        case pushTest, modalTest, popoverTest
    }
    
    // Triggers segues when its values are changed
    @State private var route: Route? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Push") {
                    route = .pushTest
                }
                Button("Modal") {
                    route = .modalTest
                }
                Button("Popover") {
                    route = .popoverTest
                }
            }
            .navigationBarTitle("iKartta Segues", displayMode: .inline)
            
            // Individual segues with their destinations
            .segue(.push, tag: .pushTest, selection: $route) {
                Text("Welcome to push")
            }
            .segue(.modal, tag: .modalTest, selection: $route) {
                Button("Welcome to the modal") {
                    route = nil
                }
            }
            .segue(.popover(.rect(.bounds), .top), tag: .popoverTest, selection: $route) {
                Text("Welcome to popover")
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SeguesView()
    }
}
