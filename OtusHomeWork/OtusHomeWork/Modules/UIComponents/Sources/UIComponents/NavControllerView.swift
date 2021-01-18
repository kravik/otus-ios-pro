import SwiftUI

private struct ScreenStack {
    private var screens = [Screen]()

    var count: Int {
        screens.count
    }

    init(rootScreen: Screen) {
        screens.append(rootScreen)
    }

    func top() -> Screen {
        screens.last!
    }
    
    mutating func push(_ s: Screen) {
        screens.append(s)
    }
    
    mutating func popToPrevious() {
        guard count > 1 else {
            return
        }
        screens = screens.dropLast()
    }
    
    mutating func popToRoot() {
        screens = [screens[0]]
    }
}

private struct Screen: Identifiable, Equatable {
    let id: String
    let screenView: AnyView
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        lhs.id == rhs.id
    }
}

enum NavType {
    case push
    case pop
}

public enum PopDestination {
    case previous
    case root
}

// MARK: - More UI Logic

public enum NavTransition {
    case none
    case custom(AnyTransition)
}

public final class NavControllerViewModel: ObservableObject {
    @Published public var navigationTitle: String?

    @Published public var canPop: Bool = false

    @Published fileprivate var currentScreen: Screen? {
        didSet {
            guard let screenStack = screenStack else {
                return
            }
            canPop = screenStack.count > 1
        }
    }

    private var screenStack: ScreenStack?
    
    var navigationType: NavType = .push
    private let easing: Animation
    
    init(easing: Animation) {
        self.easing = easing
    }

    func setRoot<S: View>(_ screenView: S) {
        let screen = Screen(id: UUID().uuidString, screenView: AnyView(screenView))
        screenStack = ScreenStack(rootScreen: screen)
        navigationType = .push
        currentScreen = screenStack?.top()
    }
    
    func push<S: View>(_ screenView: S) {
        withAnimation(easing) {
            navigationType = .push
            let screen = Screen(id: UUID().uuidString, screenView: AnyView(screenView))
            screenStack?.push(screen)
            currentScreen = screenStack?.top()
        }
    }
    
    func pop(to: PopDestination = .previous) {
        withAnimation(easing) {
            navigationType = .pop
            switch to {
            case .root:
                screenStack?.popToRoot()
            case .previous:
                screenStack?.popToPrevious()
            }
            currentScreen = screenStack?.top()
        }
    }
}

public struct NavControllerView<Content>: View where Content: View {
    
    @ObservedObject var viewModel: NavControllerViewModel
    
    private let content: Content
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    
    public init(
        transition: NavTransition,
        easing: Animation = .easeOut(duration: 0.33),
        @ViewBuilder content: @escaping () -> Content
    ) {
        viewModel = NavControllerViewModel(easing: easing)
        self.content = content()
        switch transition {
            case .custom(let trans):
                transitions = (trans, trans)
            case .none:
                transitions = (.identity, .identity)
        }
        viewModel.setRoot(self.content)
    }
    
    public var body: some View {
        return ZStack {
            VStack {
                navigationBar
                if let screenView = viewModel.currentScreen?.screenView {
                    screenView
                        .transition(viewModel.navigationType == .push ? transitions.push : transitions.pop)
                }
            }.environmentObject(viewModel)
        }
    }

    private var navigationBar: some View {
        VStack {
            HStack {
                VStack() {
                    if viewModel.canPop {
                        NavPopButton(destination: .previous) {
                            Image(systemName: "arrow.left")
                                .font(.callout)
                        }
                    }
                }
                .frame(width: 64, height: 64, alignment: .center)
                Spacer()
                Text(viewModel.navigationTitle ?? "").font(.title)
                Spacer()
                VStack() {
                }
                .frame(width: 64, height: 64, alignment: .center)
            }
        }
        .background(Color.gray.opacity(0.2))
        .frame(maxWidth: .infinity)
    }
}

public struct NavPushButton<Label, Destination>: View where Label: View, Destination: View {
    
    @EnvironmentObject var viewModel: NavControllerViewModel
    
    private let destination: Destination
    private let label: () -> Label
    
    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        label()
            .contentShape(Rectangle())
            .onTapGesture {
                push()
            }
    }
    
    private func push() {
        viewModel.push(destination)
    }
    
}

public struct NavPopButton<Label>: View where Label: View {
    
    @EnvironmentObject var viewModel: NavControllerViewModel
    
    private let destination: PopDestination
    private let label: () -> Label
    
    public init(destination: PopDestination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }
    
    public var body: some View {
        label().onTapGesture {
            pop()
        }
    }
    
    private func pop() {
        viewModel.pop(to: destination)
    }
    
}
