import 'package:graphql_flutter/graphql_flutter.dart';

abstract class GraphClient {
  Future<QueryResult> query(String gqlQuery, {Map<String, dynamic>? variables});
  Future<QueryResult> mutate(String gqlMutation, {Map<String, dynamic>? variables});
}
