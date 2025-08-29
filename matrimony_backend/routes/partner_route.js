const express = require('express');
const partnerRoute = express.Router();
const User = require('../model/user');
const Interaction = require('../model/interaction')

//  user --> remove suggestion(reject route) --> send request by right swipe (send-request route) --> 
//  accept request (accept-request route)


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
        // get all users which user already interacted with
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
        const alreadyRequested = await Interaction.findOne(
            {
                fromUser:senderId,
                toUser:receiverId,
            }
        );
        if(alreadyRequested) return res.status(400).json({msg:"Request Already Sent!"});
        await Interaction.create(
            {
                fromUser:senderId,
                toUser:receiverId,
                status:'pending'
            }
        )
        sender.sentRequest.push({
            to:receiver,
            status:'pending'
        })
        receiver.requests.push({
            from:senderId,
            status:'pending'
        })
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
        const alreadyAccepted = await Interaction.findOne(
            {
                fromUser:senderId,
                toUser:receiverId
            }
        )
        if(alreadyAccepted && alreadyAccepted.status == 'accepted'){
            return res.status(400).json({msg:"Request Already Accepted"})
        }
        
        await Interaction.findOneAndUpdate(
            {
                fromUser:senderId,
                toUser:receiverId
            },
            {
                status:'accepted'
            },
            {
                new:true,
                upsert:true
            }
        );


        // remove the from both sentRequest and request list and add to the connection
        sender.sentRequest = sender.sentRequest.filter(
            (req)=> req.to.toString() !== receiverId
        )

        receiver.requests = receiver.requests.filter(
            (req) => req.from.toString() !== senderId
        )

        // make connection
        sender.connections.push({
            friend:receiverId
        })

        receiver.connections.push(
            {
                friend:senderId
            }
        )
        
    
        res.status(200).json({msg:`${receiver.fullname} accepted your request`})

    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"})
    }
})

partnerRoute.post('/api/reject-request',async(req,res)=>{
    try {
        const {senderId,receiverId} = req.body;
        const sender = await User.findById(senderId);
        const receiver = await User.findById(receiverId);
        if( !sender || !receiver) return res.status(400).json({msg:"User not found"});
        const alreadyRejected = await Interaction.findOne(
            {
                fromUser:senderId,
                toUser:receiverId
            },
        );
        if(alreadyRejected && alreadyRejected.status == 'rejected'){
            return res.status(400).json({msg:"Already Rejected"})
        }
        await Interaction.findOneAndUpdate(
            {
                fromUser:senderId,
                toUser:receiverId
            },{
                status:'rejected'
            },
            {
                new:true,
                upsert:true
            }
        );
        // remove the request of person from request list
        receiver.requests = receiver.requests.filter(
            (req)=> req.from.toString() !== senderId
        )
        // remove the sent request from sentRequest list 
        sender.sentRequest = sender.sentRequest.filter(
            (req)=> req.to.toString() !== receiverId
        )

        res.status(200).json({msg:`Request from ${sender.fullname} is being rejected`});
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
});


// fetch all the requests 
partnerRoute.post('/api/all-requests',async(req,res)=>{
    try {
        const {userId} = req.body;
        const allRequests = await User.findById(userId);
        res.status(200).json({requests:allRequests.requests})
    } catch (error) {
        console.log(error);
        res.status(500).json({error:"Internal Server Error"});
    }
})


module.exports = partnerRoute;