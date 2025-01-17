//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область СлужебныйПрограммныйИнтерфейс

#Область Перечисления

// Типы ошибок.
//
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Типы возможных ошибок:
//  * ТестНеРеализован - Строка
//  * ОшибкаСравнения - Строка
//  * ОшибкаОбработкиСобытия - Строка
//  * Утверждений - Строка
//  * Исполнения - Строка
//  * ЧтенияТестов - Строка
//  * МалоПараметров - Строка
//  * МногоПараметров - Строка
//  * НекорректныйКонтекстИсполнения - Строка
//  * Пропущен - Строка
Функция ТипыОшибок() Экспорт
	
	Типы = Новый Структура;
	
	Для Каждого ТипОшибки Из ПараметрыТиповОшибок() Цикл
		Типы.Вставить(ТипОшибки.Ключ, ТипОшибки.Ключ);
	КонецЦикла;
	
	//@skip-check constructor-function-return-section
	Возврат Новый ФиксированнаяСтруктура(Типы);
	
КонецФункции

Функция ПараметрыТиповОшибок(Кешировать = Истина) Экспорт
	
	Если Кешировать Тогда
		ЮТСлужебныйПовторногоИспользования.ПараметрыТиповОшибок();
	КонецЕсли;
	
	Статусы = ЮТФабрика.СтатусыИсполненияТеста();
	Реквизиты = "Ключ, Представление, Статус";
	
	ТипыОшибок = Новый Массив();
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ТестНеРеализован", "Не реализован", Статусы.НеРеализован));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ОшибкаСравнения", "Ошибка сравнения", Статусы.Ошибка));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ОшибкаОбработкиСобытия", "Ошибка обработки события", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "Утверждений", "Ошибка утверждений", Статусы.Ошибка));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "Исполнения", "Ошибка исполнения", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ЧтенияТестов", "Загрузки тестов", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "МалоПараметров", "Мало фактических параметров", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "МногоПараметров", "Много фактических параметров", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "НекорректныйКонтекстИсполнения", "Некорректный контекст исполнения", Статусы.Пропущен));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "Пропущен", "Пропущен", Статусы.Пропущен));
	
	Возврат ЮТКоллекции.ВСтруктуру(ТипыОшибок, "Ключ");
	
КонецФункции

#КонецОбласти

#Область СтруктурыДанных

// Описание тестового модуля.
//
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрикаСлужебный.ОписаниеМодуля
//  НаборыТестов - Массив из см. ЮТФабрикаСлужебный.ОписаниеТестовогоНабора
//
// Возвращаемое значение:
//  Структура - Описание тестового модуля:
// * МетаданныеМодуля - см. ЮТФабрикаСлужебный.ОписаниеМодуля
// * НаборыТестов - Массив из см. ЮТФабрикаСлужебный.ОписаниеТестовогоНабора
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки
// * НастройкиВыполнения- Структура - Настройки исполнения теста
Функция ОписаниеТестовогоМодуля(МетаданныеМодуля, НаборыТестов) Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("МетаданныеМодуля", МетаданныеМодуля);
	Описание.Вставить("НаборыТестов", НаборыТестов);
	Описание.Вставить("Ошибки", Новый Массив);
	Описание.Вставить("НастройкиВыполнения", Новый Структура());
	
	Возврат Описание;
	
КонецФункции

// ОписаниеТестовогоНабора
//  Возвращает описание регистрируемого тестового набора.
//  Эта структура используется на этапе формирования описаний имеющихся тестов
// Параметры:
//  Имя - Строка - Имя набора
//  ТегиСтрокой - Строка - Теги набора
//
// Возвращаемое значение:
//  Структура - Описание тестового набора:
// * Имя - Строка - Имя набора
// * Представление - Строка - Представление, краткое описание
// * Теги - Массив из Строка - Коллекция тегов набора
// * Тесты - Массив из см. ОписаниеТеста - Коллекция тестов набора, см. ОписаниеТеста
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки - Описания ошибок регистрации тестов
// * НастройкиВыполнения- Структура - Настройки исполнения теста
Функция ОписаниеТестовогоНабора(Имя, ТегиСтрокой = "") Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Имя", Строка(Имя));
	Описание.Вставить("Представление", Строка(Имя));
	Описание.Вставить("Теги", СтрРазделить(ТегиСтрокой, ", ", Ложь));
	Описание.Вставить("Тесты", Новый Массив);
	Описание.Вставить("Ошибки", Новый Массив);
	Описание.Вставить("НастройкиВыполнения", Новый Структура());
	
	Возврат Описание;
	
КонецФункции

// ОписаниеТеста
//  Возвращает описание регистрируемого теста.
//  Эта структура используется на этапе формирования описаний имеющихся тестов
// Параметры:
//  Имя - Строка - Имя тестового метода
//  Представление - Строка - Представление, краткое описание теста
//  КонтекстыВызова - Массив из Строка - Контексты исполнения теста, см. ЮТФабрика.КонтекстыВызова
//  ТегиСтрокой - Строка - Теги теста
//
// Возвращаемое значение:
//  Структура - Описание теста:
// * Имя - Строка - Имя теста (тестового метода)
// * Представление - Строка - Представление теста
// * Теги - Массив из Строка - Теги теста
// * КонтекстВызова - Массив из Строка - Контексты исполнения теста
// * НастройкиВыполнения- Структура - Настройки исполнения теста
// * Параметры - Неопределено, Массив из Произвольный - Параметры теста
// * НомерВНаборе - Число - Порядковый номер теста в наборе
Функция ОписаниеТеста(Имя, Представление, КонтекстыВызова, Знач ТегиСтрокой = "") Экспорт
	
	Если ТегиСтрокой = Неопределено Тогда
		ТегиСтрокой = "";
	КонецЕсли;
	
	Описание = Новый Структура();
	Описание.Вставить("Имя", Строка(Имя));
	Описание.Вставить("Представление", Строка(Представление));
	Описание.Вставить("Теги", СтрРазделить(ТегиСтрокой, ", ", Ложь));
	Описание.Вставить("КонтекстВызова", КонтекстыВызова);
	Описание.Вставить("НастройкиВыполнения", Новый Структура());
	Описание.Вставить("Параметры", Неопределено);
	Описание.Вставить("НомерВНаборе", 0);
	
	Возврат Описание;
	
КонецФункции

// Описание исполняемого тестового модуля.
//  Содержит всю необходимую информацию для прогона тестов, а также данные результата
// Параметры:
//  ТестовыйМодуль - см. ОписаниеТестовогоМодуля
//
// Возвращаемое значение:
//  Структура - Описание тестового модуля:
// * МетаданныеМодуля - см. ЮТФабрикаСлужебный.ОписаниеМодуля
// * НаборыТестов - Массив из см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоНабораТестов
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки
// * НастройкиВыполнения- Структура - Настройки исполнения теста
Функция ОписаниеИсполняемогоТестовогоМодуля(ТестовыйМодуль) Экспорт
	
	Описание = Новый Структура;
	
	Описание.Вставить("МетаданныеМодуля", ТестовыйМодуль.МетаданныеМодуля);
	Описание.Вставить("НаборыТестов", Новый Массив);
	Описание.Вставить("Ошибки", ЮТКоллекции.СкопироватьМассив(ТестовыйМодуль.Ошибки));
	Описание.Вставить("НастройкиВыполнения", ЮТКоллекции.СкопироватьСтруктуру(ТестовыйМодуль.НастройкиВыполнения));
	
	Возврат Описание;
	
КонецФункции

// ОписаниеИсполняемогоНабораТестов
//  Возвращает описание исполняемого тестового набора.
//  Содержит данные необходимые для выполнения прогона тестов
// Параметры:
//  НаборТестов - См. ОписаниеТестовогоНабора
//  ТестовыйМодуль - См. ОписаниеТестовогоМодуля
//
// Возвращаемое значение:
//  Структура - Описание исполняемого набора тестов:
// * Имя - Строка - Имя набора
// * Представление - Строка - Представление набора
// * Теги - Массив из Строка - Тэги набора
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки - Описания ошибок выполнения теста
// * Режим - Строка - Режим исполнения набора, см. ЮТФабрика.КонтекстыВызова
// * МетаданныеМодуля - см. ЮТФабрикаСлужебный.ОписаниеМодуля
// * Тесты - Массив из см. ОписаниеИсполняемогоТеста - Тесты набора, структуру тестов см. ОписаниеИсполняемогоТеста
// * Выполнять - Булево - Признак, что можно выполнить прогон набора (нет ошибок блокирующих запуск)
// * ДатаСтарта - Число - Дата запуска набора
// * Длительность - Число - Продолжительность выполнения набора
// * НастройкиВыполнения - Структура - Настройки исполнения теста
// * ТестовыйМодуль - См. ОписаниеТестовогоМодуля
Функция ОписаниеИсполняемогоНабораТестов(НаборТестов, ТестовыйМодуль) Экспорт
	
	Описание = Новый Структура();
	
	Описание.Вставить("Имя", НаборТестов.Имя);
	Описание.Вставить("Представление", НаборТестов.Представление);
	Описание.Вставить("Теги", НаборТестов.Теги);
	Описание.Вставить("Ошибки", ЮТКоллекции.СкопироватьМассив(НаборТестов.Ошибки));
	Описание.Вставить("Режим", "");
	Описание.Вставить("ТестовыйМодуль", ТестовыйМодуль);
	Описание.Вставить("МетаданныеМодуля", ТестовыйМодуль.МетаданныеМодуля);
	Описание.Вставить("Тесты", Новый Массив);
	Описание.Вставить("Выполнять", Описание.Ошибки.Количество() = 0);
	Описание.Вставить("ДатаСтарта", 0);
	Описание.Вставить("Длительность", 0);
	Описание.Вставить("НастройкиВыполнения", НаборТестов.НастройкиВыполнения);
	
	Возврат Описание;
	
КонецФункции

// ОписаниеИсполняемогоТеста
//  Возвращает описание исполняемого теста
//  Содержит данные необходимые для выполнения прогона тестов
//
// Параметры:
//  Тест - См. ОписаниеТеста
//  Режим - См. ЮТФабрика.КонтекстыВызова
//  ТестовыйМодуль - См. ОписаниеТестовогоМодуля
//
// Возвращаемое значение:
//  Структура - Описание исполняемого теста:
// * Имя - Строка - Имя/представление теста
// * Метод - Строка - Имя тестового метода
// * ПолноеИмяМетода - Строка - Полное имя тестового метода, ИмяМодуля.ИмяМетода
// * Теги - Массив из Строка - Теги теста
// * Режим - Строка - Режим исполнения теста, см. ЮТФабрика.КонтекстыВызова
// * ДатаСтарта - Число - Дата запуска теста
// * Длительность - Число - Продолжительность выполнения теста
// * Статус - Строка - Статус выполнения теста, см. ЮТФабрика.СтатусыИсполненияТеста
// * Ошибки - Массив из см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки - Описания ошибок выполнения теста, см. ЮТФабрикаСлужебный.ОписаниеВозникшейОшибки
// * НастройкиВыполнения- Структура - Настройки исполнения теста
// * Параметры - Неопределено, Массив из Произвольный - Набор параметров теста
// * НомерВНаборе - Число - Порядковый номер теста в наборе
Функция ОписаниеИсполняемогоТеста(Тест, Режим, ТестовыйМодуль) Экспорт
	
	ПолноеИмяМетода = СтрШаблон("%1.%2", ТестовыйМодуль.МетаданныеМодуля.Имя, Тест.Имя);
	Представление = ПредставлениеТеста(Тест);
	
	ОписаниеТеста = Новый Структура;
	ОписаниеТеста.Вставить("Имя", Представление);
	ОписаниеТеста.Вставить("Метод", Тест.Имя);
	ОписаниеТеста.Вставить("ПолноеИмяМетода", ПолноеИмяМетода);
	ОписаниеТеста.Вставить("Теги", Тест.Теги);
	ОписаниеТеста.Вставить("Режим", Режим);
	ОписаниеТеста.Вставить("ДатаСтарта", 0);
	ОписаниеТеста.Вставить("Длительность", 0);
	ОписаниеТеста.Вставить("Статус", ЮТФабрика.СтатусыИсполненияТеста().Ожидание);
	ОписаниеТеста.Вставить("Ошибки", Новый Массив);
	ОписаниеТеста.Вставить("НастройкиВыполнения", Тест.НастройкиВыполнения);
	ОписаниеТеста.Вставить("Параметры", Тест.Параметры);
	ОписаниеТеста.Вставить("НомерВНаборе", Тест.НомерВНаборе);
	
	//@skip-check constructor-function-return-section
	Возврат ОписаниеТеста;
	
КонецФункции

// ОписаниеМодуля
//  Возвращает структуру описания модуля
// Возвращаемое значение:
//  Структура - Описание модуля:
// * Имя - Строка - Имя модуля
// * ПолноеИмя - Строка - Полное имя модуля
// * Расширение - Строка - Имя расширения, владельца модуля
// * КлиентУправляемоеПриложение - Булево - Доступность контекста
// * КлиентОбычноеПриложение - Булево - Доступность контекста
// * Сервер - Булево - Доступность контекста
// * ВызовСервера - Булево - Доступность контекста
// * Глобальный - Булево - Доступность контекста
Функция ОписаниеМодуля() Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Имя", "");
	Описание.Вставить("ПолноеИмя", "");
	Описание.Вставить("Расширение", "");
	Описание.Вставить("КлиентУправляемоеПриложение", Ложь);
	Описание.Вставить("КлиентОбычноеПриложение", Ложь);
	Описание.Вставить("Сервер", Ложь);
	Описание.Вставить("ВызовСервера", Ложь);
	Описание.Вставить("Глобальный", Ложь);
	
	Возврат Описание;
	
КонецФункции

// ОписаниеВозникшейОшибки
//  Возвращает базовую структуру ошибки
//
// Параметры:
//  Сообщение - Строка - Описание ошибки
//
// Возвращаемое значение:
//  Структура - Описание возникшей ошибки:
// * Сообщение - Строка - Описание возникшей ошибки
// * Стек - Строка - Стек возникшей ошибки
// * ТипОшибки - Строка - Тип возникшей ошибки. Доступные значения см. ЮТФабрикаСлужебный.ТипыОшибок
// * Лог - Массив из Строка
Функция ОписаниеВозникшейОшибки(Сообщение) Экспорт
	
	Описание = Новый Структура("Стек, ТипОшибки", "", "");
	Описание.Вставить("Сообщение", Сообщение);
	Описание.Вставить("Лог", Новый Массив);
	
	Возврат Описание;
	
КонецФункции

// Возвращает базовую структуру ошибки проверки факта и ожидания
//
// Параметры:
//  Сообщение - Строка
//
// Возвращаемое значение:
//  Структура - Описание возникшей ошибки:
// * Сообщение - Строка - Описание возникшей ошибки
// * Стек - Строка - Стек возникшей ошибки
// * ТипОшибки - Строка - Тип возникшей ошибки. Доступные значения см. ЮТФабрикаСлужебный.ТипыОшибок
// * ПроверяемоеЗначение - Произвольный - Проверяемое, фактическое значение
// * ОжидаемоеЗначение - Произвольный - Ожидаемое значение
Функция ОписаниеОшибкиСравнения(Сообщение) Экспорт
	
	Описание = ОписаниеВозникшейОшибки(Сообщение);
	Описание.ТипОшибки = ТипыОшибок().Утверждений;
	Описание.Вставить("ПроверяемоеЗначение");
	Описание.Вставить("ОжидаемоеЗначение");
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// Возвращает базовую структуру ошибки пропуска теста
//
// Параметры:
//  Сообщение - Строка
//
// Возвращаемое значение:
//  Структура - Описание возникшей ошибки:
// * Сообщение - Строка - Описание возникшей ошибки
// * Стек - Строка - Стек возникшей ошибки
// * ТипОшибки - Строка - Тип возникшей ошибки. Доступные значения
//   См. ЮТФабрикаСлужебный.ТипыОшибок
Функция ОписаниеОшибкиПропуска(Сообщение) Экспорт
	
	Описание = ОписаниеВозникшейОшибки(Сообщение);
	Описание.ТипОшибки = ТипыОшибок().Пропущен;
	
	Возврат Описание;
	
КонецФункции

// Описание события исполнения тестов.
//
// Параметры:
//  Модуль - см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля
//  Набор 	- см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоНабораТестов
//  Тест 	- см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоТеста
//
// Возвращаемое значение:
//  Структура - Описание события исполнения тестов:
// * Модуль - см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля
// * Набор 	- см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоНабораТестов
// * Тест 	- см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоТеста
Функция ОписаниеСобытияИсполненияТестов(Модуль, Набор = Неопределено, Тест = Неопределено) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Модуль", Модуль);
	Описание.Вставить("Набор", Набор);
	Описание.Вставить("Тест", Тест);
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// Описание категория набора тестов.
//
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля
//
// Возвращаемое значение:
//  Структура - Описание категория набора тестов:
// * ТестовыйМодуль - см. ЮТФабрикаСлужебный.ОписаниеТестовогоМодуля
// * Клиентские - Массив из см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоНабораТестов
// * Серверные - Массив из см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоНабораТестов
// * Пропущенные - Массив из см. ЮТФабрикаСлужебный.ОписаниеИсполняемогоНабораТестов
Функция ОписаниеКатегорияНабораТестов(ТестовыйМодуль) Экспорт
	
	КатегорииНаборов = Новый Структура();
	КатегорииНаборов.Вставить("ТестовыйМодуль", ТестовыйМодуль);
	КатегорииНаборов.Вставить("Клиентские", Новый Массив());
	КатегорииНаборов.Вставить("Серверные", Новый Массив());
	КатегорииНаборов.Вставить("Пропущенные", Новый Массив());
	
	//@skip-check constructor-function-return-section
	Возврат КатегорииНаборов;
	
КонецФункции

// Формирует описание проверяемого значения.
// Используется в утверждения для формирования дружелюбного сообщения об ошибке.
//
// Параметры:
//  ПроверяемоеЗначение - Произвольный - Проверяемое значение
//
// Возвращаемое значение:
//  Структура - Описание проверяемого значения:
// * Значение - Произвольный
// * Представление - Строка - Представление объекта
//                 - Неопределено - Если не указано тогда используется платформенное предсталение (`Строка(Значение)`)
// * ИмяСвойства - Строка, Число, Неопределено - Имя проверяемого реквизита, индекса
Функция ОписаниеПроверяемогоЗначения(ПроверяемоеЗначение) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Значение", ПроверяемоеЗначение);
	Описание.Вставить("Представление", Неопределено);
	Описание.Вставить("ИмяСвойства", Неопределено);
	
	Возврат Описание;
	
КонецФункции

// Описание проверки.
//
// Параметры:
//  ПроверяемоеЗначение - Произвольный
//
// Возвращаемое значение:
//  Структура - Описание проверки:
// * ОбъектПроверки - см. ОписаниеПроверяемогоЗначения
// * ПрефиксОшибки - Строка, Неопределено -
// * ОписаниеПроверки - Строка, Неопределено -
Функция ОписаниеПроверки(ПроверяемоеЗначение) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("ОбъектПроверки", ОписаниеПроверяемогоЗначения(ПроверяемоеЗначение));
	Описание.Вставить("ПрефиксОшибки", Неопределено);
	Описание.Вставить("ОписаниеПроверки", Неопределено);
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти

#Область КонструкторыКонтекстов

// Данные контекста исполнения.
//
// Возвращаемое значение:
//  Структура - Данные контекста исполнения:
//  * Уровень - Строка - Возможные значения см. ЮТФабрика.УровниИсполнения
//  * Модуль  - Неопределено - Нет исполняемого модуля
//            - см. ОписаниеТестовогоМодуля
//  * Набор   - Неопределено - Нет исполняемого тестового набора
//            - см. ОписаниеИсполняемогоНабораТестов
//  * Тест    - Неопределено - Нет исполняемого теста
//            - см. ОписаниеИсполняемогоТеста
Функция НовыйКонтекстИсполнения() Экспорт
	
	Контекст = Новый Структура();
	Контекст.Вставить("Уровень", "");
	Контекст.Вставить("Модуль", Неопределено);
	Контекст.Вставить("Набор", Неопределено);
	Контекст.Вставить("Тест", Неопределено);
	
	Возврат Контекст;
	
КонецФункции

// Описание результата проверки.
//
// Параметры:
//  Успешно - Булево - Успешно
//
// Возвращаемое значение:
//  Структура - Описание результата проверки:
// * Сообщения - Массив из Произвольный
// * Успешно - Булево
Функция ОписаниеРезультатаПроверки(Успешно = Истина) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Сообщения", Новый Массив);
	Описание.Вставить("Успешно", Истина);
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти

// КонтекстыМодуля
//  Возвращает коллекцию доступных контекстов выполнения модуля
// Параметры:
//  Модуль - См. ОписаниеМодуля
//
// Возвращаемое значение:
//  Массив из Строка - Контексты модуля, возможные значения см. ЮТФабрика.КонтекстыВызова
Функция КонтекстыМодуля(Модуль) Экспорт
	
	Контексты = ЮТФабрика.КонтекстыВызова();
	
	КонтекстыМодуля = Новый Массив();
	
	Если Модуль.Сервер Тогда
		КонтекстыМодуля.Добавить(Контексты.Сервер);
	КонецЕсли;
	
	Если Модуль.КлиентУправляемоеПриложение Тогда
		КонтекстыМодуля.Добавить(Контексты.КлиентУправляемоеПриложение);
	КонецЕсли;
	
	Если Модуль.КлиентОбычноеПриложение Тогда
		КонтекстыМодуля.Добавить(Контексты.КлиентОбычноеПриложение);
	КонецЕсли;
	
	Возврат КонтекстыМодуля;
	
КонецФункции

// КонтекстыПриложения
//  Возвращает коллекцию доступных контекстов приложения
// Возвращаемое значение:
//  Массив из Строка - Контексты приложения, возможные значения см. ЮТФабрика.КонтекстыВызова
Функция КонтекстыПриложения() Экспорт
	
#Если НЕ Клиент Тогда
	ВызватьИсключение "Метод получения контекстов приложения должен вызываться с клиента";
#КонецЕсли
	
	Контексты = ЮТФабрика.КонтекстыВызова();
	КонтекстыПриложения = Новый Массив();
	
	КонтекстыПриложения.Добавить(Контексты.Сервер);
	КонтекстыПриложения.Добавить(Контексты.ВызовСервера);
	
#Если ТолстыйКлиентОбычноеПриложение Тогда
	КонтекстыПриложения.Добавить(Контексты.КлиентОбычноеПриложение);
#ИначеЕсли ТолстыйКлиентУправляемоеПриложение Или ТонкийКлиент Тогда
	КонтекстыПриложения.Добавить(Контексты.КлиентУправляемоеПриложение);
#КонецЕсли
	
	Возврат КонтекстыПриложения;
	
КонецФункции

// КонтекстИсполнения
//  Возвращает контекст исполнения по контексту вызова
// Параметры:
//  КонтекстВызова - Строка - Контекст вызова, см. ЮТФабрика.КонтекстыВызова
//
// Возвращаемое значение:
//  Неопределено, Строка - Контекст исполнения
Функция КонтекстИсполнения(КонтекстВызова) Экспорт
	
	КонтекстыВызова = ЮТФабрика.КонтекстыВызова();
	
	Если КонтекстВызова = КонтекстыВызова.Сервер Тогда
		
		Возврат ЮТФабрика.КонтекстыИсполнения().Сервер;
		
	ИначеЕсли КонтекстВызова = КонтекстыВызова.КлиентУправляемоеПриложение
		ИЛИ КонтекстВызова = КонтекстыВызова.КлиентОбычноеПриложение
		ИЛИ КонтекстВызова = КонтекстыВызова.ВызовСервера Тогда
		
		Возврат ЮТФабрика.КонтекстыИсполнения().Клиент;
		
	Иначе
		
		Возврат Неопределено;
		
	КонецЕсли;
	
КонецФункции

// Формирует представление теста
//
// Параметры:
//  Тест - см. ОписаниеТеста
//
// Возвращаемое значение:
//  Строка - Представление теста
Функция ПредставлениеТеста(Тест) Экспорт
	
	Если ЗначениеЗаполнено(Тест.Представление) Тогда
		Представление = Тест.Представление;
	ИначеЕсли ЗначениеЗаполнено(Тест.Параметры) Тогда
		ПредставлениеПараметров = СтрСоединить(Тест.Параметры, ", ");
		Представление = СтрШаблон("%1(%2)", Тест.Имя, ПредставлениеПараметров);
	Иначе
		Представление = Тест.Имя;
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

Функция ПараметрыЗаполненияТаблицыЗначений(Знач ПараметрыСозданияОбъектов = Неопределено) Экспорт
	
	Если ПараметрыСозданияОбъектов = Неопределено Тогда
		ПараметрыСозданияОбъектов = ЮТФабрика.ПараметрыСозданияОбъектов();
	Иначе
		ВходныеПараметрыСозданияОбъектов = ПараметрыСозданияОбъектов;
		ПараметрыСозданияОбъектов = ЮТФабрика.ПараметрыСозданияОбъектов();
		ЗаполнитьЗначенияСвойств(ПараметрыСозданияОбъектов, ВходныеПараметрыСозданияОбъектов);
	КонецЕсли;
	
	Возврат Новый ФиксированнаяСтруктура("СозданиеОбъектовМетаданных", ПараметрыСозданияОбъектов);
	
КонецФункции

// Параметры генератора отчета.
// Описывает предоставляемые модулем форматы отчетов
//
// Возвращаемое значение:
//  Структура - Параметры генератора отчета:
// * Форматы - Структура - Форматы отчетов, предоставляемые модулем
Функция ПараметрыГенератораОтчета() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("Форматы", Новый Структура);
	
	Возврат Параметры;
	
КонецФункции

// Описание формата отчета.
//
// Параметры:
//  Идентификатор - Строка - Уникальный идентификатор формата отчета
//  Представление - Строка - Пользовательское представление отчета, выводится в форму настроек тестирования
//
// Возвращаемое значение:
//  Структура - Описание формата отчета:
// * Идентификатор - Строка - Уникальный идентификатор формата отчета
// * Представление - Строка - Пользовательское представление отчета, выводится в форму настроек тестирования
// * ЗаписьВКаталог - Булево - Отчет записывается в каталог, в этом случае должен быть установлен призак `СамостоятельнаяЗаписьОтчета`
// * ФильтрВыбораФайла - Строка - Фильтр выбора, используется в форме настроек тестирования
// * ИмяФайлаПоУмолчанию - Строка - Для отчетов, записываемых в файл, имя файла если в параметрах указан каталог
// * СамостоятельнаяЗаписьОтчета - Булево - Способ записи отчета в файлы.
//											Истина - Модуль формирования отчета самостоятельно записывает отчет
//											Ложь - Модуль формирования отчета генерирует данные, которые записываются движком
Функция ОписаниеФорматаОтчета(Идентификатор, Представление) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Идентификатор", Идентификатор);
	Описание.Вставить("Представление", Представление);
	Описание.Вставить("ЗаписьВКаталог", Ложь);
	Описание.Вставить("ФильтрВыбораФайла", "");
	Описание.Вставить("ИмяФайлаПоУмолчанию", "");
	Описание.Вставить("СамостоятельнаяЗаписьОтчета", Ложь);
	
	Возврат Описание;
	
КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
