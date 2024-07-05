//
//  IntentPlaceholder.swift.swift
//  TimerWidgetExtension
//
//  Created by Buddha Lama on 04/07/2024.
//

import Foundation
import AppIntents

// IntentPlaceholder.swift

public struct PauseIntent: LiveActivityIntent {
  public init() {}
  public static var title: LocalizedStringResource = "Pause timer"
  public func perform() async throws -> some IntentResult {
    return .result()
  }
}

public struct ResumeIntent: LiveActivityIntent {
  public init() {}
  public static var title: LocalizedStringResource = "Resume timer"
  public func perform() async throws -> some IntentResult {
    return .result()
  }
}

public struct ResetIntent: LiveActivityIntent {
  public init() {}
  public static var title: LocalizedStringResource = "Reset timer"
  public func perform() async throws -> some IntentResult {
    return .result()
  }
}
