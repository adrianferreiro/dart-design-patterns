class Query {
  final String table;
  final List<String> fields;
  final List<String> conditions;
  final List<String> orderFields;
  final int? limitCount;

  const Query({
    required this.table,
    required this.fields,
    required this.conditions,
    required this.orderFields,
    this.limitCount,
  });

  String buildSQL() {
    final selectFields = fields.isNotEmpty ? fields.join(', ') : '*';
    final whereClause =
        conditions.isNotEmpty ? 'WHERE ${conditions.join(' AND ')}' : '';
    final orderByClause =
        orderFields.isNotEmpty ? 'ORDER BY ${orderFields.join(', ')}' : '';
    final limitClause = limitCount != null ? 'LIMIT $limitCount' : '';

    return 'SELECT $selectFields FROM $table $whereClause $orderByClause $limitClause;'
        .trim();
  }

  @override
  String toString() => buildSQL();
}

class QueryBuilder {
  String _table;
  final List<String> _fields = [];
  final List<String> _conditions = [];
  final List<String> _orderFields = [];
  int? _limitCount;

  QueryBuilder(this._table);

  QueryBuilder select(List<String> fields) {
    _fields.clear();
    _fields.addAll(fields);
    return this;
  }

  QueryBuilder where(String condition) {
    _conditions.add(condition);
    return this;
  }

  QueryBuilder orderBy(String field, [String direction = 'ASC']) {
    _orderFields.add('$field $direction');
    return this;
  }

  QueryBuilder limit(int count) {
    _limitCount = count;
    return this;
  }

  Query build() => Query(
    table: _table,
    fields: _fields,
    conditions: _conditions,
    orderFields: _orderFields,
    limitCount: _limitCount,
  );
}

void main() {
  final query =
      QueryBuilder('users')
          .select(['id', 'name', 'email'])
          .where('age > 18')
          .where("country = 'Cri'")
          .orderBy('name', 'ASC')
          .limit(10)
          .build();

  print('Consulta SQL:\n$query');
}
