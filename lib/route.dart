import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickfund/ui/Loan/categoriesOfLoan.dart';
import 'package:quickfund/ui/Loan/loanMain.dart';
import 'package:quickfund/ui/Loan/loanPage.dart';
import 'package:quickfund/ui/dashboard/bill/airtime.dart';
import 'package:quickfund/ui/dashboard/bill/bill_main.dart';
import 'package:quickfund/ui/dashboard/bill/cable/cable_main.dart';
import 'package:quickfund/ui/dashboard/dashboard.dart';
import 'package:quickfund/ui/dashboard/dashboardMain.dart';
import 'package:quickfund/ui/dashboard/fundAcct/fundAccountUI.dart';
import 'package:quickfund/ui/dashboard/transaction/saveBeneficiary.dart';
import 'package:quickfund/ui/dashboard/transaction/transactionRef.dart';
import 'package:quickfund/ui/dashboard/transaction/transactionUI.dart';
import 'package:quickfund/ui/onboarding/get_started.dart';
import 'package:quickfund/ui/onboarding/onboarding_ui.dart';
import 'package:quickfund/ui/onboarding/splashscreen.dart';
import 'package:quickfund/ui/quickHelp/help_ui.dart';
import 'package:quickfund/ui/signin/sign_in_main.dart';
import 'package:quickfund/ui/signup/account_opening/account_opening_ui.dart';
import 'package:quickfund/ui/signup/account_opening/account_ui.dart';
import 'package:quickfund/ui/signup/account_opening/review_details.dart';
import 'package:quickfund/ui/signup/account_opening/securityQuestionUI.dart';
import 'package:quickfund/ui/signup/register/registerUI.dart';
import 'package:quickfund/ui/signup/sign_up_main.dart';
import 'package:quickfund/util/app/app_route_name.dart';
import 'package:quickfund/widget/successPageForAirtimeData.dart';
import 'package:universal_platform/universal_platform.dart';

import 'ui/onboarding/welcomeui.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case AppRouteName.app:
        return _pageRoute(widget: SplashScreen(), settings: settings);
        break;

      case AppRouteName.welcome:
        return _pageRoute(widget: WelcomeQuickFund(), settings: settings);
        break;
      case AppRouteName.onboardingmain:
        return _pageRoute(settings: settings, widget: OnBoardingUI());
        break;
      case AppRouteName.getStarted:
        return _pageRoute(settings: settings, widget: GetStartedUI());
        break;
      case AppRouteName.LOG_IN:
        return _pageRoute(settings: settings, widget: SignInMain());
        break;
      case AppRouteName.DASHBOARD:
        return _pageRoute(settings: settings, widget: DashboardMain());
        break;
      case AppRouteName.getStartedUpdatedUI:
        return _pageRoute(settings: settings, widget: GetStartedUpdatedUI());
        break;
      case AppRouteName.HelpUI:
        return _pageRoute(settings: settings, widget: HelpUI());
        break;
      case AppRouteName.account_main:
        return _pageRoute(settings: settings, widget: AccountMain());
        break;
      case AppRouteName.ReviewDetails:
        return _pageRoute(settings: settings, widget: ReviewDetails());
        break;
      case AppRouteName.AccountOpeningUI:
        return _pageRoute(settings: settings, widget: AccountOpeningUI());
        break;
      case AppRouteName.SecurityQuestionUI:
        return _pageRoute(settings: settings, widget: SecurityQuestionUI());
        break;
      case AppRouteName.RegisterUI:
        return _pageRoute(settings: settings, widget: RegisterUI());
        break;
        case AppRouteName.BillMainUI:
        return _pageRoute(settings: settings, widget: BillMainUI());
        break;
        case AppRouteName.DashBoardMain:
        return _pageRoute(settings: settings, widget: DashBoardMain());
        break;
        case AppRouteName.FundAccountUI:
        return _pageRoute(settings: settings, widget: FundAccountUI());
        break;
        case AppRouteName.TransactionUI:
        return _pageRoute(settings: settings, widget: TransactionUI());
        break;
        case AppRouteName.TransactionRef:
        return _pageRoute(settings: settings, widget: TransactionRef());
        break;
        case AppRouteName.SaveBeneficiary:
        return _pageRoute(settings: settings, widget: SaveBeneficiary());
        break;
        case AppRouteName.LoanMainUI:
        return _pageRoute(settings: settings, widget: LoanMainUI());
        break;
        case AppRouteName.CategoriesOfLoanUI:
        return _pageRoute(settings: settings, widget: CategoriesOfLoanUI());
        break;
        case AppRouteName.LoanPageUI:
        return _pageRoute(settings: settings, widget: LoanPageUI());
        break;
        case AppRouteName.AirtimeUI:
        return _pageRoute(settings: settings, widget: AirtimeUI());
        break;
        case AppRouteName.SuccessPage:
        return _pageRoute(settings: settings, widget: SuccessPage());
        break;
      case AppRouteName.CableMain:
        return _pageRoute(settings: settings, widget: CableMain());

      default:
        return _errorRoute(
          settings: settings,
        );
    }
  }

  static Route<dynamic> _errorRoute({@required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings,
        builder: (_) {
          if (UniversalPlatform.isAndroid) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
                centerTitle: true,
              ),
            );
          } else if (UniversalPlatform.isIOS) {
            return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Error'),
                ),
                child: Center(child: Text('Hi')));
          } else {
            return Center(
              child: Text('Invalid Device'),
            );
          }
        });
  }
}

PageRoute _pageRoute(
    {@required RouteSettings settings, @required Widget widget}) {
  if (UniversalPlatform.isAndroid) {
    return MaterialPageRoute(settings: settings, builder: (_) => widget);
  } else if (UniversalPlatform.isIOS) {
    return CupertinoPageRoute(settings: settings, builder: (_) => widget);
  } else {
    return MaterialPageRoute(settings: settings, builder: (_) => widget);
  }
}
