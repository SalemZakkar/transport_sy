class KCard {
  final int id;
  final String number;
  final int balance;
  final int userId;

  KCard({
    required this.id,
    required this.number,
    required this.balance,
    required this.userId,
  });

  @override
  String toString() => 'Card(****${number.substring(number.length - 4)})';
}

List<KCard> cards = [
  KCard(id: 1, number: "1113345", balance: 20000, userId: 1),
  KCard(id: 2, number: "5436456", balance: 43532, userId: 1),
  KCard(id: 3, number: "456543", balance: 3321345, userId: 1),
  KCard(id: 4, number: "25464312", balance: 23421, userId: 1),
  KCard(id: 5, number: "434374", balance: 3233, userId: 1),
  KCard(id: 6, number: "3462134", balance: 24325, userId: 0),
  KCard(id: 7, number: "456425", balance: 34235, userId: 0),
  KCard(id: 8, number: "3433233214", balance: 333345, userId: 0),
  KCard(id: 9, number: "3452423", balance: 4525312, userId: 0),
  KCard(id: 10, number: "9327540", balance: 345324, userId: 0),
];
