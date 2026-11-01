/// Central registry of bundled asset paths so screens never hardcode strings.
///
/// The brand mark itself is drawn in code (see [BrandMark]) rather than
/// shipped as a bitmap, so only illustrative artwork lives here.
class AppAssets {
  AppAssets._();

  static const _images = 'assets/images';
  static const _icons = 'assets/icons';

  static const bike = '$_images/wingo_bike.png';
  static const welcomeHands = '$_images/welcome_hand.png';
  static const sendPackageBanner = '$_images/send_package_banner.png';
  static const rider = '$_images/rider.png';
  static const safe = '$_images/safe.png';

  // Line-art icons. All are monochrome with alpha, so they can be tinted via
  // Image.asset(color: ...) to match the active/inactive nav state.
  static const iconHome = '$_icons/home.png';
  static const iconOrders = '$_icons/cube.png';
  static const iconSupport = '$_icons/support.png';
  static const iconProfile = '$_icons/profile.png';
  static const iconWallet = '$_icons/wallet.png';
}
