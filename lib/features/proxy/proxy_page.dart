import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/core/presentation/routes/app_router.dart';
import 'package:loopcare_frontend/core/presentation/widgets/scrollable_container.dart';
import 'package:loopcare_frontend/core/presentation/widgets/main_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProxyPage extends StatefulWidget {
  const ProxyPage({Key? key}) : super(key: key);

  @override
  State<ProxyPage> createState() => _ProxyPageState();
}

class _ProxyPageState extends State<ProxyPage> {
  final _ipController = TextEditingController();
  final _portController = TextEditingController();

  @override
  void dispose() {
    _ipController.dispose();
    _portController.dispose();
    super.dispose();
  }

  _onPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('_ip', _ipController.text);
    prefs.setString('_port', _portController.text);

    // context.router.pushNamed(AppRoutes.intro);
    context.router.pushNamed(AppRoutes.selfHelpIntro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollableContainer(
          child: MainContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    children: [
                      TextField(
                        controller: _ipController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter proxy ip',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: _portController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter proxy port',
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton(
                        onPressed: _onPressed,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
