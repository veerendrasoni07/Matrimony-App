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

partnerRoute.post('/api/accept',async(req,res)=>{
    try {
        const {userId,targetId} = req.body;
        await Interaction.findOneAndUpdate(
            {
                fromUser:userId,
                toUser:targetId
            },
            {
                status:'accepted'
            },
            {
                new:true
            }
        )
        res.status(200).json({msg:"Request is accepted"})
    } catch (error) {
        res.status(500).json({error:"Internal Server Error"})
        console.log(error)
    }
})


partnerRoute.get('/api/suggestion/:userId',async(req,res)=>{
    try {
        const {userId} = req.params;
        // get all users this user already interacted with
        const interacted = await Interaction.find({fromUser:userId}).select('toUser')
        const interactedIds = interacted.map(i=> i.toUser) // it contains list of ids which we already interacted with
        // now fetch suggestion
        const suggestions = await User.find({
            _id: {$nin:[...interactedIds,userId]} // excluding all the users which we already interacted with and itself also
        })
        res.status(200).json(suggestions);
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});



partnerRoute.post('/api/send-request',async(req,res)=>{
    try {
        const {senderId,receiverId} = req.body;
        if(senderId === receiverId) return res.status(400).json({msg:"You cannot send request to yourself"})
        const sender = await User.findById(senderId);
        const receiver = await User.findById(receiverId)
        if(!sender || !receiver) return res.status(400).json({msg:"User doesn't exist"});
        const alreadyRequested = await sender.sentRequest.find(
            (req)=> req.to.toString() === receiverId
        )
        if(alreadyRequested) return res.status(400).json({msg:"Request Already Sent!"});
        sender.sentRequest.push({to:receiverId,status:'pending'})
        receiver.requests.push({from:senderId,status:'pending'})
        res.status(200).json({msg:"Request is sent"})

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"})
    }
});


partnerRoute.post ('/api/accept-request',async(req,res)=>{
    try {
        const {senderId,receiverId} = req.body;
        const sender = await User.findById(senderId);
        const receiver = await User.findById(receiverId);
        if(!sender) return res.status(400).json({msg:"Sender not found"});
        if(!receiver) return res.status(400).json({msg:"Receiver not found"});
        const alreadyAccepted = receiver.requests.some(
            (req)=> req.from.toString() === senderId
        )
        
        // remove the request from the receiver's request list
        receiver.requests = receiver.requests.filter(
            (req) => req.from.toString() !== senderId
        )

        // remove the sent request from the sender's sent request list
        sender.sentRequest = sender.sentRequest.filter(
            (req) => req.to.toString() !== receiver
        )

        // add each other to connections
        sender.connections.push({friend:receiverId})
        receiver.connections.push({friend:senderId})

        res.status(200).json({msg:`${receiver.fullname} accepted your request`})

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"})
    }
})


module.exports = partnerRoute;