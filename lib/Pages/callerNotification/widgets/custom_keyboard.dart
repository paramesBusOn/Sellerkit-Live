
import 'package:flutter/material.dart';
import 'package:sellerkit/Pages/callerNotification/widgets/custom_keyboard_handler.dart';
import 'package:sellerkit/main.dart';

enum KeyType {
  
  key0('0'),
  key1('1'),
  key2('2'),
  key3('3'),
  key4('4'),
  key5('5'),
  key6('6'),
  key7('7'),
  key8('8'),
  key9('9'),
  key10('Q'),
  key11('W'),
  key12('E'),
  key13('R'),
  key14('T'),
  key15('Y'),
  key16('U'),
  key17('I'),
  key18('O'),
  key19('P'),
  key20('A'),
  key21('S'),
  key22('D'),
  key23('F'),
  key24('G'),
  key25('H'),
  key26('J'),
  key27('K'),
  key28('L'),
  key29('Z'),

  key30('X'),
  key31('C'),
  key32('V'),
  key33('B'),
  key34('N'),
  key35('M'),
  keySpace(' '),
  keyDelete('Delete'),
  keyShift('Shift'),
  keyDone('Done');
  

  bool get isFunctionKey => (this == keyDelete) || (this == keyDone)|| (this == keySpace)|| (this == keyShift);

  const KeyType(this.value);

  final String value;
}

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({super.key});

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  final double _defaultKeyboardHeight = 280;
  bool _isKeyboardShowing = false;
  bool _isShiftActive = false;
  TextEditingController _controller = TextEditingController();
  final _keys = [
    
   
    KeyType.key0,
    
    KeyType.key1,
     KeyType.key2,
    KeyType.key3,
    KeyType.key4,
    KeyType.key5,
    KeyType.key6,
    KeyType.key7,
    KeyType.key8,
    KeyType.key9,
    KeyType.key10,
    KeyType.key11,
    KeyType.key12,
    KeyType.key13,
    KeyType.key14,
    KeyType.key15,
    KeyType.key16,
    KeyType.key17,
    KeyType.key18,
    KeyType.key19,

    KeyType.key20,
    KeyType.key21,

    KeyType.key22,

    KeyType.key23,
    KeyType.key24,
    KeyType.key25,
    KeyType.key26,
    KeyType.key27,
    KeyType.key28,
    KeyType.key29,
    KeyType.key30,
    KeyType.key31,
    KeyType.key32,
    KeyType.key33,
    KeyType.key34,
    KeyType.key35,
    KeyType.keyShift,
    KeyType.keySpace, 
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CustomKeyboardHandler.customKeyboardStream.listen((event) {
        setState(() {
          _isKeyboardShowing = event.isKeyboardShowing;
          _controller = event.controller;
        });
      });
    });
    super.initState();
  }

  void _handleKeyPress(KeyType keyType) {
    final String currentText = _controller.text;
    String newText = currentText;
    final characterSelectedNum =
        _controller.selection.end - _controller.selection.start;
    int cursorPosition = _controller.selection.base.offset;
    if (keyType.isFunctionKey) {
      switch (keyType) {
        case KeyType.keyDelete:
          if (currentText.isNotEmpty && (_controller.selection.end > 0)) {
            int characterDeletedNum = characterSelectedNum;
            if (characterDeletedNum <= 1) {
              characterDeletedNum = 1;
            }
            final leftCursor = currentText.substring(
              0,
              _controller.selection.end - characterDeletedNum,
            );
            
             final rightCursor =
                currentText.substring(_controller.selection.end);
            newText = '$leftCursor$rightCursor';
            cursorPosition = _controller.selection.end - characterDeletedNum;
          }
          break;
        case KeyType.keyDone:
          dismissKeyboard(context);
          break;
            case KeyType.keySpace:  // Handle Space Bar
          final String leftCursor = currentText.substring(
            0,
            _controller.selection.end - characterSelectedNum,
          );
          final addedWord = keyType.value;
          final rightCursor = currentText.substring(_controller.selection.end);
          cursorPosition = cursorPosition + addedWord.length - characterSelectedNum;
          newText = '$leftCursor$addedWord$rightCursor';
          break;
        case KeyType.keyShift:  // Handle Shift Key
          setState(() {
            _isShiftActive = !_isShiftActive;
          });
          break;
        default:
          break;
      }
    } else {
     final String leftCursor = currentText.substring(
        0,
        _controller.selection.end - characterSelectedNum,
      );
      final addedWord = _isShiftActive ? keyType.value.toUpperCase() : keyType.value.toLowerCase();
      final rightCursor = currentText.substring(_controller.selection.end);
      cursorPosition = cursorPosition + addedWord.length - characterSelectedNum;
      newText = '$leftCursor$addedWord$rightCursor';
    }
    _controller
      ..text = newText
      ..selection = TextSelection.collapsed(
        offset: cursorPosition,
      );
  }

  @override
  Widget build(BuildContext context) {
    if (!_isKeyboardShowing) {
      return const SizedBox.shrink();
    }
    double keyboardHeight =
        _defaultKeyboardHeight - MediaQuery.of(context).viewInsets.bottom;
    if (keyboardHeight < 0) {
      keyboardHeight = 0;
    }
    return SizedBox(
      height: 200,
      child: Material(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Wrap(
                    spacing: 2,
                    runSpacing: 2,
                    alignment: WrapAlignment.center,
                    children: _keys.map((e) => _keyWidget(e)).toList(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    _bigKeyWidget(KeyType.keyDelete),
                    const SizedBox(height: 8),
                    _bigKeyWidget(KeyType.keyDone),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _keyWidget(KeyType keysType) {
     final displayValue = _isShiftActive ? keysType.value.toUpperCase() : keysType.value.toLowerCase();
     double keyWidth = 40;
     if (keysType == KeyType.keySpace) {
      keyWidth = 70;
    } else if (keysType == KeyType.keyShift) {
      keyWidth = 50;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _handleKeyPress(keysType);
      },
      child: Container(
        width:keyWidth,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(displayValue),
      ),
    );
  }

  Widget _bigKeyWidget(KeyType keysType) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _handleKeyPress(keysType);
      },
      child: Container(
        width: 50,
        height:keysType ==KeyType.keyDone? 30:50 ,
        decoration: BoxDecoration(
          color:keysType ==KeyType.keyDone? Colors.blue:Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(keysType.value,style: TextStyle(color:keysType ==KeyType.keyDone? Colors.white:Colors.black),),
      ),
    );
  }
}
