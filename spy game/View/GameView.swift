//
//  GameView.swift
//  spy game
//
//  Created by Елисей on 06.01.2021.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: ViewModel
    @GestureState private var dragState = DragState.inactive
    @State private var cardRemovalTranslation = AnyTransition.trailingBottom
    var dragAreaThreshold: CGFloat = 65.0
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
                
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
                
            case .inactive, .pressing:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .pressing:
                return true
                
            case .dragging, .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(viewModel.cardsToShow) { player in
                player
                    .zIndex(isTopCard(card: player) ? 1 : 0)
                    .offset(x: isTopCard(card: player) ? dragState.translation.width : 0,
                            y: isTopCard(card: player) ? dragState.translation.height : 0)
                    .scaleEffect(dragState.isDragging && isTopCard(card: player) ? 0.85 : 1.0)
                    .rotationEffect(Angle(degrees: isTopCard(card: player) ?
                                        Double(dragState.translation.width / 12) : 0))
                    .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                    .gesture(LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating(self.$dragState, body: { (value, state, translation) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                        
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)

                                    default:
                                        break
                                    }
                                })
                                .onChanged({ (value) in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -dragAreaThreshold {
                                        cardRemovalTranslation = .leadingBottom
                                    }
                                    
                                    if drag.translation.width > dragAreaThreshold {
                                        cardRemovalTranslation = .trailingBottom
                                    }
                                })
                                .onEnded({ value in
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                                    
                                    if drag.translation.width < -dragAreaThreshold ||
                                        drag.translation.width > dragAreaThreshold {
                                        viewModel.changeCard()
                                    }
                                })
                    ).transition(cardRemovalTranslation)
                    
                        
            }
        }
        .padding(.horizontal)
    }
    
    private func isTopCard(card: CardView) -> Bool {
        guard let index = viewModel.cardsToShow.firstIndex(where: {$0.id == card.id}) else {
            return false
        }
        return index == 0
    }
}
