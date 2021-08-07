
import UIKit


class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//       let backImage = UIImage(named: "ic_leftArrow")
///      backImage?.renderingMode = .alwaysOriginal
//        self.navigationController?.navigationBar.backIndicatorImage = backImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
////        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 700);


        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "ic_leftArrow"), for:.normal)
        button.addTarget(self, action: #selector(goBack), for:.touchUpInside)
        button.frame = CGRect(x: 50, y: 10, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = barButton


       // navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"ic_leftArrow"), style: .plain, target: self, action: #selector(goBack))

//        let button: UIButton = UIButton (type: UIButton.ButtonType.custom)
//        button.setImage(UIImage(named: "ic_leftArrow"), for: UIControl.State.normal)
//        button.addTarget(self, action: Selector(("backButtonPressed:")), for: UIControl.Event.touchUpInside)
//            button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
//
//            let barButton = UIBarButtonItem(customView: button)
//
//            self.navigationItem.leftBarButtonItem = barButton
//


    }

    //MARK:- ===== Back Btn Action =====
    @objc func goBack()
      {
          self.navigationController?.popViewController(animated: true)
      }

   
}

