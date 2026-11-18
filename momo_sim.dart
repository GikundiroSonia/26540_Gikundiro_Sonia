// Student: Gikundiro Sonia
// Reg no: 26540
const String regNo = '26540';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int momoFee(int amount) {
  // by GS
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String formatRwf(int amount) {
  // by GS
  final negative = amount < 0;
  String digits = amount.abs().toString();
  String result = '';
  int i = 0;
  while (i < digits.length) {
    if (i > 0 && (digits.length - i) % 3 == 0) result += ',';
    result += digits[i];
    i++;
  }
  return '${negative ? '-' : ''}$result RWF';
}

bool isValidPin(String pin) {
  // by GS
  if (pin.length != 5 || pin == '12345') return false;
  int i = 0;
  while (i < pin.length) {
    if (int.tryParse(pin[i]) == null) return false;
    i++;
  }
  if (pin[0] == pin[1] &&
      pin[1] == pin[2] &&
      pin[2] == pin[3] &&
      pin[3] == pin[4]) return false;
  return true;
}

int sendMoney(int balance, int amount) {
  // by GS
  final fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  final newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

int buyAirtime(int balance, int amount) {
  // by GS
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime amount must be from 100 to 50,000 RWF');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance for airtime');
    return balance;
  }
  final newBalance = balance - amount;
  print('Bought airtime ${formatRwf(amount)}. New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by GS
  print('Reg no: $regNo | D = $d | T = $t');
  print(isValidPin('12345'));
  print(isValidPin('77777'));
  print(isValidPin('4821'));
  print(isValidPin('48a21'));
  print(isValidPin('4821$d'));

  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');
  int i = 0;
  while (i < 3) {
    balance = sendMoney(balance, (d + 1) * 3000);
    i++;
  }
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);
  print('Final balance: ${formatRwf(balance)}');

  // Extra tests and expected outputs:
  print(formatRwf(0));        // 0 RWF
  print(formatRwf(999));      // 999 RWF
  print(formatRwf(1000));     // 1,000 RWF
  print(formatRwf(-5000));    // -5,000 RWF
  print(isValidPin('24680')); // true
  print(isValidPin('00000')); // false
}
