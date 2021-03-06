import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/common/data/model/result.dart';
import 'package:flutter_project_template/feature/dashboard_main/dashboard_page.dart';
import 'package:flutter_project_template/feature/login/bloc/login_bloc.dart';
import 'package:flutter_project_template/feature/signup/signup_page.dart';
import 'package:flutter_project_template/util/logger.dart';
import 'package:flutter_project_template/util/ui_utils.dart';
import 'package:flutter_project_template/widget/input_field.dart';
import 'package:flutter_project_template/widget/multi_state_widget.dart';

class LoginPage extends StatelessWidget {
  static const ROUTE = "/login";

  LoginPage({Key? key}) : super(key: key);

  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(16),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/icons/app_logo.png',
                height: 110.0,
                width: 110.0,
              ),
              BlocProvider<LoginBloc>(
                create: (_) => LoginBloc(),
                child: BlocConsumer<LoginBloc, LoginState>(
                  builder: _buildWidgetForState,
                  listener: _listenToLoginState,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _listenToLoginState(BuildContext context, LoginState state) {
    Log.info(state.runtimeType);
    if (state is LoginSuccessState) {
      Future.delayed(Duration.zero).then((value) => Navigator.of(context)
          .pushNamedAndRemoveUntil(DashboardScreen.ROUTE, (route) => false));
    } else if (state is LoginFailedState) {
      final error = state.data as Error;
      if (error.showSnackBar == true && error.info?.message != null) {
        showSnackbar(context, Text(error.info!.message!));
      }
    }
  }

  Widget _buildWidgetForState(BuildContext context, LoginState state) {
    int widgetState = MultiStateWidget.Content;
    Widget? child;

    if (state is LoginLoadingState) {
      widgetState = MultiStateWidget.Loading;
    } else {
      child = _createContent(context);
    }

    return MultiStateWidget(
      state: widgetState,
      contentWidget: child,
    );
  }

  Widget _createContent(BuildContext context) {
    return Column(
      children: [
        _createEmailPassLoginForm(context),
        SizedBox(height: 12),
        _createSignUpButton(context),
      ],
    );
  }

  Widget _createEmailPassLoginForm(BuildContext context) {
    _passwordEditingController.clear();
    return FractionallySizedBox(
      widthFactor: .3,
      child: Column(
        children: [
          CredentialInputWidget(
            textEditingController: _emailEditingController,
            hint: 'Email',
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(Icons.email),
          ),
          SizedBox(height: 12),
          CredentialInputWidget(
            textEditingController: _passwordEditingController,
            hint: 'Password',
            textInputAction: TextInputAction.done,
            prefixIcon: Icon(Icons.lock),
            obscureText: true,
          ),
          SizedBox(height: 12),
          SubmitButton(
            text: 'Login',
            onPressed: () {
              final loginBloc = BlocProvider.of<LoginBloc>(context);
              loginBloc.add(
                LoginWithEmailPassEvent(_emailEditingController.text,
                    _passwordEditingController.text),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createSignUpButton(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('  '),
        ],
      ),
    );
  }
}
