const express = require('express');
const partnerRoute = express.Router();
const User = require('../model/user');

partnerRoute.get('/api/suggestion/:userId',async(req,res)=>{
    try {
        const {userId} = req.params;
        const exist = await User.findById(userId);
        if(!exist){
            return res.status(400).json({msg:"User not found"});
        }
        const suggestions = await User.find(
            {
                gender:{$ne:exist.gender},
            }
        );
        res.status(200).json(suggestions);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});

module.exports = partnerRoute;