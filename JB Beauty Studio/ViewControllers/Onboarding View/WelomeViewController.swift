//
//  WelomeViewController.swift
//  JB Beauty Studio
//
//  Created by temaathletic on 03.01.2023.
//

import UIKit
import SnapKit

class WelomeViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    var pageControlBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
        style()
        layout()
    }
}

extension WelomeViewController {
    
    func setup() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        
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
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.8823328614, green: 0.1244626418, blue: 0, alpha: 1)
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        
    }
    func layout() {
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 40)
        
        pageControlBottomAnchor?.isActive = true
    }
}

// MARK: - Actions

extension WelomeViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

//MARK: - DataSource

extension WelomeViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

//MARK: - Delegate

extension WelomeViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        
        let lastPage = pageControl.currentPage == pages.count - 1
        
        if lastPage {
            hideControls()
        } else {
            showControls()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideControls() {
        pageControlBottomAnchor?.constant = 80
    }
    
    private func showControls() {
        pageControlBottomAnchor?.constant = -40
    }
    
    
}
