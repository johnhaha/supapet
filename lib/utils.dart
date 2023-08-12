import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient get supabaseClient => Supabase.instance.client;
late SharedPreferences prefs;

Future initEnv() async {
  await dotenv.load(fileName: ".env");
}

Future initDatabase() async {
  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    debug: false,
  );
}

Future initSharedPrefs() async {
  prefs = await SharedPreferences.getInstance();
}
