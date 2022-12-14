// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "Hello ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "approve": MessageLookupByLibrary.simpleMessage("Approve"),
        "empty_message": MessageLookupByLibrary.simpleMessage("Empty message"),
        "forgot_password":
            MessageLookupByLibrary.simpleMessage("Forgot password ?"),
        "hello": m0,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "input_here": MessageLookupByLibrary.simpleMessage("Input here"),
        "login": MessageLookupByLibrary.simpleMessage("Sign in"),
        "login_error": MessageLookupByLibrary.simpleMessage("Login error"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "please_input_you_email":
            MessageLookupByLibrary.simpleMessage("Please input you email"),
        "please_input_you_password":
            MessageLookupByLibrary.simpleMessage("Please input you password"),
        "send": MessageLookupByLibrary.simpleMessage("Send")
      };
}
