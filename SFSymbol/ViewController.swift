//
//  ViewController.swift
//  SFSymbol
//
//  Created by 方仕賢 on 2022/3/10.
//

import UIKit

class ViewController: UIViewController {
    
    let colors = [UIColor.blue, UIColor.red,  UIColor.systemTeal, UIColor.brown, UIColor.cyan, UIColor.green, UIColor.gray, UIColor.yellow, UIColor.orange, UIColor.purple, UIColor.black, UIColor.white]
    let colorNames = ["Blue","Red" , "System Teal", "Brown", "Cyan", "Green", "Gray", "Yellow", "Orange", "Purple", "Black", "White"]
    let systemNames = ["square.and.arrow.up", "square.and.arrow.up.fill", "square.and.arrow.up.circle", "square.and.arrow.up.circle.fill", "square.and.arrow.up.trianglebadge.exclamationmark", "square.and.arrow.down", "square.and.arrow.down.fill", "square.and.arrow.up.on.square", "square.and.arrow.up.on.square.fill", "square.and.arrow.down.on.square", "square.and.arrow.down.on.square", "rectangle.portrait.and.arrow.right", "rectangle.portrait.and.arrow.right.fill", "pencil", "pencil.circle", "pencil.slash", "square.and.pencil", "rectangle.and.pencil.and.ellipsis", "scribble", "scribble.variable", "pencil.tip.crop.circle.badge.plus", "pencil.tip.crop.circle.badge.minus"]
    
    @IBOutlet weak var chooseColorButton: UIButton!
    
    @IBOutlet weak var chooseSecondColorButton: UIButton!
    
    @IBOutlet weak var chooseConfigurationButton: UIButton!
    
    @IBOutlet weak var chooseSystemNameButton: UIButton!
    
    let configurationNames = ["Monochrome","Palette", "Multicolor", "Hierachical"]
    var configurationIndex = 0
    var systemImageName = "square.and.arrow.up"
    var currentColor = UIColor.blue
    var secondCurrentColor = UIColor.blue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeMonochromeSymbol(name: systemImageName, tintColor: currentColor)
        chooseConfiguration()
        chooseColor(isSecondColor: false)
        chooseSecondColor()
        chooseSystemName()
    }
    
    func chooseSystemName(){
        
        var actions = [UIAction]()
        for i in 0...systemNames.count-1 {
            actions.append(UIAction(title: systemNames[i] ,handler: { action in
                
                self.systemImageName = self.systemNames[i]
                switch self.configurationIndex {
                case 0:
                    self.makeMonochromeSymbol(name: self.systemImageName, tintColor: self.currentColor)
                case 1:
                    self.makePaletteSymbol(systemName: self.systemImageName, paletteColors: [self.currentColor, self.secondCurrentColor])
                    
                case 2:
                    self.makeMulticolorSymbol(systemName: self.systemImageName, tintColor: self.currentColor)
                    
                default:
                    self.makeHierachicalSymbol(systemName: self.systemImageName, hierachicalColor: self.currentColor)
                }
            }))
        }
        
        chooseSystemNameButton.menu = UIMenu(children: actions)
    }
    
    func chooseConfiguration() {
        
        var actions = [UIAction]()
        for i in 0...configurationNames.count-1 {
            actions.append(UIAction(title: configurationNames[i], handler: { action in
                switch i {
                case 0:
                    self.makeMonochromeSymbol(name: self.systemImageName, tintColor: self.currentColor)
                    self.configurationIndex = 0
                    self.chooseSecondColorButton.isEnabled = false
                    self.chooseSecondColorButton.alpha = 0.5
                case 1:
                    self.makePaletteSymbol(systemName: self.systemImageName, paletteColors: [self.currentColor, UIColor.purple])
                    self.configurationIndex = 1
                    self.chooseSecondColorButton.isEnabled = true
                    self.chooseSecondColorButton.alpha = 1
                case 2:
                    self.makeMulticolorSymbol(systemName: self.systemImageName, tintColor: self.currentColor)
                    self.configurationIndex = 2
                    self.chooseSecondColorButton.isEnabled = false
                    self.chooseSecondColorButton.alpha = 0.5
                default:
                    self.makeHierachicalSymbol(systemName: self.systemImageName, hierachicalColor: self.currentColor)
                    self.configurationIndex = 3
                    self.chooseSecondColorButton.isEnabled = false
                    self.chooseSecondColorButton.alpha = 0.5
                }
            }))
        }
        
        chooseConfigurationButton.menu = UIMenu(children: actions)
    }
    
    func chooseColor(isSecondColor: Bool){
        
        var actions = [UIAction]()
        
        for i in 0...colors.count-1 {
            actions.append(UIAction(title: colorNames[i] , handler: { action in
                if !isSecondColor {
                    self.currentColor = self.colors[i]
                } else {
                    self.secondCurrentColor = self.colors[i]
                }
                
                switch self.configurationIndex {
                case 0:
                    self.makeMonochromeSymbol(name: self.systemImageName, tintColor: self.currentColor)
                case 1:
                    self.makePaletteSymbol(systemName: self.systemImageName, paletteColors: [self.currentColor, self.secondCurrentColor])
                case 2:
                    self.makeMulticolorSymbol(systemName: self.systemImageName, tintColor: self.currentColor)
                    
                default:
                    self.makeHierachicalSymbol(systemName: self.systemImageName, hierachicalColor: self.currentColor)
                }
                
            }))
        }
        if !isSecondColor {
            chooseColorButton.menu = UIMenu(children: actions)
        } else {
            chooseSecondColorButton.menu = UIMenu(children: actions)
        }
    }
    
    func chooseSecondColor() {
        chooseColor(isSecondColor: true)
    }
    
    func makeMonochromeSymbol(name: String, tintColor: UIColor){
        let image = UIImage(systemName: name)
        let imageView = UIImageView(image: image)
        
        imageView.tintColor = tintColor
        imageView.frame = CGRect(x: 100, y: 220, width: 200, height: 200)
        imageView.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    func makeMulticolorSymbol(systemName: String, tintColor: UIColor){
        let multicolorConfiguration = UIImage.SymbolConfiguration.preferringMulticolor()
        let image = UIImage(systemName: systemName, withConfiguration: multicolorConfiguration)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 220, width: 200, height: 200))
        imageView.image = image
        imageView.tintColor = tintColor
        imageView.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    func makeHierachicalSymbol(systemName: String, hierachicalColor: UIColor) {
        let hierachicalSymbolConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: hierachicalColor)
        let image = UIImage(systemName: systemName,withConfiguration: hierachicalSymbolConfiguration)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 220, width: 200, height: 200))
        imageView.image = image
        imageView.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    func makePaletteSymbol(systemName: String ,paletteColors: [UIColor]){
        let paletteSymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: paletteColors)
        let image = UIImage(systemName: systemName, withConfiguration: paletteSymbolConfiguration)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 220, width: 200, height: 200))
        imageView.image = image
        imageView.backgroundColor = .white
        view.addSubview(imageView)
        
    }

}

