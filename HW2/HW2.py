import random
import datetime
import pandas as pd
import csv
#import pymysql
import MySQLdb as pymysql


def populateItems():
    resultArray = []
    with open('Products2.txt') as f:
        content = f.readlines()
        lines = [line.rstrip('\n') for line in content]

        for i in range(0, len(lines) - 1):
            newArry = str(lines[i]).split('|')
            resultArray.append(newArry)

    return resultArray


items = populateItems()
itemsDataFrame = pd.read_csv('Products1.txt', sep="|")


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
salesSQL = ("INSERT INTO `sales_2` "
            "(`date`, `customer_number`,`sku`,`price`,`product_name`,`itemType` ) "
            "VALUES (%s, %s, %s, %s,%s,%s)")


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


def getMilk():
    rand = random.randrange(0, len(milkItems) - 1)
    return milkItems[rand]


def writeRecord(date, j, SKU, price, product_Name, itemType):
    price = str(price).replace('$', '')
    connection.cursor().execute(salesSQL, (long(date), long(j), long(SKU), float(price) * 1.1, product_Name, itemType))

def myDate(i):
    s = str(2017) + str(i + 1)
    date = str(datetime.datetime.strptime(s, '%Y%j')).replace('00:00:00', '').replace('-', '')
    print date
    return date


def getCereal():
    rand = random.randrange(0, len(cerealItems) - 1)
    return cerealItems[rand]


def getRandomItem():
    index = random.randrange(0, len(items))
    return items[index]


def getBread():
    rand = random.randrange(0, len(breadItems) - 1)
    return breadItems[rand]


def getJelly():
    rand = random.randrange(0, len(jellyItems) - 1)
    return jellyItems[rand]


def getPeanutButter():
    rand = random.randrange(0, len(peanutButterItems) - 1)
    return peanutButterItems[rand]


def simulateGroceryData():
    cCustomersLo = 1140
    cCustomersHi = 1180
    cPriceMultiplier = 1.1
    cDate1 = 20170101
    cMaxItems = 100
    cWeekendIncrease = 50
    for i in range(0, 14):
        date = myDate(i);

        custCount = random.randrange(cCustomersLo, cCustomersHi, cWeekendIncrease)
        for j in range(1, custCount):
            k = 0
            myItems = random.randrange(1, cMaxItems)
            if random.randrange(1, 100) <= 70:
                milk = getMilk()

                writeRecord(date, j, milk['SKU'], milk['BasePrice'], milk['Product Name'], milk['itemType'])
                k = k + 1
                if random.randrange(1, 100) <= 50:
                    cereal = getCereal()
                    writeRecord(date, j, cereal['SKU'], cereal['BasePrice'], cereal['Product Name'], cereal['itemType'])
                    k = k + 1
            else:
                if random.randrange(1, 100) <= 5:
                    cereal = getCereal()
                    writeRecord(date, j, cereal['SKU'], cereal['BasePrice'], cereal['Product Name'], cereal['itemType'])
                    k = k + 1

            if random.randrange(1, 100) <= 30:
                jelly = getJelly()
                writeRecord(date, j, jelly['SKU'], jelly['BasePrice'], jelly['Product Name'], jelly['itemType'])
                k = k + 1
                if random.randrange(1, 100) <= 50:
                    peanutButter = getPeanutButter()
                    writeRecord(date, j, peanutButter['SKU'], peanutButter['BasePrice'],
                                peanutButter['Product Name'], peanutButter['itemType'])
                    k = k + 1
                if random.randrange(1, 100) <= 50:
                    bread = getBread()
                    writeRecord(date, j, bread['SKU'], bread['BasePrice'], bread['Product Name'], bread['itemType'])
                    k = k + 1

            for m in range(k, myItems):
                item = getRandomItem()
                writeRecord(date, j, item[4], item[5], item[1], str(item[3]))
        connection.commit()


def main():


    simulateGroceryData()

    connection.close()


main()
