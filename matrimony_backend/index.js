const express = require('express');
const app = express();
const body_parser = require('body-parser');
const db = require('./db');
const authRouter = require('./routes/auth');
const partnerRoute = require('./routes/partner_route');
const otpRouter = require('./routes/otp_route');
const profilePicRouter = require('./routes/profile_pic');
const port = 3000;
app.use(body_parser.json());
app.use(partnerRoute);
app.use(authRouter);
app.use(otpRouter);
app.use(profilePicRouter);

app.get('/',(req,res)=>{
    res.send("Hello from backend");
})


app.listen(port,()=>{
    console.log("Server is connected");
})
