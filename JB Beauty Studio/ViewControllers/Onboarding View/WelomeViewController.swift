//
//  WelomeViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 03.01.2023.
//

import UIKit

class WelcomeViewController: UIPageViewController {

    var pages = [UIViewController]()
    let pageControl = UIPageControl() // external - not part of underlying pages
    let initialPage = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            print("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
}

extension WelcomeViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

        // create an array of viewController
        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()
        let page4 = LoginViewController()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = Color.mainRedColor
        pageControl.pageIndicatorTintColor = .systemGray3
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 40),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1),
        ])
    }
}

// MARK: - Actions

extension WelcomeViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - DataSources

extension WelcomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last               // wrap to last
        } else {
            return pages[currentIndex - 1]  // go previous
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }

        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]  // go next
        } else {
            return pages.first              // wrap to first
        }
    }
}

// MARK: - Delegates

extension WelcomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}


//class WelcomeViewController: UIPageViewController {
//
//    var pages = [UIViewController]()
//    let pageControl = UIPageControl()
//    let initialPage = 0
//    var pageControlBottomAnchor: NSLayoutConstraint?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setup()
//        style()
//        layout()
//    }
//}
//
//extension WelcomeViewController {
//
//    func setup() {
//
//        dataSource = self
//        delegate = self
//
//        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
//
//        let page1 = ViewController1()
//        let page2 = ViewController2()
//        let page3 = ViewController3()
//        let page4 = LoginViewController()
//
//        pages.append(page1)
//        pages.append(page2)
//        pages.append(page3)
//        pages.append(page4)
//
//        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
//    }
//
//    func style() {
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.8823328614, green: 0.1244626418, blue: 0, alpha: 1)
//        pageControl.pageIndicatorTintColor = .systemGray2
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = initialPage
//    }
//
//    func layout() {
//        view.addSubview(pageControl)
//
//        NSLayoutConstraint.activate([
//            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: 20),
//        ])
//        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
//        pageControlBottomAnchor?.isActive = true
//    }
//}
//
//// MARK: - Actions
//
//extension WelcomeViewController {
//
//    @objc func pageControlTapped(_ sender: UIPageControl) {
//        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
//    }
//}
//
////MARK: - DataSource
//
//extension WelcomeViewController: UIPageViewControllerDataSource {
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex == 0 {
//            return nil
//        } else {
//            return pages[currentIndex - 1]
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex < pages.count - 1 {
//            return pages[currentIndex + 1]
//        } else {
//            return nil
//        }
//    }
//}
//
////MARK: - Delegate
//
//extension WelcomeViewController: UIPageViewControllerDelegate {
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//        guard let viewControllers = pageViewController.viewControllers else { return }
//        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
//
//        pageControl.currentPage = currentIndex
//        animateControlsIfNeeded()
//    }
//
//    private func animateControlsIfNeeded() {
//
//        let lastPage = pageControl.currentPage == pages.count - 1
//
//        if lastPage {
//            hideControls()
//        } else {
//            showControls()
//        }
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0.1, options: [.curveEaseIn], animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
//    }
//
//    private func hideControls() {
//        pageControlBottomAnchor?.constant = 80
//    }
//
//    private func showControls() {
//        pageControlBottomAnchor?.constant = -20
//    }
//
//
//}
