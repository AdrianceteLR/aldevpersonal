import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/finance/finance_movement_model.dart';
import '../../widgets/enhanced_bar_chart.dart';
import '../../widgets/expense_chart.dart';

class FinanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener movimientos del usuario
  Stream<List<FinanceMovement>> getMovements(String userId) {
    return _firestore
        .collection('finance_movements')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final movements = snapshot.docs
              .map((doc) => FinanceMovement.fromJson({
                    ...doc.data(),
                    'id': doc.id,
                    'date': (doc.data()['date'] as Timestamp).toDate().toIso8601String(),
                    'createdAt': doc.data()['createdAt'] != null
                        ? (doc.data()['createdAt'] as Timestamp).toDate().toIso8601String()
                        : null,
                    'updatedAt': doc.data()['updatedAt'] != null
                        ? (doc.data()['updatedAt'] as Timestamp).toDate().toIso8601String()
                        : null,
                  }))
              .toList();
          
          // Ordenar por fecha en el cliente
          movements.sort((a, b) => b.date.compareTo(a.date));
          return movements;
        });
  }

  // Obtener movimientos paginados
  Future<List<FinanceMovement>> getMovementsPaginated(
    String userId, {
    DocumentSnapshot? lastDocument,
    int limit = 20,
  }) async {
    Query query = _firestore
        .collection('finance_movements')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();
    
    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return FinanceMovement.fromJson({
            ...data,
            'id': doc.id,
            'date': (data['date'] as Timestamp).toDate().toIso8601String(),
            'createdAt': data['createdAt'] != null
                ? (data['createdAt'] as Timestamp).toDate().toIso8601String()
                : null,
            'updatedAt': data['updatedAt'] != null
                ? (data['updatedAt'] as Timestamp).toDate().toIso8601String()
                : null,
          });
        })
        .toList();
  }

  // Agregar movimiento
  Future<void> addMovement(FinanceMovement movement) async {
    await _firestore.collection('finance_movements').add({
      'userId': movement.userId,
      'title': movement.title,
      'amount': movement.amount,
      'type': movement.type.name,
      'category': movement.category.name,
      'description': movement.description,
      'date': Timestamp.fromDate(movement.date),
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Actualizar movimiento
  Future<void> updateMovement(FinanceMovement movement) async {
    await _firestore.collection('finance_movements').doc(movement.id).update({
      'title': movement.title,
      'amount': movement.amount,
      'type': movement.type.name,
      'category': movement.category.name,
      'description': movement.description,
      'date': Timestamp.fromDate(movement.date),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Eliminar movimiento
  Future<void> deleteMovement(String movementId) async {
    await _firestore.collection('finance_movements').doc(movementId).delete();
  }

  // Obtener resumen financiero
  Future<Map<String, double>> getFinancialSummary(String userId, String period) async {
    final now = DateTime.now();
    DateTime startDate;
    
    switch (period) {
      case 'Esta semana':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'Este mes':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Este año':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        startDate = DateTime(now.year, now.month, 1);
    }
    final snapshot = await _firestore
        .collection('finance_movements')
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .get();

    double totalIncome = 0;
    double totalExpense = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final amount = (data['amount'] as num).toDouble();
      final type = data['type'] as String;

      if (type == 'income') {
        totalIncome += amount;
      } else {
        totalExpense += amount;
      }
    }

    return {
      'income': totalIncome,
      'expense': totalExpense,
      'balance': totalIncome - totalExpense,
    };
  }

  // Obtener datos para gráfico de barras por mes
  Future<Map<String, List<double>>> getMonthlyData(String userId, String period) async {
    final now = DateTime.now();
    DateTime startDate;
    
    switch (period) {
      case 'Esta semana':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'Este mes':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Este año':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        startDate = DateTime(now.year, now.month - 5, 1);
    }
    
    final snapshot = await _firestore
        .collection('finance_movements')
        .where('userId', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .get();

    Map<int, double> monthlyIncome = {};
    Map<int, double> monthlyExpense = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final amount = (data['amount'] as num).toDouble();
      final type = data['type'] as String;
      final date = (data['date'] as Timestamp).toDate();
      final monthKey = date.year * 100 + date.month;

      if (type == 'income') {
        monthlyIncome[monthKey] = (monthlyIncome[monthKey] ?? 0) + amount;
      } else {
        monthlyExpense[monthKey] = (monthlyExpense[monthKey] ?? 0) + amount;
      }
    }

    List<double> incomeData = [];
    List<double> expenseData = [];

    for (int i = 5; i >= 0; i--) {
      final targetDate = DateTime(now.year, now.month - i, 1);
      final monthKey = targetDate.year * 100 + targetDate.month;
      
      incomeData.add(monthlyIncome[monthKey] ?? 0);
      expenseData.add(monthlyExpense[monthKey] ?? 0);
    }

    return {
      'income': incomeData,
      'expense': expenseData,
    };
  }

  // Obtener datos para gráfico de gastos por categoría
  Future<Map<String, double>> getCategoryExpenses(String userId, String period) async {
    final now = DateTime.now();
    DateTime startDate;
    
    switch (period) {
      case 'Esta semana':
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'Este mes':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Este año':
        startDate = DateTime(now.year, 1, 1);
        break;
      default:
        startDate = DateTime(now.year, now.month, 1);
    }
    final snapshot = await _firestore
        .collection('finance_movements')
        .where('userId', isEqualTo: userId)
        .where('type', isEqualTo: 'expense')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .get();

    Map<String, double> categoryTotals = {};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final amount = (data['amount'] as num).toDouble();
      final category = data['category'] as String;
      
      categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
    }

    return categoryTotals;
  }
}