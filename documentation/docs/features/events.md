---
tags: [Начало, События]
sidebar_position: 6
---

# События

## События тестов

События тестов можно использовать для настройки тестового окружения:

* Установка констант и других настроек.
* Создание тестовых данных.
* Удаление созданных данных.
* Если результат обработки события необходимо передать в тест, то это можно сделать с помощью [контекста](./context.md)

Вот некоторые из событий, которые могут быть интересны разработчикам:

* `ПередВсемиТестами` - Это событие вызывается перед прогоном тестов модуля в каждом контексте (`&НаСервер` и `&НаКлиенте` для клиент-серверного модуля). Это может быть полезно для установки общих настроек или данных, которые будут использоваться всеми тестами.
* `ПередТестовымНабором` - Это событие вызывается перед прогоном тестов набора. Это может быть полезно для установки или переопределения для тестов набора настроек или данных.
* `ПередКаждымТестом` - Это событие вызывается перед прогоном каждого теста. Это может быть полезно для установки специфических для теста настроек или данных.
* `ПослеКаждогоТеста` - Это событие вызывается после прогона каждого теста. Это может быть полезно для очистки данных или настроек, установленных перед тестом.
* `ПослеТестовогоНабора` - Это событие вызывается после прогона всех тестов набора.
* `ПослеВсехТестов` - Это событие вызывается после прогона всех тестов модуля для контекста (после всех клиентских, либо после всех серверных).

:::info Транзакция
При использовании транзакций ([ЮТТесты.ВТранзакции()](/api/ЮТТесты#втранзакции)) события `ПередКаждымТестом` и `ПослеКаждогоТеста` включаются в транзакцию. Другие события выполняются вне транзакции.
:::

Для обработки этих событий необходимо в тестовом модуле разместить одноименный экспортный метод без параметров.

:::warning[Обработчики могут вызываться дважды]
Важной особенностью всех событий, связанных с исполнением тестов, это то что они могут вызываться дважды - для клиента и для сервера.
Если у нас есть клиент-серверный модуль с тестами доступными и на клиенте, и на сервер, то события будет вызвано дважды - и перед запуском клиентских, и перед запуском серверных тесов. Это касается всех событий, и события `ПередВсемиТестами`, и события `ПослеКаждогоТеста`
:::

При необходимости разработчик может переопределить обработчики событий при регистрации тестов, вызвав `Перед` и/или `После` и указав имя нужного метода.

```bsl
Процедура ИсполняемыеСценарии() Экспорт

    ЮТТесты
        .Перед("ПодготовитьДанныеДляТестов") // Переопределение обработчика выполняемого перед прогоном тестов модуля
        .После("ОчиститьДанныеТестов")       // Переопределение обработчика выполняемого после прогона тестов модуля
        .ДобавитьТестовыйНабор("МойНаборТестов")
            .ДобавитьТест("МойПервыйТест")
            .ДобавитьТест("МойВторойТест")
                .Перед("ПодготовитьДанныеДляПервогоТеста") // Переопределение обработчика для конкретного теста
        .ДобавитьТестовыйНабор("МойДругойНаборТестов")
            .Перед("ПодготовитьДанныеДругогоНабора") // Переопределение обработчика вызываемого перед прогоном набора тестов
            .ДобавитьТест("МойТретийТест")

КонецПроцедуры
```

## События в движке

YAxUnit также использует события для работы внутренних механизмов:

* Управление жизненным циклом [контекстов](context.md)
* [Очистка тестовых данных](test-data/test-data-deletion.md)
* Логирование
* и другие.

Благодаря событиям вы можете развивать и адаптировать механизмы движка под себя, например:

* Выполнять начальную подготовку базы или настройку движка перед прогонами
* Реализовывать свои механизмы (например удаление данных с использованием подписок)
* Формировать отчеты о тестировании online.
