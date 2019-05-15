//
//  Model.swift
//  ToDoList
//
//  Created by olli on 26.04.19.
//  Copyright © 2019 Oli Poli. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

// сохранение данных
// подгрузка данных
// создание новых данных

var toDoItems: [[String: Any]] {
    // при каждом изменении данных - мы будем сохранять (записываем все в словарь)
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    // при каждом запуске приложения - мы будем загружать данные (получаем словарь)
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return array
        } else {
            return []
        }
    }
}

// добавить запись
func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name": nameItem, "isCompleted": false])
    setBadge()
}

// удалить запись
func removeItem(at index: Int) {
    toDoItems.remove(at: index)
    setBadge()
}

// ячейки меняем местами
func moveItem(fromIndex: Int, toIndex: Int) {
    let from = toDoItems[fromIndex]
    toDoItems.remove(at: fromIndex)
    toDoItems.insert(from, at: toIndex)
}

// меняем состояние (возвращает значение нового accessoryType)
func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    setBadge()
    return toDoItems[item]["isCompleted"] as! Bool
}

// бейджи с кол-ом открытых дел
// стучимся к пользователю за разрешением для уведомлений
func requestForNotification() {
    UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (isEnabled, error) in
        if isEnabled {
            print("Разрешение получено")
        } else {
            print("Разрешение НЕ получено")
        }
    }
}

// посчитаем кол-во не выполненных задач
func setBadge() {
    var totalBadgeNumber = 0
    for item in toDoItems {
        if (item["isCompleted"] as? Bool) == false {
            totalBadgeNumber = totalBadgeNumber + 1
        }
    }
    UIApplication.shared.applicationIconBadgeNumber = totalBadgeNumber
}
