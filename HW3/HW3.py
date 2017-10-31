import random
import datetime
import pandas as pd
import csv
# import pymysql
import MySQLdb as pymysql

daysSupply = 85
milkDaysSupply = 448
breadDaysSupply = 96
peanutButterSupply = 114
jellySupply = 346
cerealSupply = 101

def populateItems():
    resultArray = []
    with open('Products2.txt') as f:
        content = f.readlines()
        lines = [line.rstrip('\n') for line in content]

        for i in range(0, len(lines) - 1):
            newArry = str(lines[i]).split('\t')
            resultArray.append(newArry)

    return resultArray


items = populateItems()
itemsDataFrame = pd.read_csv('Products1.txt', sep="\t")


def getItemsFromItemType(itemType):
    milkDf = itemsDataFrame[(itemsDataFrame['itemType'] == itemType)]
    resultArry = []
    for i in range(0, milkDf.shape[0]):
        resultArry.append(milkDf.iloc[i])
    return resultArry


milkItems = getItemsFromItemType('Milk')
cerealItems = getItemsFromItemType('Cereal')
jellyItems = getItemsFromItemType('Jelly/Jam')
peanutButterItems = getItemsFromItemType('Peanut Butter')
breadItems = getItemsFromItemType('Bread')
salesSQL = ("INSERT INTO `sales_3` "
            "(`date`, `customer_number`,`sku`,`price`,`product_name`,`itemType`,`items_left`,`total_cases_ordered` ) "
            "VALUES (%s, %s, %s, %s,%s,%s,%s,%s)")


def connectToDB():
    try:
        db_url = '127.0.0.1'
        db_name = 'grocery_store'
        user = 'root'

        conn = pymysql.connect(db_url, user=user, db=db_name, connect_timeout=5)
    except Exception, e:
        print("Couldn't do it: %s", e)
        raise Exception('Unable to connect to RDS')

    return conn


connection = connectToDB()


def checkItemsSupply():
    for item in items:
        while int(item[6]) < daysSupply:
            item[6] = str(int(item[6]) + 12)
            item[7] = str(int(item[7]) + 1)


def checkSpecialItemsSupply(items, neededSupplyCnt):
    for item in items:
        while int(item[6]) < neededSupplyCnt:
            item['ItemsLeft'] = str(int(item['ItemsLeft']) + 12)
            item['TotalCasesOrderd'] = str(int(item['TotalCasesOrderd']) + 1)


def itemsNotGone(items):
    for item in items:
        if (int(item['ItemsLeft']) > 0):
            return True
    return False


def getMilk():
    if (itemsNotGone(milkItems)):
        rand = random.randrange(0, len(milkItems) )
        item = milkItems[rand]
        if (int(item['ItemsLeft']) < 1):
            return getMilk()
        item['ItemsLeft'] = str(int(item['ItemsLeft']) - 1)
        return item
    return None


def writeRecord(date, j, SKU, price, product_Name, itemType, items_left,total_cases_ordered ):
    price = str(price).replace('$', '')
    connection.cursor().execute(salesSQL, (long(date), long(j), long(SKU), float(price) * 1.1, product_Name, itemType, items_left, total_cases_ordered))





def checkSpecialItemSupply():
    checkSpecialItemsSupply(breadItems, breadDaysSupply)
    checkSpecialItemsSupply(cerealItems, cerealSupply)
    checkSpecialItemsSupply(peanutButterItems, peanutButterSupply)
    checkSpecialItemsSupply(jellyItems, jellySupply)


def myDate(i):
    s = str(2017) + str(i + 1)
    date = str(datetime.datetime.strptime(s, '%Y%j')).replace('00:00:00', '').replace('-', '')
    if (i % 4 != 0):
        checkItemsSupply()
        checkSpecialItemSupply()
    checkSpecialItemsSupply(milkItems, milkDaysSupply)

    print date
    return date


def getCereal():
    if (itemsNotGone(cerealItems)):
        rand = random.randrange(0, len(cerealItems))
        item = cerealItems[rand]
        if (int(item['ItemsLeft']) < 1):
            return getCereal()
        item['ItemsLeft'] = str(int(item['ItemsLeft']) - 1)
        return item
    return None


def getRandomItem():
    index = random.randrange(0, len(items))
    item = items[index]
    type = item[3]
    # if a special item or empty get a different item
    if (int(item[6]) < 1 or type == 'Milk' or type == 'Bread' or type == 'Jelly/Jam' or type == 'Cereal'):
        return getRandomItem()
    item[6] = str(int(item[6])-1)
    return item


def getBread():
    if (itemsNotGone(breadItems)):
        rand = random.randrange(0, len(breadItems) )
        item = breadItems[rand]
        if (int(item['ItemsLeft']) < 1):
            return getBread()
        item['ItemsLeft'] = str(int(item['ItemsLeft']) - 1)
        return item
    return None


def getJelly():
    if (itemsNotGone(jellyItems)):
        rand = random.randrange(0, len(jellyItems))
        item = jellyItems[rand]
        if (int(item['ItemsLeft']) < 1):
            return getJelly()
        item['ItemsLeft'] = str(int(item['ItemsLeft']) - 1)
        return item
    return None


def getPeanutButter():
    if (itemsNotGone(peanutButterItems)):
        rand = random.randrange(0, len(jellyItems) )
        item = peanutButterItems[rand]
        if (int(item['ItemsLeft']) < 1):
            return getPeanutButter()
        item['ItemsLeft'] = str(int(item['ItemsLeft']) - 1)
        return item
    return None


def simulateGroceryData():
    cCustomersLo = 1140
    cCustomersHi = 1180
    cPriceMultiplier = 1.1
    cDate1 = 20170101
    cMaxItems = 100
    cWeekendIncrease = 50
    for i in range(0, 365):
        date = myDate(i);

        custCount = random.randrange(cCustomersLo, cCustomersHi, cWeekendIncrease)
        for j in range(1, custCount):
            k = 0
            myItems = random.randrange(1, cMaxItems)
            if random.randrange(1, 100) <= 70:
                milk = getMilk()
                if (not milk is None):
                    writeRecord(date, j, milk['SKU'], milk['BasePrice'], milk['Product Name'], milk['itemType'], milk['ItemsLeft'],milk['TotalCasesOrderd'])
                    k = k + 1
                    if random.randrange(1, 100) <= 50:
                        cereal = getCereal()
                        if (not cereal is None):
                            writeRecord(date, j, cereal['SKU'], cereal['BasePrice'], cereal['Product Name'],
                                        cereal['itemType'], cereal['ItemsLeft'],cereal['TotalCasesOrderd'])
                            k = k + 1
            else:
                if random.randrange(1, 100) <= 5:
                    cereal = getCereal()
                    if (not cereal is None):
                        writeRecord(date, j, cereal['SKU'], cereal['BasePrice'], cereal['Product Name'],
                                    cereal['itemType'], cereal['ItemsLeft'],cereal['TotalCasesOrderd'])
                        k = k + 1

            if random.randrange(1, 100) <= 30:
                jelly = getJelly()
                if (not jelly is None):
                    writeRecord(date, j, jelly['SKU'], jelly['BasePrice'], jelly['Product Name'], jelly['itemType'], jelly['ItemsLeft'],jelly['TotalCasesOrderd'])
                    k = k + 1
                    if random.randrange(1, 100) <= 50:
                        peanutButter = getPeanutButter()
                        if (not peanutButter is None):
                            writeRecord(date, j, peanutButter['SKU'], peanutButter['BasePrice'],
                                        peanutButter['Product Name'], peanutButter['itemType'], peanutButter['ItemsLeft'],peanutButter['TotalCasesOrderd'])
                            k = k + 1
                    if random.randrange(1, 100) <= 50:
                        bread = getBread()
                        if (not bread is None):
                            writeRecord(date, j, bread['SKU'], bread['BasePrice'], bread['Product Name'],
                                        bread['itemType'], bread['ItemsLeft'],bread['TotalCasesOrderd'])
                            k = k + 1

            for m in range(k, myItems):
                item = getRandomItem()
                writeRecord(date, j, item[4], item[5], item[1], str(item[3]), str(item[6]), str(item[7]))
        connection.commit()


def main():
    simulateGroceryData()
    connection.close()


main()
