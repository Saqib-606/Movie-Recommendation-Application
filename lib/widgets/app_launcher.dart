import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLauncher {
  static Future<void> launchFeedback(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: "mailto", 
      path: "saqi10606@gmail.com",
      queryParameters: {
        "subject": "Feedback",
      },
    );
    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unable to open email app"),
        ),
      );
    }
  }

  static Future<void> shareApp() async {
    await SharePlus.instance.share(
      ShareParams(
        text: '''
        🎬 Check out my Movie Recommendation App built with Flutter!
        
        This app lets you discover popular movies, search for titles, manage favorites, and create your watchlist.

        GitHub Repository:
        https://github.com/Saqib-606/Movie-Recommendation-Application
      ''',
      ),
    );
  }
}