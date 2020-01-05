

import 'package:anime_me/main.dart';
import 'package:flutter/material.dart';

class ProfilePage extends MainPageWidget{

  @override
  _ProfilePageState createState() => _ProfilePageState();


  void choiceAction(String action) async{
    if(action == Constants.Edit){
      Potluck potluck = this.potluck.clone();
      PopupController pc = PotluckEditController(potluck);
      Potluck updatedPotluck = await showDialog<Potluck>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: PopupDialog(pc, "Save"),
          );
        },
      );
      setState(() {
        if(updatedPotluck != null){
          this.potluck = updatedPotluck;
        }
      });
    }else if(action == Constants.GroupInvite){
      await showDialog<Potluck>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: PotluckGroupInvite(potluckID: this.potluck.potluckID),
          );
        },
      );
      retrieveInvitedGroups();
    }else if(action == Constants.Delete){
      bool toDelete = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Are you sure you want to delete this potluck?'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[new RaisedButton(
                color: Theme
                    .of(context)
                    .primaryColor,
                child: new Text('NO',
                  style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
                new RaisedButton(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  child: new Text('Yes',
                    style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          );
        },
      );
      if(toDelete){
        //do service call
        await Service.deletePotluck(this.potluck.potluckID);
        Navigator.of(context).pop();
      }
    }else if(action == Constants.BringRecipe){
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: PotluckBringRecipe(potluckID: this.potluck.potluckID),
          );
        },
      );
      getRecipesBringing();
    }
  }

  List<Widget> appbarActions(context){
    return [new PopupMenuButton<String>(
      onSelected: choiceAction,
      icon: new Icon(Icons.more_vert, color: Colors.white),
      itemBuilder: (BuildContext context){
        return (potluck.permission == PotluckConstants.OWNER) ? Constants.choicesOwner.map((String choice){
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList()
            :
        Constants.choicesInvited.map((String choice){
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    )];
  }

}

class _ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FillerWidget(Colors.white);
  }
}




/*
new PopupMenuButton<String>(
                onSelected: choiceAction,
                icon: new Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (BuildContext context){
                  return (potluck.permission == PotluckConstants.OWNER) ? Constants.choicesOwner.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList()
                  :
                  Constants.choicesInvited.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
 */

class Constants{
  static const String Edit = 'EditProfile';
  static const String AddAnime = "Add Anime";
  static const String NewRequest = "New Request";

  static const List<String> choicesAdmin = <String>[
    Edit,
    AddAnime,
    NewRequest
  ];

  static const List<String> choicesUser = <String>[
    Edit,
    NewRequest
  ];

}