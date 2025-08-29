const express = require('express');
const partnerRoute = express.Router();
const User = require('../model/user');
const Interaction = require('../model/interaction')

partnerRoute.post('/api/reject',async(req,res)=>{
    try {
        const {userId,targetId} = req.body;
        await Interaction.findOneAndUpdate(
            {
                fromUser:userId,
                toUser:targetId,
                
            },
            {
                status:'rejected'
            },
            {
                new:true,
                upsert:true
            }
        )
        res.status(200).json({msg:"User Rejected"})
    } catch (error) {
        res.status(500).json({error:"Internal Server Error"})
        console.log(error)
    }
})





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