import threading
import MySQLdb as pymysql

insertArry = []


def populateItems():
    resultArray = []
    with open('/Users/johnathansaunders/Documents/fall_17/DataWarehousing-/ETL_Group/top25.txt') as f:
        content = f.readlines()
        lines = [line.rstrip('\n') for line in content]

        for i in range(0, len(lines)):
            newArry = str(lines[i]).split('\t')
            insertRecord(newArry[0], newArry[1], newArry[2], newArry[3], newArry[4], newArry[5], newArry[6],
                         newArry[7], )

    return resultArray


# sql command to for insert
salesSQL = ("SELECT `product_name` from `product_dimension`  where `sku`= %s ")


# makes connection for db
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


# addes inormation to arrary to inset to db when writeRecords() is called
def insertRecord(sku, q, w, e, r, t, y, u):
    connection = connectToDB()
    cur = connection.cursor()
    cur.execute("SELECT product_name from product_dimension  where sku=" + sku)

    for row in cur.fetchall():
        print row[0] + "," + sku + "," + q + "," + w + "," + e + "," + r + "," + t + "," + y + "," + u
    connection.close()


# writes information to server Database on ot


def main():
    populateItems()


main()
