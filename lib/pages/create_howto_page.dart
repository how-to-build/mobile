import 'package:flutter/material.dart';

class CreateHowToPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CreateHowToPageScreenMode();
  }
}

class MyData {
  String title = '';
  String description = '';
}

class CreateHowToPageScreenMode extends State<CreateHowToPage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Create How-to'),
          ),
          body: new StepperBody(),
        ));
  }
}

class StepperBody extends StatefulWidget {
  @override
  _StepperBodyState createState() => new _StepperBodyState();
}

class _StepperBodyState extends State<StepperBody> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  List<Step> steps = [
    new Step(
        title: const Text('Title'),
        //subtitle: const Text('Enter your name'),
        isActive: true,
        //state: StepState.error,
        state: StepState.indexed,
        content: new TextFormField(
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          autocorrect: false,
          onSaved: (String value) {
            data.title = value;
          },
          maxLines: 1,
          //initialValue: 'Aseem Wangoo',
          validator: (value) {
            if (value.isEmpty || value.length < 1) {
              return 'Please enter title of how-to';
            }
          },
          decoration: new InputDecoration(
            labelText: 'Enter your title',
            hintText: 'Enter a title',
            //filled: true,
            icon: const Icon(Icons.add_circle_outline),
            labelStyle:
                new TextStyle(decorationStyle: TextDecorationStyle.solid),
          ),
        )),
    new Step(
        title: const Text('Description'),
        //subtitle: const Text('Subtitle'),
        isActive: true,
        //state: StepState.editing,
        state: StepState.indexed,
        content: new TextFormField(
          keyboardType: TextInputType.text,
          autocorrect: false,
          validator: (value) {
            if (value.isEmpty || value.length < 10) {
              return 'Please enter description';
            }
          },
          onSaved: (String value) {
            data.description = value;
          },
          maxLines: 1,
          decoration: new InputDecoration(
              labelText: 'Enter your description',
              hintText: 'Enter a description',
              icon: const Icon(Icons.phone),
              labelStyle:
                  new TextStyle(decorationStyle: TextDecorationStyle.solid)),
        )),
    // new Step(
    //     title: const Text('Email'),
    //     // subtitle: const Text('Subtitle'),
    //     isActive: true,
    //     state: StepState.indexed,
    //     // state: StepState.disabled,
    //     content: new TextFormField(
    //       keyboardType: TextInputType.emailAddress,
    //       autocorrect: false,
    //       validator: (value) {
    //         if (value.isEmpty || !value.contains('@')) {
    //           return 'Please enter valid email';
    //         }
    //       },
    //       onSaved: (String value) {
    //         data.email = value;
    //       },
    //       maxLines: 1,
    //       decoration: new InputDecoration(
    //           labelText: 'Enter your email',
    //           hintText: 'Enter a email address',
    //           icon: const Icon(Icons.email),
    //           labelStyle:
    //               new TextStyle(decorationStyle: TextDecorationStyle.solid)),
    //     )),
    // new Step(
    //     title: const Text('Age'),
    //     // subtitle: const Text('Subtitle'),
    //     isActive: true,
    //     state: StepState.indexed,
    //     content: new TextFormField(
    //       keyboardType: TextInputType.number,
    //       autocorrect: false,
    //       validator: (value) {
    //         if (value.isEmpty || value.length > 2) {
    //           return 'Please enter valid age';
    //         }
    //       },
    //       maxLines: 1,
    //       onSaved: (String value) {
    //         data.age = value;
    //       },
    //       decoration: new InputDecoration(
    //           labelText: 'Enter your age',
    //           hintText: 'Enter age',
    //           icon: const Icon(Icons.explicit),
    //           labelStyle:
    //               new TextStyle(decorationStyle: TextDecorationStyle.solid)),
    //     )),
    // new Step(
    //     title: const Text('Fifth Step'),
    //     subtitle: const Text('Subtitle'),
    //     isActive: true,
    //     state: StepState.complete,
    //     content: const Text('Enjoy Step Fifth'))
  ];

  @override
  Widget build(BuildContext context) {
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        print("Title: ${data.title}");
        print("Description: ${data.description}");

        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("Details"),
              //content: new Text("Hello World"),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text("Title : " + data.title),
                    new Text("Description : " + data.description),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
    }

    return new Container(
        child: new Form(
      key: _formKey,
      child: new ListView(children: <Widget>[
        new Stepper(
          steps: steps,
          type: StepperType.vertical,
          currentStep: this.currStep,
          onStepContinue: () {
            setState(() {
              if (currStep < steps.length - 1) {
                currStep = currStep + 1;
              } else {
                currStep = 0;
              }
              // else {
              // Scaffold
              //     .of(context)
              //     .showSnackBar(new SnackBar(content: new Text('$currStep')));

              // if (currStep == 1) {
              //   print('First Step');
              //   print('object' + FocusScope.of(context).toStringDeep());
              // }

              // }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currStep > 0) {
                currStep = currStep - 1;
              } else {
                currStep = 0;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              currStep = step;
            });
          },
        ),
        new RaisedButton(
          child: new Text(
            'Save details',
            style: new TextStyle(color: Colors.white),
          ),
          onPressed: _submitDetails,
          color: Colors.blue,
        ),
      ]),
    ));
  }
}
