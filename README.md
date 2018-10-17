
![alt text](https://raw.githubusercontent.com/sgcodigo/TASizeLabel/master/Resource/SizeCompare.png)

## Installation

- Just drag and drop. I will setup **CocoaPods** later because currently finding solution for creating custom stylesheet.

## Configuration

Since this label component is based on **Stylesheet**, you may need to get the stylesheet first with variable font sizes.

![alt text](https://raw.githubusercontent.com/sgcodigo/TASizeLabel/master/Resource/FontSizes.png)

1. Collect those font sizes and group from higher to lower

2. Edit `enum` as shown below picture for controlling font size

```
      internal enum SizeLevel: Int {
            case HeadLineOne = 0 // 48 points
            case HeadLineTwo = 1// 36 points
            case Biggest = 2 // 32 points
            case Bigger = 3  // 24 points
            case Big = 4 // 20 Points
            case Medium = 5 // 18 points
            case Normal = 6 // 16 points
            case Small = 7 // 14 points
            case Smaller = 8 // 12 points
      }
```

## How to use?

First you need to define the `UILabel` that you want to use as **`TASizeLabel`** at identity inspector.

![alt text](https://raw.githubusercontent.com/sgcodigo/TASizeLabel/master/Resource/ClassName.png)

### 1. You can use this label via `IBInspectable`###

**Font Size Label** - is the enum that you configured. Can set it to 0,1,2,3,4

**Required Resize** - `true` will use default auto resize config. Default is `false`

**Reduce To Size** - When you set `requiredResize` to `true`, you can also set custom reduce point instead of using default configuration.

![alt text](https://raw.githubusercontent.com/sgcodigo/TASizeLabel/master/Resource/Inspectable.png)

### 2. Or programatically ###

```

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblSizeOne: TASizeLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSizeOne.requiredResize = true
        lblSizeOne.fontSizeLevel = 0
        
        // Do any additional setup after loading the view, typically from a nib.
    }
}

```



