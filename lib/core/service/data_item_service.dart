import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:multiplat/core/model/data_item.dart';
import 'package:multiplat/core/model/history_item.dart';

class DataItemService {
  // change this value to true to load random data rather than from API endpoint
  static const USE_RANDOM_DATA = false;

  static const API_ENDPOINT =
      'https://my-json-server.typicode.com/flexi-creator/multiplat_db/contributors';

  List<DataItem> _items = [];

  /////////////// Random sample data ///////////

  final random = Random();

  final _groupColors = [0xffde92fb, 0xfffbde92, 0xff92f3fb, 0xffdaf7a6];

  final _firstNames = [
    'Saverin',
    'Kade',
    'Evvy',
    'Aden',
    'Darien',
    'Isai',
    'Hethe',
    'Dya',
    'Fron',
  ];

  final _lastNames = [
    'Volker',
    'Tenez',
    'Griffon',
    'Solus',
    'Wright',
    'Bryon',
    'Lynto',
  ];

  final _descriptions = [
    'To pizza and beyond',
    'Still to try that big leap',
    'What\'s not to love?',
    'Gimme more gadgets',
    'Maximum macrame madness',
    'Trekker to the core',
    'Looking for that next band'
  ];

  final _biographies = [
    'Aliquam rutrum dolor nisl, ac tempor mi sagittis sed. Duis urna turpis, malesuada a rhoncus nec, suscipit ac '
        'nibh. Suspendisse potenti.',
    'Proin faucibus egestas est ac tincidunt. Aenean mollis, ante sit amet blandit cursus, tortor felis imperdiet '
        'nulla, eget congue elit turpis at nibh.',
    'Eget enim sed dui commodo faucibus. Fusce ut turpis ut tellus tempus lacinia.'
  ];

  var _nextValues; // first name, last name, description

  /////////////// End random sample data ///////////

  Future<List<DataItem>> getData() async {
    if (_items.isEmpty) {
      if (USE_RANDOM_DATA) {
        _items = await getRandomData();
      } else {
        _items = await getServerData();
      }
    }
    return _items;
  }

  Future<List<DataItem>> getServerData() async {
    print('Fetching data from server $API_ENDPOINT');
    final response = await http.get(Uri.parse(API_ENDPOINT));
    print('response is ${response.body}');
    if (response.statusCode == 200 && response.contentLength! > 0) {
      return DataItem.fromJsonResponse(response.body);
    }

    return [];
  }

  Future<List<DataItem>> getRandomData() async {
    print('Generating random data');
    await Future.delayed(const Duration(seconds: 1)); // simulate server delay
    // This is provided in case the end point stops working for any reason.
    _nextValues = [0, 0, 0];
    // async so that a http call can be substituted
    final items = <DataItem>[];

    // This example creates random data locally. This is where you would replace with code to read data
    // from an API returning json

    /////// Random sample data ///////
    for (var i = 1; i <= 20; i++) {
      var imageUrl = 'https://i.pravatar.cc/200?img=${i + 7}';

      final historyData1 = [
        HistoryItem(0, random.nextInt(100)),
        HistoryItem(1, random.nextInt(100)),
        HistoryItem(2, random.nextInt(100)),
        HistoryItem(3, random.nextInt(100)),
      ];

      final historyData2 = [
        HistoryItem(0, (historyData1[0].historicalValue * 0.7).toInt()),
        HistoryItem(1, (historyData1[1].historicalValue * 0.7).toInt()),
        HistoryItem(2, (historyData1[2].historicalValue * 0.6).toInt()),
        HistoryItem(3, (historyData1[3].historicalValue * 0.5).toInt()),
      ];

      final historyData3 = [
        HistoryItem(0, (historyData2[0].historicalValue * 0.7).toInt()),
        HistoryItem(1, (historyData2[1].historicalValue * 0.5).toInt()),
        HistoryItem(2, (historyData2[2].historicalValue * 0.8).toInt()),
        HistoryItem(3, (historyData2[3].historicalValue * 0.9).toInt()),
      ];

      final histories = [
        historyData1,
        historyData2,
        historyData3,
      ];

      final bio = _biographies[i % 3];

      final groupColor = _groupColors[i % 4];

      items.add(DataItem(i, _title(), _description(), i * 7.5, imageUrl, bio,
          groupColor, histories));
    }
    return Future.value(items);
  }

  String _title() {
    return _firstNames[_nextValue(0)] + ' ' + _lastNames[_nextValue(1)];
  }

  String _description() {
    return _descriptions[_nextValue(2)];
  }

  int _nextValue(int which) {
    // Don't randomise the values so that the names will always be in order between runs,
    // to demonstrate shared_prefs at work.
    int maxVal = 0;
    if (which == 0) {
      maxVal = _firstNames.length;
    } else if (which == 1) {
      maxVal = _lastNames.length;
    } else if (which == 2) {
      maxVal = _descriptions.length;
    }
    var rand = _nextValues[which];
    rand++;
    if (rand >= maxVal) {
      rand = 0;
    }
    _nextValues[which] = rand;
    return rand;
  }
}
