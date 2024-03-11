
import SwiftUI
import SVGKit

#if !os(macOS)
@available(iOS 13.0, tvOS 13.0, *)
struct SVGKFastImageViewSUI: UIViewRepresentable {
  @Binding private var url: URL
  @Binding private var iconSize: CGFloat

  init(url: Binding<URL>, iconSize: Binding<CGFloat>) {
    self._url = url
    self._iconSize = iconSize
  }

  func makeUIView(context: Self.Context) -> SVGKFastImageView {
    let svgImage = SVGKImage(contentsOf: url)
    return SVGKFastImageView(svgkImage: svgImage ?? SVGKImage())
  }

  func updateUIView(_ uiView: SVGKFastImageView, context: Self.Context) {
    uiView.image = SVGKImage(contentsOf: url)
    uiView.image.size = CGSize(width: iconSize, height: iconSize)
  }
}
#elseif os(macOS)
@available(macOS 10.15, *)
struct SVGKFastImageViewSUI: NSViewRepresentable {
  @Binding private var url: URL
  @Binding private var iconSize: CGFloat

  init(url: Binding<URL>, iconSize: Binding<CGFloat>) {
    self._url = url
    self._iconSize = iconSize
  }

  func makeNSView(context: Self.Context) -> SVGKFastImageView {
    let svgImage = SVGKImage(contentsOf: url)
    return SVGKFastImageView(svgkImage: svgImage ?? SVGKImage())
  }

  func updateNSView(_ nsView: SVGKFastImageView, context: Self.Context) {
    nsView.image = SVGKImage(contentsOf: url)
    nsView.image.size = CGSize(width: iconSize, height: iconSize)
  }
}
#endif


@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
struct SVGImage_Previews: PreviewProvider {
    static var previews: some View {
        SVGKFastImageViewSUI(
          url: .constant(URL(string:"https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg")!),
          iconSize: .constant(50.0)
        )
    }
}
