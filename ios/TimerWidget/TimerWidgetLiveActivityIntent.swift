//
//  TimerWidgetLiveActivityIntent.swift
//  FancyTimer
//
//  Created by Buddha Lama on 04/07/2024.
//

// TimerWidgetLiveActivityIntent.swift

import Foundation
import AppIntents

public struct PauseIntent: LiveActivityIntent {
  public init() {}
  public static var title: LocalizedStringResource = "Pause timer"
  public func perform() async throws -> some IntentResult {
    TimerEventEmitter.emitter?.sendEvent(withName: "onPause", body: nil)
    return .result()
  }
}

public struct ResumeIntent: LiveActivityIntent {
  public init() {}
  public static var title: LocalizedStringResource = "Resume timer"
  public func perform() async throws -> some IntentResult {
    TimerEventEmitter.emitter?.sendEvent(withName: "onResume", body: nil)
    return .result()
  }
}

public struct ResetIntent: LiveActivityIntent {
  public init() {}
  public static var title: LocalizedStringResource = "Reset timer"
  public func perform() async throws -> some IntentResult {
    TimerEventEmitter.emitter?.sendEvent(withName: "onReset", body: nil)
    return .result()
  }
}
