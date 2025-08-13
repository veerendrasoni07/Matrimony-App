const express = require('express');
const Otp = require('../model/otp');
const otpRouter = express.Router();
const crypto = require('crypto');
const nodemailer = require('nodemailer');
const User = require('../model/user');
const jwt = require('jsonwebtoken');
const { json } = require('body-parser');

otpRouter.post('/api/get-otp',async(req,res)=>{
    try {
        const {email} = req.body;

        if(!email) return res.status(400).json({msg:"email is missing"});

        const otp = crypto.randomInt(100000,999999);

        const user = await User.findOne({email});

        if(!user) return res.status(400).json({msg:"User with this email doesn't exist"});

        await Otp.create({
            email,
            otp,
            expiresAt: Date.now() + 5 *60*1000
        });

        const transport = nodemailer.createTransport(
            {
                service:'gmail',
                auth:{
                    user:'veerendrasoni0555@gmail.com',
                    pass:'zcyb nsgj fnoa gywg'
                }
            }
        );


        transport.sendMail({
            from:"<<App Name>>",
            to:email,
            subject:'Your Otp:',
            text:`Otp is ${otp}, It will expire within 5 minutes`
        });

        res.status(200).json({success:true,msg:'Otp is send'});

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

// verify the otp

otpRouter.post('/api/verify-otp',async(req,res)=>{
    try {
        const {email,otp} = req.body;
        if(!email || !otp){
            return res.status(400).json({msg:"email or otp is missing"});
        }
        const user = await User.findOne({email});
        if(!user) return res.status(401).json({msg:"User doesn't exist"});
        const otpExist = await Otp.findOne({otp}).sort({createdAt:-1});
        if(!otpExist) return res.status(400).json({success:false,msg:"Otp Not Found"});
        if(otp !== otpExist.otp) return res.status(400).json({success:false,msg:"Invalid Otp"});
        if(Date.now()>otpExist.expiresAt) return res.status(401).json({success:false,msg:"Otp expired"});
        await Otp.deleteMany({email});
        const token = jwt.sign({id:user._id},"passwordKey");
        res.status(200).json({token,user:user});
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});   
    }
});

module.exports = otpRouter;