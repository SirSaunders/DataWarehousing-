import threading
import MySQLdb as pymysql

insertArry = []


def populateItems():
    resultArray = []
    with open('Products2.txt') as f:
        content = f.readlines()
        lines = [line.rstrip('\n') for line in content]

        for i in range(0, len(lines) ):
            newArry = str(lines[i]).split('\t')
            insertRecord( newArry[4])

    return resultArray


# sql command to for insert
salesSQL = ("INSERT INTO `source_metadata` "
            "(`sku`,`source_key`) "
            "VALUES (%s, %s)")

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
def insertRecord( sku):
    # these can match how ever your schema is
    insertArry.append((sku, 0))


# writes information to server Database on other thread
def writeRecords():
    connection = connectToDB()
    connection.cursor().executemany(salesSQL, insertArry)
    connection.commit()
    connection.close()
    print'dB upload finished'
    insertArry[:] = []  # make insertArry empty


def main():
    populateItems()
    writeRecords()


main()
