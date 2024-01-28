class Concept {
  String? id;
  String? name;
  //naturaleza
  bool isCredit = false;
  bool isDebit = false;
  //tipo
  //ingreso
  bool isIncome = false;
  //gasto
  bool isSpent = false;
  bool isCost = false;
  //concepto transaccion
  bool isTransaction = false;

  Concept({
    this.id,
    this.name,
    this.isCredit = false,
    this.isDebit = false,
    this.isCost = false,
    this.isIncome = false,
    this.isSpent = false,
    this.isTransaction = false,
  });

  Concept.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isCost = json['is_cost'];
    isDebit = json['is_debit'];
    isCredit = json['is_credit'];
    isIncome = json['is_income'];
    isSpent = json['is_spent'];
    isTransaction = json['is_transaction'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['is_cost'] = isCost;
    data['is_debit'] = isDebit;
    data['is_credit'] = isCredit;
    data['is_income'] = isIncome;
    data['is_spent'] = isSpent;
    data['is_transaction'] = isTransaction;
    return data;
  }
}
