// 📦 behavioral/command_pattern.dart

// 1. Interfaz Command
abstract class Command {
  void execute();
}

// 2. Receptor: TextEditor
class TextEditor {
  String _text = '';
  String _clipboard = '';
  final List<String> _history = [];

  void type(String text) {
    _history.add(_text);
    _text += text;
  }

  void copy() {
    _clipboard = _text;
    print('📋 Copiado al portapapeles: "$_clipboard"');
  }

  void paste() {
    _history.add(_text);
    _text += _clipboard;
    print('📥 Texto después de pegar: "$_text"');
  }

  void undo() {
    if (_history.isNotEmpty) {
      _text = _history.removeLast();
      print('↩️  Texto después de deshacer: "$_text"');
    } else {
      print('❌ No hay nada para deshacer.');
    }
  }

  String getText() => _text;
}

// 3. Comandos concretos

class CopyCommand implements Command {
  final TextEditor editor;
  CopyCommand(this.editor);

  @override
  void execute() {
    editor.copy();
  }
}

class PasteCommand implements Command {
  final TextEditor editor;
  PasteCommand(this.editor);

  @override
  void execute() {
    editor.paste();
  }
}

class UndoCommand implements Command {
  final TextEditor editor;
  UndoCommand(this.editor);

  @override
  void execute() {
    editor.undo();
  }
}

// 4. Cliente: Toolbar

class Toolbar {
  final Map<String, Command> _commands = {};

  void setCommand(String button, Command command) {
    _commands[button] = command;
  }

  void clickButton(String button) {
    final command = _commands[button];
    if (command != null) {
      command.execute();
    } else {
      print('⚠️ No hay comando asignado al botón "$button".');
    }
  }
}

// 5. Código cliente

void main() {
  final editor = TextEditor();
  final toolbar = Toolbar();

  final copyCommand = CopyCommand(editor);
  final pasteCommand = PasteCommand(editor);
  final undoCommand = UndoCommand(editor);

  toolbar.setCommand('copy', copyCommand);
  toolbar.setCommand('paste', pasteCommand);
  toolbar.setCommand('undo', undoCommand);

  // Simulación de edición
  for (final char in 'Hola Mundo!'.split('')) {
    editor.type(char);
  }

  print('\n📝 Texto actual: "${editor.getText()}"');

  print('\n📋 Copiando...');
  toolbar.clickButton('copy');

  print('\n📥 Pegando...');
  toolbar.clickButton('paste');

  print('\n↩️ Deshaciendo...');
  toolbar.clickButton('undo');

  print('\n↩️ Deshaciendo otra vez...');
  toolbar.clickButton('undo');

  print('\n✅ Texto final: "${editor.getText()}"');
}
