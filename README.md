# gridAnimationWithAutoSizeAndLayout


useful code snippets is this project

//get screen width after rotation

override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async() {
            self.width = self.view.bounds.size.width
        }
}

//make view bigger

UIView.animate(withDuration: 0.5, 
               delay: 0, 
               usingSpringWithDamping: 1, 
               initialSpringVelocity: 1, 
               options: .curveEaseOut, 
               animations: {
            cellV.layer.transform = CATransform3DMakeScale(3, 3, 3)
        },completion: nil)


//make view return to origianl size

UIView.animate(withDuration: 0.5, 
              delay: 0, 
              usingSpringWithDamping: 1, 
              initialSpringVelocity: 1, 
              options: .curveEaseOut, 
              animations: {
                self.selectedcellV?.layer.transform = CATransform3DIdentity
              }, 
                
              completion: nil)
              
//check if the user let goes his finger              
              
if gesture.state == .ended {
 
}
