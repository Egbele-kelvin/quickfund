class OnboardingPage {
  final String backgroundImage;
  final String title;
  final String description;

  const OnboardingPage({this.backgroundImage, this.title, this.description});
}

class OnboardingPageItems {
  static List<OnboardingPage> getOnboardingPages() {
    const fi = <OnboardingPage>[
      OnboardingPage(
          backgroundImage: 'assets/f_png/bg_1.png',
          title: 'Get easy and fast loans.',
          description:
              'Get your loan in a few simple steps, from the comfort of your smartphone!'),
      OnboardingPage(
          backgroundImage: 'assets/f_png/bg_2.png',
          title: 'Grow your business and fund your needs.',
          description:
              'Get your loan in a few simple steps, from the comfort of your smartphone!'),
      OnboardingPage(
          backgroundImage: 'assets/f_png/bg-3.png',
          title: 'Flexible and convenient repayment.',
          description:
              'Paying back loans are easier than ever, with our flexible payment methods for everyone.'),
    ];

    return fi;
  }
}
