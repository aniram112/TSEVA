//
//  Information.swift
//  SuperColorPicker
//
//  Created by Sonia Kucheryavaya on 02/07/2019.
//  Copyright © 2019 Sonia Kucheryavaya. All rights reserved.
//

import UIKit

class Information: UIViewController {
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        ScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive=true
        label.text = "To save liked color, you should click on + \nTo see another color selection, you need to twist “drum” with titles of combination. \nTo choose another color on the color picker, you can move cursor around circle. \nTo open list of “favorite” colors, you should click on a book icon. \n\n\n \nComplementary\nComplementary colors have a high contrast.\n \nTriadic\nTriadic colors use three evenly spaced colors on the color wheel.\n \nTetradic\nTetradic color harmonies use two complementary pairs.\n \nAnalogous\nAnalogous harmonies are based on three or more colors that sit side-by-side on the color wheel.\n \nNeutral\nNeutral schemes, like analogous harmonies, are formed by taking the colors on either side of a chosen color but at half the distance.\n \nShades\nAdding black in varying levels to a color produces gradually darker variants of that particular color.\n \nTints\nAdding white to a color produces tints.\n \nTones\nTones are created by adding gray to a color."
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
