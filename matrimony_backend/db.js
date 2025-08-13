const mongoose = require('mongoose');

const MONGOURL = "mongodb+srv://veerendrasoni0555:wmlBDQZgCXpqGGGo@cluster0.6ewtio5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

mongoose.connect(MONGOURL);

const db = mongoose.connection;

db.on('connected',()=>{
    console.log("DB Connected");
})

db.on('disconnected',()=>{
    console.log('DB disconnected');
})

module.exports = db;
