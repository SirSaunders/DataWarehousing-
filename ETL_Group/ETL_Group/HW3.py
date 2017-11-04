import random
import datetime
import threading
import pandas as pd
# import pymysql
import MySQLdb as pymysql
from copy import deepcopy



daysSupply = 127  # 85 3.5 days = 127
milkDaysSupply = 1218
breadDaysSupply = 1740
peanutButterSupply = 348
jellySupply = 487
cerealSupply = 1392
babyFoodSupply = 12992
diaperSupply = 2761

writeCnt = [0]

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
itemsDataFrame = pd.read_csv(
    'Products1.txt', sep="\t")
insertArry = []
uploadThreadsAry = []



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
babyFoodItems = getItemsFromItemType('Baby Food')
diaperItems = getItemsFromItemType('Diapers')
salesSQL = ("INSERT INTO `john_transactions` "
            "(`date`, `customer_number`,`sku`,`price`,`product_name`,`itemType`,`items_left`,`total_cases_ordered` ) "
            "VALUES (%s, %s, %s, %s,%s,%s,%s,%s)")


def connectToDB():
    try:
        db_url = '174.57.80.4'
        db_name = 'data_warehouse'
        user = 'GuestDW'
        password = 'pass'
        port = 13306

        conn = pymysql.connect(host=db_url, user=user, db=db_name, passwd=password, port=port, connect_timeout=5)
    except Exception, e:
        print("Couldn't do it: %s", e)
        raise Exception('Unable to connect to RDS')

    return conn


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


def insertRecord(date, j, SKU, price, product_Name, itemType, items_left, total_cases_ordered):
    writeCnt[0] += 1
    price = str(price).replace('$', '')
    insertArry.append(
        (long(date), long(j), long(SKU), float(price) * 1.1, product_Name, itemType, items_left, total_cases_ordered))


def writeRecords(arry):

    connection.cursor().executemany(salesSQL, arry)
    connection.commit()
    print'dB upload finished'
    print len(arry)





def checkSpecialItemSupply():
    checkSpecialItemsSupply(breadItems, breadDaysSupply)
    checkSpecialItemsSupply(cerealItems, cerealSupply)
    checkSpecialItemsSupply(peanutButterItems, peanutButterSupply)
    checkSpecialItemsSupply(jellyItems, jellySupply)
    checkSpecialItemsSupply(babyFoodItems, babyFoodSupply)
    checkSpecialItemsSupply(diaperItems, diaperSupply)


def myDate(i):
    s = str(2017) + str(i + 1)
    realDate = datetime.datetime.strptime(s, '%Y%j')
    date = str(realDate).replace('00:00:00', '').replace('-', '')
    checkResupply(realDate)
    print date
    # days of the week run monday = 0 through sunday = 6
    # returns date format and a bool that is true if its the weekend
    return [date, (realDate.weekday() == 5 or realDate.weekday() == 6)]


def checkResupply(date):
    # days of the week run monday = 0 through sunday = 6
    if (date.weekday() == 1 or date.weekday() == 3 or date.weekday() == 5):  # tues, thur, sat
        checkItemsSupply()
        checkSpecialItemSupply()
        # check milk supply everyday
    checkSpecialItemsSupply(milkItems, milkDaysSupply)

def getRandomItem():
    index = random.randrange(0, len(items))
    item = items[index]
    type = item[3]
    # if a special item or empty get a different item
    if (int(item[
                6]) < 1 or type == 'Milk' or type == 'Bread' or type == 'Jelly/Jam' or type == 'Cereal' or type == 'Peanut Butter'or type == 'Baby Food' or type == 'Diaper'):
        return getRandomItem()
    item[6] = str(int(item[6]) - 1)
    return item


def getSpecailItem(specialAry):
    try:
        if (itemsNotGone(specialAry)):
            rand = random.randrange(0, len(specialAry))
            item = specialAry[rand]
            if (int(item['ItemsLeft']) < 1):
                return getSpecailItem(specialAry)
            item['ItemsLeft'] = str(int(item['ItemsLeft']) - 1)
            return item
    except Exception, e:
        print(e)
    return None


def simulateGroceryData():

    cCustomersLo = 1140
    cCustomersHi = 1180
    cPriceMultiplier = 1.1
    cDate1 = 20170101
    cMaxItems = 100
    cWeekendIncrease = 50
    for i in range(0, 365):
        dateStuff = myDate(i)
        date = dateStuff[0]  # formated date
        # if weekend increase by 50 possible customers
        if dateStuff[1]:
            custCount = random.randrange(cCustomersLo, cCustomersHi + 50)
        else:
            custCount = random.randrange(cCustomersLo, cCustomersHi)

        for j in range(1, custCount):
            simulateCustomerPurchases(date, cMaxItems, j)
        if len(insertArry) > 4000000:
            writeRecords(insertArry)
            insertArry[:] = []  # make insertArry empty

def simulateCustomerPurchases(date, cMaxItems, j):
    k = 0
    myItems = random.randrange(1, cMaxItems)
    k = simulateCustomerSpecailPurchases(date, cMaxItems, j, k)

    for m in range(k, myItems):
        item = getRandomItem()
        insertRecord(date, j, item[4], item[5], item[1], str(item[3]), str(item[6]), str(item[7]))



def simulateCustomerSpecailPurchases(date, cMaxItems, j, k):
    if random.randrange(1, 100) <= 70:
        milk = getSpecailItem(milkItems)
        if (not milk is None):
            insertRecord(date, j, milk['SKU'], milk['BasePrice'], milk['Product Name'], milk['itemType'],
                         milk['ItemsLeft'], milk['TotalCasesOrderd'])
            k = k + 1
            if random.randrange(1, 100) <= 50:
                cereal = getSpecailItem(cerealItems)
                if (not cereal is None):
                    insertRecord(date, j, cereal['SKU'], cereal['BasePrice'], cereal['Product Name'],
                                 cereal['itemType'], cereal['ItemsLeft'], cereal['TotalCasesOrderd'])
                    k = k + 1
    else:
        if random.randrange(1, 100) <= 5:
            cereal = getSpecailItem(cerealItems)
            if (not cereal is None):
                insertRecord(date, j, cereal['SKU'], cereal['BasePrice'], cereal['Product Name'],
                             cereal['itemType'], cereal['ItemsLeft'], cereal['TotalCasesOrderd'])
                k = k + 1

    if random.randrange(1, 100) <= 10:
        peanutButter = getSpecailItem(peanutButterItems)
        if (not peanutButter is None):
            insertRecord(date, j, peanutButter['SKU'], peanutButter['BasePrice'],
                         peanutButter['Product Name'], peanutButter['itemType'],
                         peanutButter['ItemsLeft'], peanutButter['TotalCasesOrderd'])
            k = k + 1
            if random.randrange(1, 100) <= 90:
                jelly = getSpecailItem(jellyItems)
                if (not jelly is None):
                    insertRecord(date, j, jelly['SKU'], jelly['BasePrice'], jelly['Product Name'], jelly['itemType'],
                                 jelly['ItemsLeft'], jelly['TotalCasesOrderd'])
                    k = k + 1
    else:
        if random.randrange(1, 100) <= 5:
            jelly = getSpecailItem(jellyItems)
            if (not jelly is None):
                insertRecord(date, j, jelly['SKU'], jelly['BasePrice'], jelly['Product Name'], jelly['itemType'],
                                 jelly['ItemsLeft'], jelly['TotalCasesOrderd'])
                k = k + 1
    if random.randrange(1, 100) <= 50:
            bread = getSpecailItem(breadItems)
            if (not bread is None):
                insertRecord(date, j, bread['SKU'], bread['BasePrice'], bread['Product Name'],
                                 bread['itemType'], bread['ItemsLeft'], bread['TotalCasesOrderd'])
                k = k + 1
    if random.randrange(1, 100) <= 20:
          specialItem= getSpecailItem(babyFoodItems)
          if (not specialItem is None):
              insertRecord(date, j, specialItem['SKU'], specialItem['BasePrice'], specialItem['Product Name'],
                                 specialItem['itemType'], specialItem['ItemsLeft'], specialItem['TotalCasesOrderd'])
              k = k + 1
              if random.randrange(1, 100) <= 80:
                  specialItem = getSpecailItem(diaperItems)
                  if (not specialItem is None):
                      insertRecord(date, j, specialItem['SKU'], specialItem['BasePrice'], specialItem['Product Name'],
                                   specialItem['itemType'], specialItem['ItemsLeft'], specialItem['TotalCasesOrderd'])
                      k = k + 1
    else:
        if random.randrange(1, 100) <= 1:
            specialItem = getSpecailItem(diaperItems)
            if (not specialItem is None):
                insertRecord(date, j, specialItem['SKU'], specialItem['BasePrice'], specialItem['Product Name'],specialItem['itemType'], specialItem['ItemsLeft'], specialItem['TotalCasesOrderd'])
                k = k + 1

    return k

def main():
    checkItemsSupply()
    simulateGroceryData()
    # goes through list of threads and joins them
    # ensures we wait until they all finish
    writeRecords(insertArry)
    connection.close()
    print writeCnt

connection = connectToDB()
main()
