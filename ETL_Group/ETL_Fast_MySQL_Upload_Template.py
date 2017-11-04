import threading
import MySQLdb as pymysql
insertArry = []
threadsAry = []

#sql command to for insert
salesSQL = ("INSERT INTO `john_transactions` "
            "(`date`, `customer_number`,`sku`,`price`,`product_name`,`itemType`,`items_left`,`total_cases_ordered` ) "
            "VALUES (%s, %s, %s, %s,%s,%s,%s,%s)")


#makes connection for db
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

#addes inormation to arrary to inset to db when writeRecords() is called
def insertRecord(date, j, SKU, price, product_Name, itemType, items_left, total_cases_ordered):
    #these can match how ever your schema is
    insertArry.append((long(date), long(j), long(SKU), float(price), product_Name, itemType, items_left, total_cases_ordered))

#writes information to server Database on other thread
def writeRecords():

    class MyThread(threading.Thread):
        def run(self):
            class execArry(object):
                arry = insertArry  # did this so nothing gets messed up when writing using another thread

            connection = connectToDB()
            connection.cursor().executemany(salesSQL, execArry.arry)
            connection.commit()
            connection.close()
            print'dB upload finished'


    thread = MyThread()
    threadsAry.append(thread) #store all threads in a list for idendification later
    thread.daemon = True
    thread.start()
    insertArry[:] = []  #make insertArry empty

def main():
    ##readYourData()

    #goes through list of threads and joins them
    #ensures we wait until they all finish
    for thread in threadsAry:
        thread.join()


main()