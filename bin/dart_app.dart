import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  // Login Function
  stdout.write("===== Login =====\nUsername: ");
  String username = stdin.readLineSync()!;
  stdout.write("Password: ");
  String password = stdin.readLineSync()!;

  var loginRes = await http.post(
    Uri.parse("http://localhost:3000/login"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"username": username, "password": password}),
  );

  if (loginRes.statusCode == 200) {
    final loginData = jsonDecode(loginRes.body);
    final userId = loginData['id'];
    final username = loginData['username'];

    print("\n=========== Expense Tracking App =========");
    print("Welcome $username\n");
      // menu feature
        while (true) {
      print("1. All expenses");
      print("2. Today's expense");
      print("3. Search expense");
      print("4. Add new expense");
      print("5. Delete an expense");
      print("6. Exit");
      stdout.write("Choose: ");
      String? choice = stdin.readLineSync();

  // menu feature
      
      // 1. Show all
      if (choice == "1") {
        // Show all
        var res = await http.get(Uri.parse("http://localhost:3000/expenses"));
        var expenses = jsonDecode(res.body);
        showExpenses (expenses);
      } 
        // 2. Today's expense
      else if (choice == "2") {
        // Today's expense
        var res = await http.get(
          Uri.parse("http://localhost:3000/expenses/today"),
        );
        var expenses = jsonDecode(res.body);
        showExpenses(expenses);
      }
        // 3. Search expense
      
        // 4. Add new expense

        // 5. Delete an expense
        
        // 6. Exit

      }
  } else {
    print("Login failed: ${loginRes.body}");
  }
  
}

void showExpenses(List<dynamic> expenses) {
  int total = 0;
  print("----------- Expenses -----------");
  for (var e in expenses) {
    print("${e['item']} : ${e['paid']}฿ : ${e['date']}");
    total += e['paid'] as int;
  }
  print("Total expenses = ${total}฿\n");
}

