//
//  AppearanceHelper.swift
//  ToDoTasks
//
//  Created by Nelson Gonzalez on 2/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    static var lightBlueColor = UIColor(red: 150/255, green: 212/255, blue: 243/255, alpha: 1)
    static var veryLightBlueColor = UIColor(red: 225/255, green: 243/255, blue: 252/255, alpha: 1)
    
    static func setupAppearance() {
        //MARK: - Navigation Bar Appearance
        UINavigationBar.appearance().barTintColor = lightBlueColor
        //Set nav bar title color
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        
        //set nav bar button color
        UIBarButtonItem.appearance().tintColor = .black
        
        
        //MARK: - segmented controll appearance
        UISegmentedControl.appearance().tintColor = lightBlueColor

    }
    
  
}
