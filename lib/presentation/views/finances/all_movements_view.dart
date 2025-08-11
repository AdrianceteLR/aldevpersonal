import 'package:aldevpersonal/domain/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../domain/models/finance/finance_movement_model.dart';
import '../../../domain/providers/finance_provider.dart';
import '../../../services/finance/finance_service.dart';
import '../../theme/app_colors.dart';
import 'components_finances/finances_dialogs.dart';

class AllMovementsView extends ConsumerStatefulWidget {
  const AllMovementsView({super.key});

  @override
  ConsumerState<AllMovementsView> createState() => _AllMovementsViewState();
}

class _AllMovementsViewState extends ConsumerState<AllMovementsView> {
  final List<FinanceMovement> _movements = [];
  final ScrollController _scrollController = ScrollController();
  DocumentSnapshot? _lastDocument;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadInitialMovements();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _loadMoreMovements();
    }
  }

  Future<void> _loadInitialMovements() async {
    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('finance_movements')
          .where('userId', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .limit(20)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
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

        setState(() {
          _movements.addAll(movements);
          _hasMore = snapshot.docs.length == 20;
        });
      } else {
        setState(() => _hasMore = false);
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMoreMovements() async {
    if (_isLoading || !_hasMore) return;

    final user = ref.read(currentUserProvider);
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('finance_movements')
          .where('userId', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .startAfterDocument(_lastDocument!)
          .limit(20)
          .get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
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

        setState(() {
          _movements.addAll(movements);
          _hasMore = snapshot.docs.length == 20;
        });
      } else {
        setState(() => _hasMore = false);
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.background : Colors.grey[50],
      appBar: AppBar(
        title: const Text('Todos los Movimientos'),
        backgroundColor: isDark ? AppColors.surface : Colors.white,
        foregroundColor: isDark ? AppColors.textPrimary : Colors.black87,
        elevation: 1,
      ),
      body: _movements.isEmpty && !_isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long,
                    size: 64,
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay movimientos',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? AppColors.textSecondary : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Agrega tu primer movimiento',
                    style: TextStyle(
                      color: isDark ? AppColors.textSecondary : Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _movements.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _movements.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final movement = _movements[index];
                return _buildMovementCard(context, movement, isDark);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FinancesDialogs.showAddMovementDialog(context, ref),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildMovementCard(BuildContext context, FinanceMovement movement, bool isDark) {
    final isIncome = movement.type == MovementType.income;
    final color = isIncome ? AppColors.success : AppColors.danger;

    return Card(
      color: isDark ? AppColors.surface : Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Dismissible(
        key: Key(movement.id),
        background: Container(
          color: AppColors.danger,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: AppColors.textPrimary),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _deleteMovement(movement.id, movement),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getCategoryIcon(movement.category),
              color: color,
              size: 24,
            ),
          ),
          title: Text(
            movement.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textPrimary : Colors.black87,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movement.category.displayName,
                style: TextStyle(
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
              ),
              if (movement.description != null) ...[
                const SizedBox(height: 4),
                Text(
                  movement.description!,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondary : Colors.black54,
                  ),
                ),
              ],
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : '-'}${movement.amount.toStringAsFixed(0)}€',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
              ),
              Text(
                _formatDate(movement.date),
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColors.textSecondary : Colors.black54,
                ),
              ),
            ],
          ),
          onTap: () => FinancesDialogs.showEditMovementDialog(context, ref, movement),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(MovementCategory category) {
    switch (category) {
      case MovementCategory.salary:
        return Icons.work;
      case MovementCategory.food:
        return Icons.restaurant;
      case MovementCategory.transport:
        return Icons.directions_car;
      case MovementCategory.entertainment:
        return Icons.movie;
      case MovementCategory.shopping:
        return Icons.shopping_cart;
      case MovementCategory.bills:
        return Icons.receipt;
      case MovementCategory.rent:
        return Icons.home;
      case MovementCategory.health:
        return Icons.local_hospital;
      default:
        return Icons.account_balance_wallet;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    
    if (diff == 0) return 'Hoy';
    if (diff == 1) return 'Ayer';
    if (diff < 7) return '$diff días';
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _deleteMovement(String movementId, FinanceMovement movement) async {
    try {
      await ref.read(financeActionsProvider).deleteMovement(movementId);
      setState(() {
        _movements.removeWhere((m) => m.id == movementId);
      });
    } catch (e) {
      // Error handling
    }
  }
}