//
//  TextHandle.swift
//  honwoyomu
//
//  Created by gaoge on 2023/2/2.
//

import Foundation
import RegexBuilder

enum RegexDefines {
    static let chapterRegex = Regex {
        let start = Local {
            Anchor.startOfLine
            ZeroOrMore(.whitespace)
            Optionally("第")
        }

        let number = ChoiceOf {
            OneOrMore(.digit)
            OneOrMore(.anyOf("一|二|三|四|五|六|七|八|九|十|百|千|万"))
        }

        let end = Local {
            ZeroOrMore(.anyOf("回|章|节"))
        }

        let title = OneOrMore(.anyGraphemeCluster)

        start
        ZeroOrMore(.whitespace)
        Capture { number }
        ZeroOrMore(.whitespace)
        end
        ZeroOrMore(.whitespace)
        Capture { title }
        Anchor.endOfLine
    }
}

struct Chapter {
    let content: Substring
    let number: Substring
    let title: Substring
}

struct Paragraph {
    let content: String
}

enum TextSlice {
    case chapter(Chapter)
    case paragraph(Paragraph)
}

class TextHandle {
    let handle: FileHandle

    var slices: AsyncThrowingStream<TextSlice, Error>?

    init?(forReadingAtPath path: String) {
        let fileHandle = FileHandle(forReadingAtPath: path)
        guard let fileHandle = fileHandle else {
            return nil
        }
        self.handle = fileHandle
    }

    /// According to [public implementions](https://github.com/apple/swift-corelibs-foundation/pull/3036).
    /// seems that `lines` won't yield blank line. is this expected?
    func parseContent() {
        slices = AsyncThrowingStream(unfolding: {
            for try await line in self.handle.bytes.lines {
                if let output = line.firstMatch(of: RegexDefines.chapterRegex)?.output {
                    return .chapter(Chapter(content: output.0, number: output.1, title: output.2))
                }
                return .paragraph(Paragraph(content: line))
            }
            return nil
        })
    }
}
