import threading
import MySQLdb as pymysql

updateBySubCatArry = []
updateByCatArry = []
updateCat2CatArry = []
updateSubCat2CatArry = []
updateCat2DepartArry =[]

def populateItems():
    resultArray = []
    with open('/Users/johnathansaunders/Documents/fall_17/DataWarehousing-/ETL_Group/product_class.txt') as f:
        content = f.readlines()
        lines = [line.rstrip('\n') for line in content]

        for i in range(0, len(lines) ):
            newArry = str(lines[i]).split('\t')
            updateBySubCat(newArry[0],newArry[1], newArry[2], newArry[3], newArry[4])
            updateByCat(newArry[0],newArry[1], newArry[2], newArry[3], newArry[4])
            updateCat2Cat(newArry[0],newArry[1], newArry[2], newArry[3], newArry[4])
            updateCSubat2Cat(newArry[0],newArry[1], newArry[2], newArry[3], newArry[4])
            updateDepart2Cat(newArry[0],newArry[1], newArry[2], newArry[3], newArry[4])
    return resultArray


# sql command to for update
exSQL = ("UPDATE `product_dimension` SET `product_class_id` = %s, `subcategory` = %s,`category`= %s,`department` = %s, `product_family` = %s"
            "WHERE `product_name` LIKE %s and `product_class_id` is null"
            )
exCat2CatSQL = ("UPDATE `product_dimension` SET `product_class_id` = %s, `subcategory` = %s,`category`= %s,`department` = %s, `product_family` = %s"
            "WHERE `category` LIKE %s and `product_class_id` is null"
            )





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
def updateBySubCat(product_class_id, product_subcategory, product_category, product_department, product_family):
    # these can match how ever your schema is
    updateBySubCatArry.append((product_class_id, product_subcategory, product_category, product_department, product_family, '%' + product_subcategory + "%"))

# addes inormation to arrary to inset to db when writeRecords() is called
def updateByCat(product_class_id, product_subcategory, product_category, product_department, product_family):
    # these can match how ever your schema is
    updateByCatArry.append((product_class_id, product_subcategory, product_category, product_department, product_family, '%' + product_category + "%"))

# addes inormation to arrary to inset to db when writeRecords() is called
def updateCat2Cat(product_class_id, product_subcategory, product_category, product_department, product_family):
    # these can match how ever your schema is
    updateCat2CatArry.append((product_class_id, product_subcategory, product_category, product_department, product_family, '%' + product_category + "%"))

# addes inormation to arrary to inset to db when writeRecords() is called
def updateCSubat2Cat(product_class_id, product_subcategory, product_category, product_department, product_family):

    updateSubCat2CatArry.append((product_class_id, product_subcategory, product_category, product_department, product_family, '%' + product_subcategory + '%'))

# addes inormation to arrary to inset to db when writeRecords() is called
def updateDepart2Cat(product_class_id, product_subcategory, product_category, product_department, product_family):

        updateCat2DepartArry.append((product_class_id, product_subcategory, product_category, product_department, product_family, '%' + product_department + '%'))



# writes information to server Database on other thread
def writeRecords():
    connection = connectToDB()
    connection.cursor().executemany(exSQL, updateBySubCatArry)
    connection.commit()
    connection.cursor().executemany(exSQL, updateByCatArry)
    connection.commit()
    connection.cursor().executemany(exCat2CatSQL, updateCat2CatArry)
    connection.commit()
    connection.cursor().executemany(exCat2CatSQL, updateSubCat2CatArry)
    connection.commit()
    connection.cursor().executemany(exCat2CatSQL, updateCat2DepartArry)
    connection.commit()
    connection.close()
    print'dB upload finished'
    updateBySubCatArry[:] = []  # make insertArry empty


def main():
    populateItems()
    writeRecords()


main()
