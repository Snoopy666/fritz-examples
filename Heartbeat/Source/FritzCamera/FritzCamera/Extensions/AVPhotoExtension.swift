//
//  CapturePhotoExtension.swift
//  Lumina
//
//  Created by David Okun on 11/20/17.
//  Copyright © 2017 David Okun. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


extension AVCapturePhoto {
  func normalizedImage(forCameraPosition position: AVCaptureDevice.Position) -> UIImage? {
    FritzLogger.notice(message: "normalizing image from AVCapturePhoto instance")
    guard let cgImage = self.cgImageRepresentation() else {
      return nil
    }
    return UIImage(cgImage: cgImage.takeUnretainedValue(), scale: 1.0, orientation: getImageOrientation(forCamera: position))
  }

  func getImageOrientation(forCamera: AVCaptureDevice.Position) -> UIImage.Orientation {
    switch UIApplication.shared.statusBarOrientation {
    case .landscapeLeft:
      return forCamera == .back ? .down : .downMirrored
    case .landscapeRight:
      return forCamera == .back ? .up : .upMirrored
    case .portraitUpsideDown:
      return forCamera == .back ? .left : .leftMirrored
    case .portrait:
      return forCamera == .back ? .right : .rightMirrored
    case .unknown:
      return forCamera == .back ? .right : .rightMirrored
    @unknown default:
      return forCamera == .back ? .right : .rightMirrored
    }
  }
}
