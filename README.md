# flutter_convert

A new Flutter project.

## Getting Started

приложение работает,в нём реализован bloc(но пока это работает только с выбором файла для конвертации, так как я не хотел делать блок ради блока), приходят ответы от cloudConvert_client нооо есть проблемма...

есть несколько проблем:

- блок был реализован и ,как я понял, класс клиента надо реализовывать внутри него, но в ивентах я не могу обратиться к нему (пометил комментами(файл convert_bloc.dart))
- из блока я получаю list с возможными форматами для конвертации, но dropDownButton не хочет принимать этот лист (файл convert_view.dart тоже есть комментарий)

