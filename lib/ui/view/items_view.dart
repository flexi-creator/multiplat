import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/core/enum/viewstate.dart';
import 'package:multiplat/core/viewmodel/items_viewmodel.dart';
import 'package:multiplat/ui/view/base_view.dart';

class ItemsView extends StatefulWidget {
  final bool combinedView;

  ItemsView({this.combinedView = false});

  @override
  _ItemsViewState createState() => _ItemsViewState(combinedView);
}

class _ItemsViewState extends State<ItemsView> {
  final bool combinedView;

  _ItemsViewState(this.combinedView);

  @override
  Widget build(BuildContext context) {
    return BaseView<ItemsViewModel>(
      onModelReady: (model) => model.getData(),
      builder: (context, model, child) => Scaffold(
        appBar: combinedView ? null : AppBar(title: Text('Top contributors')),
        body: _listItems(model),
      ),
    );
  }

  Container _listItems(ItemsViewModel model) {
    return Container(
      color: Color(0xffddddff),
      child: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            combinedView
                ? Padding(
                    padding: EdgeInsets.only(top: !kIsWeb && (Platform.isIOS || Platform.isAndroid) ? 30.0 : 10.0),
                    child: Text(
                      'Top contributors',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor: 1.2,
                    ),
                  )
                : Container(),
            Expanded(
              child: ListView.builder(
                itemCount: model.getItemCount(),
                itemBuilder: (BuildContext itemContext, int index) => _buildItem(itemContext, model, index),
              ),
            ),
          ],
        ),
        model.state == ViewState.Busy
            ? Center(
                child: SizedBox(height: 50, width: 50, child: !kIsWeb && (Platform.isIOS || Platform.isMacOS) ?
                    CupertinoActivityIndicator(): CircularProgressIndicator()),
              )
            : Container(),
      ]),
    );
  }

  Widget _buildItem(BuildContext itemContext, ItemsViewModel model, int index) {
    final item = model.getItemAt(index);
    return Card(
        margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
        color: Color(item.groupColor),
        child: InkWell(
          splashColor: Colors.blueGrey.withAlpha(30),
          onTap: () {
            _itemTapped(model, index);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0x1f000000),
                  backgroundImage: NetworkImage(
                    item.imageUrl,
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor: 1.2,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(item.description),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _itemTapped(ItemsViewModel model, int index) {
    model.itemSelected(index);
    if (combinedView) {
    } else {
      Navigator.pushNamed(context, "detail");
    }
  }
}
