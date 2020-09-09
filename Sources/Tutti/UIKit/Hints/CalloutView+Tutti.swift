//
//  CalloutView+Tutti.swift
//  Tutti
//
//  Created by Daniel Saidi on 2020-09-10.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

extension CalloutView {
    
    public convenience init (hint: Hint, preferences: Preferences = CalloutView.globalPreferences, delegate: CalloutViewDelegate? = nil) {
        self.init(content: .hint(hint), preferences: preferences, delegate: delegate)
    }
    
    func drawHint(_ bubbleFrame: CGRect, context : CGContext) {
        guard case .hint(let hint) = content else { return }
        let prefs = preferences.drawing
        let titleHeight = size(for: hint.title, font: prefs.titleFont).height
        let offset = titleHeight + prefs.titleTextSpacing
        drawText(hint.title, withFont: prefs.titleFont, in: bubbleFrame)
        drawText(hint.text, withFont: prefs.font, in: bubbleFrame, verticalOffset: offset)
    }
    
    func drawText(_ text: String, withFont font: UIFont, in bubbleFrame: CGRect, verticalOffset: CGFloat = 0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = preferences.drawing.textAlignment
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        let textRect = getContentRect(from: bubbleFrame).offsetBy(dx: 0, dy: verticalOffset)
        let attributes = [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : preferences.drawing.foregroundColor, NSAttributedString.Key.paragraphStyle : paragraphStyle]
        text.draw(in: textRect, withAttributes: attributes)
    }
    
    func isCallout(for hint: Hint) -> Bool {
        switch content {
        case .hint(let calloutHint): return hint == calloutHint
        case .text(let text): return text == hint.text
        case .view: return false
        }
    }
    
    func size(for text: String, font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font : font]
        var size = text.boundingRect(with: CGSize(width: preferences.positioning.maxWidth, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil).size
        size.width = ceil(size.width)
        size.height = ceil(size.height)
        if size.width < preferences.drawing.arrowWidth {
            size.width = preferences.drawing.arrowWidth
        }
        return size
    }
    
    func setupAccessibility() {
        isAccessibilityElement = accessibilityText != nil
        accessibilityTraits = .staticText
        accessibilityLabel = accessibilityText
    }
}
#endif
