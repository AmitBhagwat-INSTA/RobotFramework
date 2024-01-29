import psycopg2
from sshtunnel import SSHTunnelForwarder

hostname = 'localhost'
database = 'emspdb'
username = 'EngAdmin'
pwd = 'S7pHXgZzrL8T'
port_id = 5436

# try:
#
#     with SSHTunnelForwarder(
#
#         ('3.11.227.139', 22),
#         ssh_private_key=r"C:\Users\OliverCattermole\OneDrive - Instavolt\Documents\eMSP\Putty keys\UAT UK\emsp-uat-private-key-UK.key",
#         remote_bind_address=('localhost', 5436)) as server:
#
#         server.start()
#         print("server connected")
#
#         conn = psycopg2.connect(
#             host = hostname,
#             dbname = database,
#             user = username,
#             password = pwd,
#             port = port_id)
#
#         cursor = conn.cursor()
#         cursor.execute("SELECT * FROM drivers")
#         result = cursor.fetchall()
#         print("Result Set: ","\n", result)
#
#     #conn.close()
# except Exception as error:
#     print(error)

# functions required:
# Amend a given driver balance (probably based on driver id)
# Not sure I need anything else atm.
# Think i would need a function that connects to the database, then I call this in subsequent functions...


# id = 648
# value = 1000
def Amend_Driver_Balance(driver_id, new_balance):
 try:
     conn = psycopg2.connect(
         host = hostname,
         dbname = database,
         user = username,
         password = pwd,
         port = port_id)


     #conn.close()
 except Exception as error:
     print(error)

 cursor = conn.cursor()

 cursor.execute("UPDATE driver_accounts SET current_balance = %s WHERE driver_id = %s", (new_balance, driver_id))
 conn.commit()
 print(cursor.rowcount, "record(s) affected")

 cursor.execute("SELECT current_balance FROM driver_accounts WHERE driver_id = %s", (driver_id,))
 result = cursor.fetchone()
 print("New balance: ","\n", result)

 conn.close()


#Amend_Driver_Balance(648, 800)

def Get_Driver_Id(email, federated_account_type=None): # Type can be null for non-federated accounts
    try:
        conn = psycopg2.connect(
            host=hostname,
            dbname=database,
            user=username,
            password=pwd,
            port=port_id)

        # conn.close()
    except Exception as error:
        print(error)

    cursor = conn.cursor()

    # Probs now need an if statement to say if fed account = none, run query where fed account = null
    if federated_account_type==None:
        cursor.execute("SELECT id FROM drivers WHERE email = %s AND federated_account_type IS NULL",
                       (email,))
        result = cursor.fetchall()
        print("Driver Id: ", "\n", result)
        return result

    else:
        cursor.execute("SELECT id FROM drivers WHERE email = %s AND federated_account_type = %s", (email, federated_account_type))
        result = cursor.fetchall()
        print("Driver Id: ", "\n", result)
        return result


Driver_Id = Get_Driver_Id("olivercattermole9@gmail.com", "Google")
Driver_Id = int(''.join(str(driver_id[0]) for driver_id in Driver_Id)) # Convert the single element of each tuple into an integer
#Driver_Id = int(Driver_Id[0])
print(Driver_Id)
print(type(Driver_Id))




# try:
#     conn = psycopg2.connect(
#         host = hostname,
#         dbname = database,
#         user = username,
#         password = pwd,
#         port = port_id)
#
#
#     #conn.close()
# except Exception as error:
#     print(error)

#cursor = conn.cursor()

# cursor.execute("SELECT * FROM drivers")
# result = cursor.fetchall()
# print("Result Set: ","\n", result)
