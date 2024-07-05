//
//  TimerWidgetLiveActivity.swift
//  TimerWidget
//
//  Created by Buddha Lama on 25/06/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TimerWidgetAttributes: ActivityAttributes {
  public struct ContentState: Codable, Hashable {
    // Dynamic stateful properties about your activity go here!
    var startedAt: Date?
    var pausedAt: Date?
    
    func getElapsedTimeInSeconds() -> Int {
      let now = Date()
      guard let startedAt = self.startedAt else {
        return 0
      }
      guard let pausedAt = self.pausedAt else {
        return Int(now.timeIntervalSince1970 - startedAt.timeIntervalSince1970)
      }
      return Int(pausedAt.timeIntervalSince1970 - startedAt.timeIntervalSince1970)
    }
    
    func getPausedTime() -> String {
      let elapsedTimeInSeconds = getElapsedTimeInSeconds()
      let minutes = (elapsedTimeInSeconds % 3600) / 60
      let seconds = elapsedTimeInSeconds % 60
      return String(format: "%d:%02d", minutes, seconds)
    }
    
    func getTimeIntervalSinceNow() -> Double {
      guard let startedAt = self.startedAt else {
        return 0
      }
      return startedAt.timeIntervalSince1970 - Date().timeIntervalSince1970
    }
    
    func isRunning() -> Bool {
      return pausedAt == nil
    }
  }
  
}

struct TimerWidgetLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: TimerWidgetAttributes.self) { context in
      // Lock screen/banner UI goes here
      VStack {
        if (context.state.isRunning()) {
          Text(
            Date(timeIntervalSinceNow: context.state.getTimeIntervalSinceNow()),
            style: .timer
          )
        }else{
          Text(
            context.state.getPausedTime()
          )
        }

        
      }
      .activityBackgroundTint(Color.cyan)
      .activitySystemActionForegroundColor(Color.black)
      
    } dynamicIsland: { context in
      DynamicIsland {
        // Expanded UI goes here.  Compose the expanded UI through
        // various regions, like leading/trailing/center/bottom
        DynamicIslandExpandedRegion(.center) {
          ZStack {
              RoundedRectangle(cornerRadius: 24).strokeBorder(Color(red: 148/255.0, green: 163/255.0, blue: 184/255.0), lineWidth: 2)
              HStack {
                HStack(spacing: 8.0, content: {
                  if (context.state.isRunning()) {
                    Button(intent: PauseIntent()) {
                      ZStack {
                        Circle().fill(Color.cyan.opacity(0.5))
                        Image(systemName: "pause.fill")
                          .imageScale(.large)
                          .foregroundColor(.cyan)
                      }
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes default button styling
                    .contentShape(Rectangle()) // Ensures the tap area includes the entire custom content
                  } else {
                    Button(intent: ResumeIntent()) {
                      ZStack {
                        Circle().fill(Color.cyan.opacity(0.5))
                        Image(systemName: "play.fill")
                          .imageScale(.large)
                          .foregroundColor(.cyan)
                      }
                    }
                    .buttonStyle(PlainButtonStyle()) // Removes default button styling
                    .contentShape(Rectangle()) // Ensures the tap area includes the entire custom content
                  }
                  Button(intent: ResetIntent()) {
                    ZStack {
                      Circle().fill(.gray.opacity(0.5))
                      Image(systemName: "xmark")
                        .imageScale(.medium)
                        .foregroundColor(.white)
                    }
                  }
                  .buttonStyle(PlainButtonStyle()) // Removes default button styling
                  .contentShape(Rectangle()) // Ensures the tap area includes the entire custom content
                  Spacer()
                })
                if (!context.state.isRunning()) {
                  Text(
                    context.state.getPausedTime()
                  )
                  .font(.title)
                  .foregroundColor(.cyan)
                  .fontWeight(.medium)
                  .monospacedDigit()
                  .transition(.identity)
                } else {
                  Text(
                    Date(
                      timeIntervalSinceNow: context.state.getTimeIntervalSinceNow()
                    ),
                    style: .timer
                  )
                  .font(.title)
                  .foregroundColor(.cyan)
                  .fontWeight(.medium)
                  .monospacedDigit()
                  .frame(width: 60)
                  .transition(.identity)
                }
              }
              .padding()
            }
            .padding()
        }
        DynamicIslandExpandedRegion(.leading) {
          Text("Leading")
        }
        DynamicIslandExpandedRegion(.trailing) {
          Text("Trailing")
        }
        DynamicIslandExpandedRegion(.bottom) {
          Text("Bottom")
          // more content
        }
      } compactLeading: {
        Text("L")
      } compactTrailing: {
        if (context.state.isRunning()) {
          Text(
            Date(timeIntervalSinceNow: context.state.getTimeIntervalSinceNow()),
            style: .timer
          )
          .foregroundColor(.cyan)
          .frame(maxWidth: 32)
          .monospacedDigit()
        }else{
          Text(
            context.state.getPausedTime()
          )
          .foregroundColor(.cyan)
          .frame(maxWidth: 32)
          .monospacedDigit()
        }

      } minimal: {
        Text("emoji")
      }
      .widgetURL(URL(string: "http://www.apple.com"))
      .keylineTint(Color.red)
    }
  }
}

extension TimerWidgetAttributes {
  fileprivate static var preview: TimerWidgetAttributes {
    TimerWidgetAttributes()
  }
}

extension TimerWidgetAttributes.ContentState {
  //    fileprivate static var smiley: TimerWidgetAttributes.ContentState {
  //        TimerWidgetAttributes.ContentState(emoji: "😀")
  //     }
  //
  //     fileprivate static var starEyes: TimerWidgetAttributes.ContentState {
  //         TimerWidgetAttributes.ContentState(emoji: "🤩")
  //     }
  
  fileprivate static var initState: TimerWidgetAttributes.ContentState {
    TimerWidgetAttributes.ContentState(startedAt: Date())
  }
}

#Preview("Notification", as: .content, using: TimerWidgetAttributes.preview) {
  TimerWidgetLiveActivity()
} contentStates: {
  //    TimerWidgetAttributes.ContentState.smiley
  //    TimerWidgetAttributes.ContentState.starEyes
  
  TimerWidgetAttributes.ContentState.initState
}
