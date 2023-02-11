import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futureprovider/model/fatmodel.dart';

final httpClientProvider =
    Provider<Dio>((ref) => Dio(BaseOptions(baseUrl: 'https://catfact.ninja/')));

final catFactsProvider = FutureProvider.family<List<FactModel>, Map<String,dynamic>> ((ref, parameterApi) async {
  final dio = ref.watch(httpClientProvider);
  final result = await dio.get('facts',  queryParameters: parameterApi
  // queryParameters: 
  // {
  //   'limit':10,
  //   'max_length':40,
  // }
  );
  List<Map<String, dynamic>> data = List.from(result.data['data']);

  List<FactModel> modelData = data.map((e) => FactModel.fromJson(e)).toList();

  return modelData;
});

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final readMe = ref.watch(catFactsProvider(const {'limit': 6, 'max_length': 30}));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
        child: Container(
            child: readMe.when(
                data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Text(data[index].toString()),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
                error: (err, stack) => Text(err.toString()),
                loading: () => const CircularProgressIndicator())),
      ),
    );
  }
}
