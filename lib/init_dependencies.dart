import 'package:blog_app/api/domain/graphql_client.dart';
import 'package:blog_app/api/infrastructure/graphql_client_impl.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/create_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/delete_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/update_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize the GraphQLClient
  final HttpLink httpLink = HttpLink(AppSecrets.backendUrl);
  final GraphQLClient graphQLClient = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  final appDocumentDirectory = await getApplicationDocumentsDirectory();

  Hive.init(appDocumentDirectory.path);

  // Open the Hive box
  var blogBox = await Hive.openBox('blogs');

  // Register the GraphQLClient
  serviceLocator.registerLazySingleton<GraphQLClient>(() => graphQLClient);

  // Register the GraphClient implementation
  serviceLocator.registerLazySingleton<GraphClient>(
    () => GraphClientImpl(client: serviceLocator<GraphQLClient>()),
  );

  // Register the opened Hive box
  serviceLocator.registerLazySingleton(() => blogBox);

  // serviceLocator.registerLazySingleton(() => Hive.box('blogs'));

  serviceLocator.registerFactory(() => InternetConnection());

  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(internetConnection: serviceLocator()));
  _initBlog();
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(graphClient: serviceLocator()))
    ..registerFactory<BlogLocalDataSource>(() => BlogLocalDataSourceImpl(serviceLocator()))
    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(serviceLocator(), serviceLocator(), serviceLocator()))
    // Usecase
    ..registerFactory(() => CreateBlog(serviceLocator()))
    ..registerFactory(() => FetchAllBlogs(serviceLocator()))
    ..registerFactory(() => DeleteBlog(serviceLocator()))
    ..registerFactory(() => UpdateBlog(serviceLocator()))
    //Bloc
    ..registerLazySingleton<BlogBloc>(
        () => BlogBloc(createBlog: serviceLocator(), fetchAllBlogs: serviceLocator(), deleteBlog: serviceLocator(), updateBlog: serviceLocator()));
}
