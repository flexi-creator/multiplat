import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplat/core/model/data_item.dart';
import 'package:multiplat/core/util/platform_util.dart';
import 'package:multiplat/core/viewmodel/item_detail_viewmodel.dart';
import 'package:multiplat/ui/view/base_view.dart';

class ItemDetailView extends StatefulWidget {
  final bool combinedView;

  const ItemDetailView({Key? key, this.combinedView = false}) : super(key: key);

  @override
  _ItemDetailViewState createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ItemDetailViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => _buildContent(model),
    );
  }

  Widget _buildContent(ItemDetailViewModel model) {
    final dataItem = model.getSelectedItem();
    if (dataItem == null) {
      return Container(color: const Color(0xffddffdd));
    }
    if (isCupertino()) {
      return CupertinoPageScaffold(
        navigationBar: widget.combinedView
            ? null
            : CupertinoNavigationBar(
                middle: Text(dataItem.title),
              ),
        child: _body(dataItem),
      );
    }
    return Scaffold(
      appBar: widget.combinedView
          ? null
          : AppBar(
              title: Text(dataItem.title),
            ),
      body: _body(dataItem),
    );
  }

  Widget _body(DataItem dataItem) {
    return Container(
        padding: const EdgeInsets.all(5),
        color: const Color(0xffddffdd),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: ListView(controller: ScrollController(), children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Hero(
                tag: 'heroImageD${dataItem.title}${dataItem.id}',
                child: CircleAvatar(
                  backgroundColor: const Color(0x1f000000),
                  radius: 75,
                  backgroundImage: NetworkImage(
                    dataItem.imageUrl,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _title(dataItem),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(dataItem.description,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
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
  }

  Widget _title(DataItem dataItem) {
    if (widget.combinedView) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Text(dataItem.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.2),
      );
    } else {
      return Container();
    }
  }

  Widget _chartNavButton() {
    if (widget.combinedView) {
      return Container();
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
        child: const Text(
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
