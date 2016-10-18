# ISSLocator
A simple app that lets users see where the International Space Station is relative to their location. 

# Build Details and Requirements
This project was built for iOS 10 using XCode 8.0 and requires XCode 8.0 to run.

# Installation Directions
Pull or download the .zip file of the repo. From the terminal run pod install after navigating to the project directory. Launch XCode and open the ISSLocator.xcworkspace workspace file. 

XCode will prompt you to convert to the latest Swift syntax. Ignore this prompt by pressing Later. Navigate to the Pods project file and select the Alamofire target. Navigate to Build Settings and assign the value NO to the key Use Legacy Swift Language Version. Confirm that this value is also specified for the SwiftyJSON target. 

Build and run the project from XCode. 

# Build Notes
You will need to specify a Team to build the project. Go to Targets->ISSLocator->General->Signing and specify your development team from the drop down menu. 

Please note that you may have to enable location simulation if running the project on the iOS Simulator. To do so expand the target build menu located on the top toolbar to the right of the stop icon and go to Edit Scheme. Under Run navigate to Options and ensure that Allow Location Simulation is checked and a default location is set. 

