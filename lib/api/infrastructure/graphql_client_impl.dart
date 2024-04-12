import 'package:blog_app/api/domain/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphClientImpl implements GraphClient {
  final GraphQLClient client;

  GraphClientImpl({required this.client});

  @override
  Future<QueryResult> query(String gqlQuery, {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(
      document: gql(gqlQuery),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await client.query(options);
  }

  @override
  Future<QueryResult> mutate(String gqlMutation, {Map<String, dynamic>? variables}) async {
    final options = MutationOptions(
      document: gql(gqlMutation),
      variables: variables!,
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await client.mutate(options);
  }
}
