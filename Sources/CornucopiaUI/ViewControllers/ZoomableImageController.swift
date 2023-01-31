//
//  Cornucopia – (C) Dr. Lauer Information Technology
//
#if os(iOS)
import CornucopiaCore
import UIKit

extension Cornucopia.UI {

    open class ZoomableImageController: UIViewController {

        public static let DidUpdateZoomState: Notification.Name = .init(stringLiteral: "ZoomableImageControllerDidUpdateZoomState")

        lazy var scrollView: UIScrollView = {
            let sv = UIScrollView()
            sv.showsVerticalScrollIndicator = false
            sv.showsHorizontalScrollIndicator = false
            sv.isUserInteractionEnabled = true
            sv.bouncesZoom = true
            sv.scrollsToTop = false
            sv.delegate = self
            sv.minimumZoomScale = 1.0
            sv.maximumZoomScale = 10.0

            let sgr = UITapGestureRecognizer(target: self, action: #selector(onSingleTapGestureRecognizer))
            sgr.numberOfTapsRequired = 1
            sgr.numberOfTouchesRequired = 1
            sv.addGestureRecognizer(sgr)

            let dgr = UITapGestureRecognizer(target: self, action: #selector(onDoubleTapGestureRecognizer))
            dgr.numberOfTapsRequired = 2
            dgr.numberOfTouchesRequired = 1
            sv.addGestureRecognizer(dgr)

            sgr.require(toFail: dgr)
            return sv
        }()

        public lazy var imageView: UIImageView = {
            let iv = UIImageView()
            iv.backgroundColor = .red
            iv.contentMode = .scaleAspectFit
            iv.clipsToBounds = true
            return iv
        }()

        public var zoomedIn: Bool = false

        public var image: UIImage {
            get {
                self.imageView.image!
            }
            set {
                self.imageView.image = newValue
                self.imageView.frame = CGRect(origin: .zero, size: newValue.size)
                self.view.setNeedsLayout()
            }
        }

        public required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        public init() {
            super.init(nibName: nil, bundle: nil)
            //self.edgesForExtendedLayout = UIRectEdge()
            //self.scrollView.contentInsetAdjustmentBehavior = .never
        }

        open override func viewDidLoad() {
            self.view.backgroundColor = .black
            self.view.addSubview(self.scrollView)

            self.scrollView.backgroundColor = .purple
            self.imageView.backgroundColor = .blue

            self.scrollView.addSubview(self.imageView)
            if let image = self.imageView.image {
                self.imageView.frame = CGRect(origin: .zero, size: image.size)
            }
        }

        open override func viewDidLayoutSubviews() {
            self.scrollView.frame = self.view.bounds
            self.configureSizeAndZoomScale()
        }

        open override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        }

        open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            coordinator.animate { _ in self.centerScrollViewContents() }
        }
    }
}

private extension Cornucopia.UI.ZoomableImageController {

    func configureSizeAndZoomScale() {

        guard let image = self.imageView.image else { return }

        self.scrollView.contentSize = image.size

        let scrollViewFrame = self.scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)

        self.scrollView.minimumZoomScale = minScale
        self.scrollView.maximumZoomScale = 2.5
        self.scrollView.zoomScale = minScale

        self.centerScrollViewContents()
    }

    func centerScrollViewContents() {

        let boundsSize = self.scrollView.bounds.size
        var contentsFrame = self.imageView.frame

        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }

        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }

        self.imageView.frame = contentsFrame
    }

    func zoomToScale(scale: CGFloat, pointInView: CGPoint) {

        let scrollViewSize = self.scrollView.bounds.size
        let w = scrollViewSize.width / scale
        let h = scrollViewSize.height / scale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)

        let rectToZoomTo = CGRectMake(x, y, w, h);
        self.scrollView.zoom(to: rectToZoomTo, animated: true)
    }
}

extension Cornucopia.UI.ZoomableImageController: UIScrollViewDelegate {

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? { self.imageView }
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale == scrollView.minimumZoomScale && self.zoomedIn {
            self.zoomedIn = false
            NotificationCenter.default.CC_postAsync(on: .main, name: Self.DidUpdateZoomState, object: self)
        } else if scrollView.zoomScale > scrollView.minimumZoomScale && !self.zoomedIn {
            self.zoomedIn = true
            NotificationCenter.default.CC_postAsync(on: .main, name: Self.DidUpdateZoomState, object: self)
        }
        self.centerScrollViewContents()
    }
}

extension Cornucopia.UI.ZoomableImageController {

    @objc func onSingleTapGestureRecognizer(_ gr: UITapGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true)
    }

    @objc func onDoubleTapGestureRecognizer(_ gr: UITapGestureRecognizer) {
        guard gr.state == .recognized else { return }
        let pointInView = gr.location(in: imageView)
        let zoomScale = self.scrollView.zoomScale == self.scrollView.minimumZoomScale ? self.scrollView.maximumZoomScale : self.scrollView.minimumZoomScale
        self.zoomToScale(scale: zoomScale, pointInView: pointInView)
    }
}

extension Cornucopia.UI.ZoomableImageController {

    public override var prefersHomeIndicatorAutoHidden: Bool { true }
    public override var prefersStatusBarHidden: Bool { true }
}

#endif

