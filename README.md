#SwiftDataContainerSingleton

A demonstration of using a data container singleton to save application state and share it between objects.

The `DataContainerSingleton` class is the actual singleton.

It uses a static constant `sharedDataContainer` to save a reference to the singleton.

To access the singleton, use the syntax

	DataContainerSingleton.sharedDataContainer

The sample project defines 3 properties in the data container:


	  var someString: String?
	  var someOtherString: String?
	  var someInt: Int?

To load the `someInt` property from the data container, you'd use code like this:


	let theInt = DataContainerSingleton.sharedDataContainer.someInt
	
To save a value to someInt, you'd use the syntax:

	DataContainerSingleton.sharedDataContainer.someInt = 3


The DataContainerSingleton's `init` method adds an observer for the `UIApplicationDidEnterBackgroundNotification`.  That code looks like this:

    goToBackgroundObserver = NSNotificationCenter.defaultCenter().addObserverForName(
      UIApplicationDidEnterBackgroundNotification,
      object: nil,
      queue: nil)
      {
        (note: NSNotification!) -> Void in
        let defaults = NSUserDefaults.standardUserDefaults()
        //-----------------------------------------------------------------------------
        //This code saves the singleton's properties to NSUserDefaults.
        //edit this code to save your custom properties
        defaults.setObject( self.someString, forKey: DefaultsKeys.someString)
        defaults.setObject( self.someOtherString, forKey: DefaultsKeys.someOtherString)
        defaults.setObject( self.someInt, forKey: DefaultsKeys.someInt)
        //-----------------------------------------------------------------------------

        //Tell NSUserDefaults to save to disk now.
        defaults.synchronize()
    }



In the observer code it saves the data container's properties to `NSUserDefaults`. You can also use `NSCoding`, Core Data, or various other methods for saving state data.

The DataContainerSingleton's `init` method also tries to load saved values for it's properties.

That portion of the init method looks like this:

    let defaults = NSUserDefaults.standardUserDefaults()
    //-----------------------------------------------------------------------------
    //This code reads the singleton's properties from NSUserDefaults.
    //edit this code to load your custom properties
    someString = defaults.objectForKey(DefaultsKeys.someString) as! String?
    someOtherString = defaults.objectForKey(DefaultsKeys.someOtherString) as! String?
    someInt = defaults.objectForKey(DefaultsKeys.someInt) as! Int?
    //-----------------------------------------------------------------------------

The keys for loading and saving values into NSUserDefaults are stored as string constants that are part of a struct `DefaultsKeys`, defined like this:

	struct DefaultsKeys
	{
	  static let someString  = "someString"
	  static let someOtherString  = "someOtherString"
	  static let someInt  = "someInt"
	}

You reference one of these constants like this:

	DefaultsKeys.someInt
	
##Using the data container singleton:
------------


This sample application makes trival use of the data container singleton.

There are two view controllers. The first is a custom subclass of UIViewController `ViewController`, and the second one is a custom subclass of UIViewController `SecondVC`.

Both view controllers have a text field on them, and both load a value from the data container singlelton's `someInt` property into the text field in their `viewWillAppear` method, and both save the current value from the text field back into the `someInt' of the data container.

The code to load the value into the text field is in the `viewWillAppear:` method:

	override func viewWillAppear(animated: Bool)
	{
	  //Load the value "someInt" from our shared ata container singleton
	  let value = DataContainerSingleton.sharedDataContainer.someInt ?? 0
	  
	  //Install the value into the text field.
	  textField.text =  "\(value)"
	}

The code to save the user-edited value back to the data container is in the view controllers' `textFieldShouldEndEditing` methods:

	 func textFieldShouldEndEditing(textField: UITextField) -> Bool
	 {
	   //Save the changed value back to our data container singleton
	   DataContainerSingleton.sharedDataContainer.someInt = textField.text!.toInt()
	   return true
	 }

You should load values into your user interface in viewWillAppear rather than viewDidLoad so that your UI updates each time the view controller is displayed. 