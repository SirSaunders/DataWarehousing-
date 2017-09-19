import random
import datetime
import pandas as pd
import csv

items = pd.read_csv('Products1.txt', sep="|")


def getMilkSKU():
    pass


def getMilk():
    milkDf = items[(items['itemType'] == 'Milk')]
    index = random.randrange(0, milkDf.shape[0])

    return milkDf.iloc[index]


def writeRecord(date, j, SKU, price):
    fieldnames = ['Date', 'Customer #', 'SKU', 'Sale Price']
    with open('test.csv', 'a') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writerow({'Date': date, 'Customer #': j, 'SKU': SKU, 'Sale Price': price})
    pass


def myDate(i):
    s = str(2017) + str(i + 1)
    date = str(datetime.datetime.strptime(s, '%Y%j')).replace('00:00:00', '').replace('-', '')
    print date
    return date


def getCereal():
    cerealDf = items[(items['itemType'] == 'Cereal')]
    index = random.randrange(0, cerealDf.shape[0])

    return cerealDf.iloc[index]


def getRandomItem():
    index = random.randrange(0, items.shape[0])
    return items.iloc[index]


def simulateGroceryData():
    cCustomersLo = 90
    cCustomersHi = 1020
    cPriceMultiplier = 1.1
    cDate1 = 20170101
    cMaxItems = 70
    cWeekendIncrease = 50
    for i in range(0, 364):
        date = myDate(i);
        custCount = random.randrange(cCustomersLo, cCustomersHi, cWeekendIncrease)
        for j in range(1, cMaxItems):
            k = 0
            myItems = random.randrange(1, cMaxItems)
            if random.randrange(1, 100) <= 70:
                milk = getMilk()
                writeRecord(date, j, milk['SKU'], milk['BasePrice'])
                k = k + 1
                if random.randrange(1, 100) <= 50:
                    cereal = getCereal()
                    writeRecord(date, j, cereal['SKU'], cereal['BasePrice'])
                    k = k + 1
            else:
                if random.randrange(1, 100) <= 5:
                    cereal = getCereal()
                    writeRecord(date, j, cereal['SKU'], cereal['BasePrice'])
                    k = k + 1
            for m in range(k, cMaxItems):
                item = getRandomItem()
                writeRecord(date, j, item['SKU'], item['BasePrice'])


def main():
    simulateGroceryData()


main()
