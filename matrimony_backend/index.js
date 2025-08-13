const express = require('express');
const app = express();
const body_parser = require('body-parser');
const db = require('./db');
const authRouter = require('./routes/auth');
const otpRouter = require('./routes/otp_route');
const port = 3000;
app.use(body_parser.json());
app.use(authRouter);
app.use(otpRouter);

app.listen(port,()=>{
    console.log("Server is connected");
})
