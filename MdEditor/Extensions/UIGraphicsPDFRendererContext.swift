//
//  UIGraphicsPDFRendererContext.swift
//  MdEditor
//
//  Created by Вадим Гамзаев on 25.05.2023.
//

import PDFKit

extension UIGraphicsPDFRendererContext {
	func addAttributedText(
		text: NSAttributedString,
		indent: CGFloat,
		startCursor: CGFloat,
		defaultCursor: CGFloat,
		pdfSize: CGSize
	) -> CGFloat {
		let textHeight = text.height(withConstrainedWidth: pdfSize.width - 2 * indent)
		var rect = CGRect(x: indent, y: startCursor, width: pdfSize.width - 2 * indent, height: textHeight)

		let isNewPageNeeded = rect.maxY >= pdfSize.height - indent

		if isNewPageNeeded {
			self.beginPage()
			rect.origin.y = defaultCursor
		}

		text.draw(in: rect)

		return rect.maxY
	}
}
