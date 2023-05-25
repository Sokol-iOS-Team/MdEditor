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
		cursor: CGFloat,
		pdfSize: CGSize
	) -> CGFloat {
		let pdfTextHeight = text.height(withConstrainedWidth: pdfSize.width - 2 * indent)
		let rect = CGRect(x: indent, y: cursor, width: pdfSize.width - 2 * indent, height: pdfTextHeight)
		text.draw(in: rect)

		return self.checkContext(cursor: rect.origin.y + rect.size.height, pdfSize: pdfSize)
	}

	func checkContext(cursor: CGFloat, pdfSize: CGSize) -> CGFloat {
		if cursor > pdfSize.height - 100 {
			self.beginPage()
			return 40
		}
		return cursor
	}
}
