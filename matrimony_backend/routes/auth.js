const express = require('express');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const User = require('../model/user');

authRouter.post('/api/sign-up',async(req,res)=>{
    try {
        const {fullname,email,password} = req.body;
        if(!fullname || !email || !password){
            return res.status(400).json({msg:"Name or Email Or Password is missing!"});
        }
        const isUserExist = await User.findOne({email});
        if(isUserExist){
            return res.status(400).json({msg:"User already exist with this email"});
        }
        const hashedPassword = await bcrypt.hash(password,10);
        let newUser = new User(
            {
                fullname,
                email,
                password:hashedPassword
            }
        );
        newUser = await newUser.save();
        res.status(200).json(newUser);

    } catch (error) {
        console.log(error);
        res.json({error:"Internal Server Error"});
    }
});

authRouter.post('/api/sign-in',async(req,res)=>{
    try {
        const {email,password} = req.body;
        if(!email || !password){
            return res.status(400).json({msg:"email or password is missing"});
        }
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg:"User with this email didn't exist"});
        }
        const verified = await bcrypt.compare(password,user.password);
        if(!verified){
            return res.status(401).json({msg:"Password is invalid"});
        }
        const token = jwt.sign({id:user._id},"passwordKey");
        res.status(200).json({token,user:user._doc})

    } catch (error) {
        
    }
});


// OTP route



module.exports = authRouter;