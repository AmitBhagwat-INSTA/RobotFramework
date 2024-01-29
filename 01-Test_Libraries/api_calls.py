import requests
import time

# I don't think that the Authorization header is strictly required, but I have included this anyway as it was
# included in the original request shared with me.

head = {
    'Authorization': 'eyJraWQiOiJhenhQRkhQTmZkZVVqUHVUNHhzTWxObWo1dVJ4NUIxaDNLTERhanl1ekJJPSIsImFsZyI6IlJTMjU2In0.eyJzd'
                     'WIiOiI4MWI3MjU1MC0yMmNjLTQ5OTMtYWVjMy01NjVjNzczZDkyMDciLCJkZXZpY2Vfa2V5IjoiZXUtd2VzdC0xX2NmM2ViMT'
                     'lkLTE1ZTUtNDZlZC1hOWE3LTMzODEyMGNjOTljMSIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoiYXdzLmNvZ25pdG8'
                     'uc2lnbmluLnVzZXIuYWRtaW4iLCJhdXRoX3RpbWUiOjE2NTcwMDgyNzEsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5l'
                     'dS13ZXN0LTEuYW1hem9uYXdzLmNvbVwvZXUtd2VzdC0xX3IwVGxSSDBBaSIsImV4cCI6MTY1NzAxNTM0NiwiaWF0IjoxNjU3M'
                     'DE0NDQ2LCJqdGkiOiIwNTRlMmZjYS1iNjVlLTQ0NGQtODYwNS02OGQxZWYwMjI5MzQiLCJjbGllbnRfaWQiOiI2ajdqZ3B0Z2'
                     'R2b2NwMnJkZ3AwaTRibXVwaiIsInVzZXJuYW1lIjoiODFiNzI1NTAtMjJjYy00OTkzLWFlYzMtNTY1Yzc3M2Q5MjA3In0.iJ9'
                     '03x7FUVNdOJmYXboymGxymrO3MuRKeZc1sKzew0wBnKRDZ0tlYueGWG3DUnn_YeUCvZdEa0l7Da-IrKggzhUHUJqWdpAsFSk4'
                     'dNmYEsWAUSkNOE44vW7QfE6a6WZR33B_jA_RfyVUumzp8F-7TVUV26vLkpcAA7wfhOa6UqeD8tBCToEw54CrSkX1Pui4WXA36'
                     '5mgu_RBdUzr3whN2eo36y_VfVw0ZTFflPK0O9iRPDiWD2zuHTvBCPL6dVEaAeNtT0525Fpg2dWTxPZCCr502Q5W5T9rBwFKUy'
                     'e6uul2QsD7MCv8k1Fj5qt9VHOH3skpaz_aQQukWzxmWpHDmQ'
}

# Send a single post request to the CPO simulator to charge our vehicle. This can be used for tests where we only
# require a partial charge
def Start_Charge():
    response = requests.post("https://cpo.dev.emsp.instavolt.co.uk/ocpi/cpo/commands/scheduler", headers=head)

    print(response.status_code)
    print(response.json())

    assert response.status_code == 200

# Send post requests to the CPO simulator to charge our vehicle. This loops 5 times to perform a full charge
def Perform_Full_Charge():
    for i in range(5):
        response = requests.post("https://cpo.dev.emsp.instavolt.co.uk/ocpi/cpo/commands/scheduler", headers=head)

        print(response.status_code)
        print(response.json())

        assert response.status_code == 200

        time.sleep(6) # Wait so we can simulate a 'more realistic' charge that the system can handle


Perform_Full_Charge()
