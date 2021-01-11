from flask import Flask,redirect,request
from flask_restful import Api,Resource
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'	
app.config['MYSQL_PASSWORD'] = ''    #password of local MySQL Database
app.config['MYSQL_DB']	= 'voiceforms'         # create a database as a part of admin side of the whole app

mysql = MySQL(app)
api = Api(app)

class AddFormFields(Resource):

   # AddFormFields class for the organizations to create their form 
   def post(self):
      #decode data
      data = request.get_json()      
      formFields=data['values']
      email = data['email']
      #database queries
      formname='voice'+ email.split("@")[0]
      cur = mysql.connection.cursor()
      temp="CREATE TABLE if not exists "+formname+" (id VARCHAR(300))" 
      cur.execute(temp)
      for i in formFields:
         print(i)
         query = "ALTER TABLE "+formname+" ADD {} VARCHAR(300)".format(i)
         cur.execute(query)
      mysql.connection.commit()           
      #return
      return {"message": "Added Form Fields"}, 201


class AddDataToForm(Resource):
   
   # AddDataToForm class for the users to add data to the respective forms of the organization
   def post(self):

      data = request.get_json() 
      ans=data['values']
      formname='voice'+data['email']
      cur = mysql.connection.cursor()
      string="Show columns from "+formname
      print(string)
      cur.execute(string)
      row = [item[0] for item in cur.fetchall()]
      #response = cur.fetchall()
      print(row)
      flag="INSERT INTO "+formname+" VALUES(%s,%s,%s,%s)"      
      cur.execute(flag,(ans[0],ans[1],ans[2],ans[3]))
      mysql.connection.commit()      
      return {"message": "voice done"}, 201


class RetrieveFormFields(Resource):

   # RetrieveFormFields for the internal working of voice enables forms to help in flutter route passing
   def post(self):
      data = request.get_json()
      formname = 'voice'+ data['formname']
      string="Show columns from "+formname
      print(string)
      cur = mysql.connection.cursor()
      cur.execute(string)
      row = [item[0] for item in cur.fetchall()]
      print(row)
      formfields={'data':row}
     
      return formfields

class Login(Resource):
   # Basic Authentication using Login and Register Class
   def post(self):
        data = request.get_json()
        email = data['email']
        password = data['password']
        typeOfUser=data['type']
        emailt=email.split("@")[0]
        string = "SELECT * FROM "+emailt+" WHERE email = '"+email+"' and password ='"+password+"' and type ='"+typeOfUser+"' "
        cur = mysql.connection.cursor()
        cur.execute(string)
        result = cur.fetchall()
        return {"message": "User exists", "result":result, "email":email, "type":typeOfUser}, 201

class Register(Resource):
   # Basic Authentican using Login and Register Class
   def post(self):
      data = request.get_json()  
      name = data['name']
      email = data['email']
      password = data['password']
      typee = data['type']
      emailt=email.split("@")[0]
      cur = mysql.connection.cursor()
      temp="CREATE TABLE if not exists "+emailt+" (id int PRIMARY KEY AUTO_INCREMENT,name varchar(200), email varchar(200), password varchar(200),type varchar(200))"
      cur.execute(temp)
      flag="INSERT INTO "+emailt+" (email,name,password,type) VALUES(%s,%s,%s,%s)"
      cur.execute(flag,(email,name,password,typee))
      mysql.connection.commit()
      return {"message": "User created successfully."}, 201



api.add_resource(Register, '/register')
api.add_resource(Login, '/login')
api.add_resource(AddFormFields, '/addformfields')
api.add_resource(RetrieveFormFields, '/getformfields')
api.add_resource(AddDataToForm, '/addformdetails')
app.run(debug=True,port=5000)