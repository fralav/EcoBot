from flask import Flask, request
import mysql.connector
from mysql.connector import Error

try:
    connection = mysql.connector.connect(host='localhost',
                                         database='EcoBot_db',
                                         user='root',
                                         password='password')
    if connection.is_connected():
        db_Info = connection.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        
except Error as e:
    print("Error while connecting to MySQL", e)

app = Flask(__name__)

@app.route('/') # this is the home page route
@app.route('/webhook', methods=['POST'])


def webhook():
    req = request.get_json(silent=True, force=True)
    query_result = req.get('queryResult')
    intent = query_result.get('intent').get('displayName')

    if (intent == 'giorno_raccolta'):
        comune = query_result.get('parameters').get('comune')
        tipo_di_spazzatura = query_result.get('parameters').get('tipo_di_spazzatura')
        fulfillmentText = calcola_giorno_raccolta(comune, tipo_di_spazzatura)

    return {
            "fulfillmentText": fulfillmentText,
            "source": "webhookdata"
        }
    
def calcola_giorno_raccolta(comune, tipo_di_spazzatura):
    print("\nintent = giorno_raccolta\n  comune             = ", comune, "\n  tipo_di_spazzatura = ", tipo_di_spazzatura)
    query = "SELECT giorni.giorno FROM ((giorni_raccolta inner join comuni) inner join rifiuti) inner join giorni where comuni.id = giorni_raccolta.comune and rifiuti.id = giorni_raccolta.rifiuto and giorni_raccolta.giorno = giorni.id and comuni.comune = '" + comune + "' and rifiuti.rifiuto = '" + tipo_di_spazzatura + "';"
    cursor = connection.cursor()
    cursor.execute(query)
    result = [list[0] for list in cursor.fetchall()]
    print(result)
    index = 0
    giorni = ''
    while index < len(result):
        if index == 0:
            giorni = giorni + str(result[index])
        if index!= 0 and index < len(result)-1:
            giorni = giorni + ', ' + str(result[index])
        if index!=0 and index == len(result)-1:
            giorni = giorni + " e " + str(result[index])
        index = index + 1
    print("giorni : ", giorni)

    # scrivo l'articolo giusto
    if tipo_di_spazzatura == 'carta' or tipo_di_spazzatura == 'plastica e metalli':
        tipo_di_spazzatura = 'della ' + tipo_di_spazzatura
    if tipo_di_spazzatura == 'organico' or tipo_di_spazzatura == 'indifferenziato':
        tipo_di_spazzatura = "dell'" + tipo_di_spazzatura
    if tipo_di_spazzatura == 'vetro':
        tipo_di_spazzatura = 'del ' + tipo_di_spazzatura

    return ("A " + comune + ", la raccolta " + tipo_di_spazzatura + " cade di " + giorni + ".")
    

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=8080) # This line is required to run Flask on repl.it