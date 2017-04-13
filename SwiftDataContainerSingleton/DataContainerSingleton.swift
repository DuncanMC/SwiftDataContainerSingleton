//
//  DataContainerSingleton.swift
//  SwiftDataContainerSingleton
//
//  Created by Duncan Champney on 4/19/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import Foundation
import UIKit


/**
  This struct defines the keys used to save the data container singleton's properties to NSUserDefaults.
  This is the "Swift way" to define string constants.
*/
struct DefaultsKeys
{
  static let someString  = "someString"
  static let someOtherString  = "someOtherString"
  static let someInt  = "someInt"
}

/**
  :Class:   DataContainerSingleton
  This class is used to save app state data and share it between classes.
  It observes the system UIApplicationDidEnterBackgroundNotification and saves its properties to NSUserDefaults before
  entering the background.

  Use the syntax `DataContainerSingleton.sharedDataContainer` to reference the shared data container singleton
*/

class DataContainerSingleton
{
  static let sharedDataContainer = DataContainerSingleton()
  
  //------------------------------------------------------------
  //Add properties here that you want to share accross your app
  var someString: String?
  var someOtherString: String?
  var someInt: Int?
  //------------------------------------------------------------
  
  var goToBackgroundObserver: AnyObject?
  
  init()
  {
    let defaults = UserDefaults.standard
    //-----------------------------------------------------------------------------
    //This code reads the singleton's properties from NSUserDefaults.
    //edit this code to load your custom properties
    someString = defaults.object(forKey: DefaultsKeys.someString) as! String?
    someOtherString = defaults.object(forKey: DefaultsKeys.someOtherString) as! String?
    someInt = defaults.object(forKey: DefaultsKeys.someInt) as! Int?
    //-----------------------------------------------------------------------------
    
    //Add an obsever for the UIApplicationDidEnterBackgroundNotification.
    //When the app goes to the background, the code block saves our properties to NSUserDefaults.
    goToBackgroundObserver = NotificationCenter.default.addObserver(
      forName: NSNotification.Name.UIApplicationDidEnterBackground,
      object: nil,
      queue: nil)
      {
        (note: Notification!) -> Void in
        let defaults = UserDefaults.standard
        //-----------------------------------------------------------------------------
        //This code saves the singleton's properties to NSUserDefaults.
        //edit this code to save your custom properties
        defaults.set( self.someString, forKey: DefaultsKeys.someString)
        defaults.set( self.someOtherString, forKey: DefaultsKeys.someOtherString)
        defaults.set( self.someInt, forKey: DefaultsKeys.someInt)
        //-----------------------------------------------------------------------------

        //Tell NSUserDefaults to save to disk now.
        defaults.synchronize()
    }
  }
}
