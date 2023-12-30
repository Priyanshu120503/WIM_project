const express = require('express')
const mysql = require('mysql')
const cors = require('cors')
const bodyParser = require('body-parser')
require('dotenv').config()

const app = express();
app.use(cors())
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

console.log(process.env.password);

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: process.env.password,
  database: 'railwaydb'
})

connection.connect()


// --------------------- Server API ----------------------
app.post("/", async (req, res) => {
    const {fullName, gender, rollNumber, emailID, contact, dob, address, pinCode, sourceStation, 
      destinationStation, prevPassNumber, reEnterPrevPassNumber, oldPassExpiryDate,
      branch, academicYear, semester, passDuration, travelClass} = req.body

    let id;
    let concId;
    connection.query('INSERT INTO User(fullName, gender, emailID, contact, dob, address, pinCode) ' +
    'VALUES(?, ?, ?, ?, ?, ?, ?)', [fullName, gender, emailID, contact, dob.split('T')[0], address, pinCode], (err, result, fields) => {
        if (err) throw err

        id = result.insertId;
        console.log('The insert id is: ', result.insertId)
        
        connection.query('INSERT INTO Student VALUES(?, ?, ?, ?, ?)', 
        [id, rollNumber, academicYear, branch, semester], 
        (err, result, fields) => {
            if (err) throw err
    
            console.log('The insert id is: ', result.insertId)

            let date = new Date();
            connection.query('INSERT INTO Concession(UserID, sourceStation, destinationStation, prevPassNumber'+
            ', oldPassExpiryDate, appliedDate, passDuration, travelClass, status, remarks) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
            [id, sourceStation, destinationStation, prevPassNumber, oldPassExpiryDate.split('T')[0], date.toISOString().split('T')[0], passDuration, travelClass, 'pending', ''], 
            (err, result, fields) => {
                if (err) throw err
        
                concId = result.insertId;
                console.log('The insert id is: ', result.insertId)
                
                console.log('Here');
                res.json({
                    result: {
                      enrollmentNumber: concId
                    }
                });
            })
        })
    })

});

app.get("/:email", (req, res) => {
  const email = req.params.email
  connection.query("SELECT *"+ 
  " FROM User NATURAL JOIN Student NATURAL JOIN Concession"+
  " WHERE emailID=?"+
  " ORDER BY appliedDate DESC LIMIT 1",
  [email],
  (err, results, fields) => {
    if (err) throw err

    if(results.length === 0) {
      res.status(400).send('Bad Request');
    }
  
    console.log(results[0])
    res.send(results[0])
  });
})

app.listen(5000, () => {console.log("Server listening on port 5000.")});