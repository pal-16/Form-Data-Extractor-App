from flask import Flask,redirect,request
from flask_restful import Api,Resource
from flask_jwt import JWT
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'	
app.config['MYSQL_PASSWORD'] = '#'
app.config['MYSQL_DB']	= 'flutter'
mysql = MySQL(app)
api = Api(app)
class UserLogin(Resource):

   def get(self):
        data = request.get_json()
        email = data['email']
        password = data['password']
        print(email)
        string = "SELECT * FROM "+email+" WHERE email = '"+email+"' and password ='"+password+"' "
        cur = mysql.connection.cursor()
        cur.execute(string)
        email = cur.fetchall()
        print(email)
       
        return {"message": "User exists"}, 201

class UserRegister(Resource):

    
   def post(self):
      data = request.get_json()
       
      name = data['name']
      email = data['email']
      password = data['password']
      typee = data['type']
      emailt=''
      for i in email:
         if i == '@':
            break
         else:
            emailt=emailt+i
      print(emailt) 

      cur = mysql.connection.cursor()
      #palak="Create DATABASE if not exists "+emailt+" "
      #cur.execute(palak)
      print(email)
      temp="CREATE TABLE if not exists "+emailt+" (id int PRIMARY KEY AUTO_INCREMENT, email varchar(200), password varchar(200),type varchar(200))"
      cur.execute(temp)
      print("hello")
      #cur = mysql.connection.cursor()
      flag="INSERT INTO "+emailt+" (email,name,password,type) VALUES(%s,%s,%s,%s)"
      cur.execute(flag,(email,name,password,typee))
      mysql.connection.commit()
      
      return {"message": "User created successfully."}, 201

class Voice(Resource):

    
   def post(self):
      data = request.get_json()
      s=data                                 
      palak=s['data']
      print(palak)
      cur = mysql.connection.cursor()
      cur.execute('CREATE TABLE if not exists voice(myset varchar(2000))')
      for i in palak:
         print(i)
         sql = "INSERT INTO voice VALUES (%s)"
         cur.execute(sql,[i])
      mysql.connection.commit()
   
            
      return {"message": "voice done"}, 201


class RetrieveVoice(Resource):

    
   def get(self):
      #data = request.get_json()
      #email = data['email']
      #print(email)
      string = "SELECT * FROM voice"
      cur = mysql.connection.cursor()
      cur.execute(string)
      row = [item[0] for item in cur.fetchall()]
      #response = cur.fetchall()
      print("===========")
      print(row)
      ans={'data':row}
      print(ans)
      return ans

#jwt = JWT(app, authenticate, identity)
api.add_resource(UserRegister, '/register')
api.add_resource(UserLogin, '/login')
api.add_resource(Voice, '/voice')
api.add_resource(RetrieveVoice, '/getvoice')

app.run(debug=True,port=5000)