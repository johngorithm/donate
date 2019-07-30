import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_state/model/donation.dart';
import 'package:cached_network_image/cached_network_image.dart';

const kOrangePrimary = Colors.deepOrangeAccent;

class DonationScreen extends StatefulWidget {
  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: kOrangePrimary,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://images.unsplash.com/photo-1537151608828-ea2b11777ee8?ixlib=rb-1.2.1&auto=format&fit=crop&w=639&q=80',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            shadowColor: Color(0x802196F3),
            child: _buildInitContent(),
          )
        ],
      ),
    );
  }

  Widget _buildInitContent() {
    Donation donationModel =
        ScopedModel.of<Donation>(context, rebuildOnChange: true);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300.0,
        child: !donationModel.hasSubmitted
            ? Column(
                children: <Widget>[
                  _titleContainer(),
                  _priceContainer(),
                  SizedBox(
                    height: 15.0,
                  ),
                  _bottomButton(
                    onPress: donationModel.donate,
                    icon: Icons.sentiment_satisfied,
                    btnText: 'DONATE',
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _messageContainer(),
                  SizedBox(
                    height: 50.0,
                  ),
                  _bottomButton(
                    onPress: donationModel.donateAgain,
                    icon: Icons.thumb_up,
                    btnText: 'DONATE AGAIN',
                  ),
                ],
              ),
      ),
    );
  }

  Widget _messageContainer() {
    Donation donationModel =
        ScopedModel.of<Donation>(context, rebuildOnChange: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'THANK YOU!',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          'Thanks for donation \$${donationModel.amount}',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }

  /// Title Widget
  Widget _titleContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10.0, left: 20.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'STEWARD',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Dogs are helpful, not painful',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 10.0,
          ),
          child: ScopedModelDescendant<Donation>(
            builder: (context, child, model) => RawMaterialButton(
              shape: CircleBorder(),
              constraints: BoxConstraints.tightFor(height: 50.0, width: 50.0),
              onPressed: model.resetAmount,
              child: Icon(
                Icons.close,
                size: 30,
                color: kOrangePrimary,
              ),
            ),
          ),
        )
      ],
    );
  }

  /// Price view Widget
  Widget _priceContainer() {
    Donation donation =
        ScopedModel.of<Donation>(context, rebuildOnChange: true);

    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _roundButton(
              iconData: Icons.remove,
              onPress: () {
                donation.decrement();
              },
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                donation.amount.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _roundButton(
              iconData: Icons.add,
              onPress: () {
                donation.increment();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Round button Widget
  Widget _roundButton({IconData iconData, Function onPress}) {
    return RawMaterialButton(
      elevation: 5.0,
      shape: CircleBorder(),
      constraints: BoxConstraints.tightFor(height: 50.0, width: 50.0),
      fillColor: kOrangePrimary,
      onPressed: onPress,
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    );
  }

  /// Donate Button Widget view.
  Widget _bottomButton({Function onPress, String btnText, IconData icon}) {
    return Container(
      constraints: BoxConstraints.tightFor(height: 50.0, width: 240.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: kOrangePrimary,
          ),
          borderRadius: BorderRadius.circular(4.0)),
      child: RawMaterialButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              btnText,
              style: TextStyle(
                color: kOrangePrimary,
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              icon,
              color: kOrangePrimary,
            )
          ],
        ),
      ),
    );
  }
}
