import 'package:flutter/material.dart';
import 'package:multiplat/core/model/data_item.dart';
import 'package:multiplat/core/viewmodel/item_detail_viewmodel.dart';
import 'package:multiplat/ui/view/base_view.dart';

class ItemDetailView extends StatefulWidget {
  final bool combinedView;

  ItemDetailView({this.combinedView = false});

  @override
  _ItemDetailViewState createState() => _ItemDetailViewState(combinedView);
}

class _ItemDetailViewState extends State<ItemDetailView> {
  final bool combinedView;

  _ItemDetailViewState(this.combinedView);

  @override
  Widget build(BuildContext context) {
    return BaseView<ItemDetailViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => _buildContent(model),
    );
  }

  Scaffold _buildContent(ItemDetailViewModel model) {
    final dataItem = model.getSelectedItem();
    return Scaffold(
      appBar: combinedView
          ? null
          : AppBar(
              title: Text(dataItem.title),
            ),
      body: _body(dataItem),
    );
  }

  Widget _body(DataItem dataItem) {
    if (dataItem != null) {
      return Container(
          padding: EdgeInsets.all(5),
          color: Color(0xffddffdd),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ListView(children: [
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CircleAvatar(
                  backgroundColor: Color(0x1f000000),
                  radius: 75,
                  backgroundImage: NetworkImage(
                    dataItem.imageUrl,
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _title(dataItem),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(dataItem.description, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('Rating: ${dataItem.value}'),
                      ),
                    ],
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(dataItem.bio),
              ),
              _chartNavButton(),
            ]),
          ));
    } else {
      return Container(color: Color(0xffddffdd));
    }
  }

  Widget _title(DataItem dataItem) {
    if (combinedView) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Text(dataItem.title, style: TextStyle(fontWeight: FontWeight.bold), textScaleFactor: 1.2),
      );
    } else {
      return Container();
    }
  }

  Widget _chartNavButton() {
    if (combinedView) {
      return Container();
    } else {
      return RaisedButton(
        color: Colors.blueGrey,
        child: Text(
          'Show contributions',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "chart");
        },
      );
    }
  }
}
