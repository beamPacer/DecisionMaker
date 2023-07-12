//
//  TutorialView.swift
//  DecisionMaker
//
//  Created by Emma Sinclair on 7/12/23.
//

import SwiftUI

struct TutorialView: View {
	var tutorialPage: TutorialPage
	
	var body: some View {
		VStack {
			Image(tutorialPage.image)
				.resizable()
				.aspectRatio(contentMode: .fit)
			
			Text(tutorialPage.text)
				.padding()
		}
	}
}

struct TutorialPageView: View {
	var tutorialPages: [TutorialPage]
	
	var body: some View {
		VStack {
			PageView(tutorialPages.map { TutorialView(tutorialPage: $0) })
			.aspectRatio(2/3, contentMode: .fit)
		}
	}
}

struct PageView<Page: View>: View {
	var viewControllers: [UIHostingController<Page>]
	@State var currentPage = 0
	
	init(_ views: [Page]) {
		self.viewControllers = views.map { UIHostingController(rootView: $0) }
	}
	
	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			PageViewController(controllers: viewControllers, currentPage: $currentPage)
			PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
				.padding(.trailing)
		}
	}
}

struct PageViewController: UIViewControllerRepresentable {
	var controllers: [UIViewController]
	@Binding var currentPage: Int

	func makeUIViewController(context: UIViewControllerRepresentableContext<PageViewController>) -> UIPageViewController {
		let pageViewController = UIPageViewController(
			transitionStyle: .scroll,
			navigationOrientation: .horizontal)
		
		pageViewController.dataSource = context.coordinator
		pageViewController.delegate = context.coordinator
		
		return pageViewController
	}

	func updateUIViewController(_ pageViewController: UIPageViewController, context: UIViewControllerRepresentableContext<PageViewController>) {
		pageViewController.setViewControllers(
			[controllers[currentPage]],
			direction: .forward,
			animated: true)
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
		var parent: PageViewController

		init(_ pageViewController: PageViewController) {
			self.parent = pageViewController
		}

		func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
			guard let index = parent.controllers.firstIndex(of: viewController) else {
				return nil
			}
			if index == 0 {
				return parent.controllers.last
			}
			return parent.controllers[index - 1]
		}

		func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
			guard let index = parent.controllers.firstIndex(of: viewController) else {
				return nil
			}
			if index + 1 == parent.controllers.count {
				return parent.controllers.first
			}
			return parent.controllers[index + 1]
		}
		
		func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
			if completed,
			   let visibleViewController = pageViewController.viewControllers?.first,
			   let index = parent.controllers.firstIndex(of: visibleViewController) {
				parent.currentPage = index
			}
		}
	}
}

struct PageControl: UIViewRepresentable {
	var numberOfPages: Int
	@Binding var currentPage: Int

	func makeUIView(context: Context) -> UIPageControl {
		let control = UIPageControl()
		control.numberOfPages = numberOfPages
		control.addTarget(
			context.coordinator,
			action: #selector(Coordinator.updateCurrentPage(sender:)),
			for: .valueChanged)
		
		return control
	}

	func updateUIView(_ uiView: UIPageControl, context: Context) {
		uiView.currentPage = currentPage
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}

	class Coordinator: NSObject {
		var control: PageControl

		init(_ control: PageControl) {
			self.control = control
		}

		@objc func updateCurrentPage(sender: UIPageControl) {
			control.currentPage = sender.currentPage
		}
	}
}
