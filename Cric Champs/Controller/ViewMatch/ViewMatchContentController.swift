//
//  MainPage.swift
//  demoooo
//
//  Created by Prajwal Rao Kadam on 06/12/22.
//
import UIKit
protocol IndexProtocol {
    func sendIndex(value: Int)
}
class ViewMatchContentController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var swipeDelegate: IndexProtocol?
    //var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()


        self.dataSource = self
        

        if let startingViewController = contentView(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! ContainerViewController).index
        index -= 1
        return contentView(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        var index = (viewController as! ContainerViewController).index
        index += 1

        return contentView(at: index)
    }

    func contentView(at index: Int) -> ContainerViewController? {
        if index < 0 || index > 5 {
            return nil
        }

        // Create a new view controller and pass suitable data.
        if let pageObj = storyboard?.instantiateViewController(withIdentifier: "NullViewController") as? ContainerViewController {
            pageObj.index = index
            return pageObj
        }

        return nil
    }

    func forward(index: Int) {
        if let nextViewController = contentView(at: index + 1 ) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

